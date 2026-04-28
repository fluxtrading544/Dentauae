"""
fix_login_final.py
==================
Comprehensive Medusa v2 admin login repair.

Root causes addressed:
  1. auth_identity table entry missing (npx medusa user only writes to user table)
  2. session_cookie.secure: true blocking cookies on HTTP internal connections

Run: python fix_login_final.py
"""

import sys, time, json

try:
    import paramiko
except ImportError:
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

VPS_HOST     = "76.13.254.103"
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"
REPO_DIR     = "/root/Dentauae"

ADMIN_EMAIL    = "admin@dentauae.com"
ADMIN_PASSWORD = "Admin@DentaUAE2024"
DB_NAME        = "medusa-dentalanti"

print("=" * 65)
print("  🔧  Medusa v2 Admin Login Repair")
print("=" * 65)

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("✅ Connected to VPS\n")

def run(cmd, timeout=60, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

def psql(sql, timeout=20):
    cmd = f'docker exec dentauae-postgres-1 psql -U postgres -d "{DB_NAME}" -c "{sql}" 2>&1'
    return run(cmd, timeout=timeout)

# ── Step 1: Pull & rebuild (apply secure:false cookie fix) ───────────────────
print("1️⃣  Pulling latest config from GitHub...")
run(f"cd {REPO_DIR} && git pull origin main 2>&1", timeout=30)

print("\n2️⃣  Rebuilding backend (apply session_cookie.secure=false fix)...")
print("   This takes 5-10 minutes — please wait...\n")
code, out = run(
    f"cd {REPO_DIR} && docker compose build --no-cache backend 2>&1",
    timeout=900
)
if code != 0:
    print(f"❌ Build failed:\n{out[-800:]}")
    client.close(); sys.exit(1)
print("   ✅ Build complete\n")

print("3️⃣  Restarting backend...")
run(f"cd {REPO_DIR} && docker compose up -d backend 2>&1", timeout=60)
print("   Waiting 90s for backend to start...")
time.sleep(90)

# Check health
for attempt in range(1, 10):
    code2, h = run(
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    if h.strip() in ("200", "204"):
        print(f"   ✅ Backend healthy (HTTP {h.strip()})")
        break
    print(f"   ⏳ Attempt {attempt}: HTTP {h.strip()} — waiting 20s...")
    time.sleep(20)
else:
    print("   ⚠️  Backend may not be ready — continuing anyway")

# ── Step 2: Ensure user exists in user table ─────────────────────────────────
print("\n4️⃣  Checking / creating user record...")
_, u_out = psql(f"SELECT id, email FROM public.\\\"user\\\" WHERE email='{ADMIN_EMAIL}';")
print(u_out)

if "0 rows" in u_out or ADMIN_EMAIL not in u_out:
    print("   User not in DB — creating via medusa CLI...")
    run(
        f"docker exec dentauae-backend-1 sh -c "
        f"\"npx medusa user --email '{ADMIN_EMAIL}' --password '{ADMIN_PASSWORD}' 2>&1\"",
        timeout=90
    )
else:
    print("   ✅ User record exists")

# ── Step 3: Generate bcrypt hash and upsert auth_identity ────────────────────
print("\n5️⃣  Generating bcrypt hash for new password...")
hash_js = (
    "const b=require('bcrypt');"
    f"b.hash('{ADMIN_PASSWORD}',10).then(h=>process.stdout.write(h));"
)
code3, hash_out = run(
    f"docker exec dentauae-backend-1 node -e \"{hash_js}\"",
    timeout=30, show=False
)
pw_hash = hash_out.strip()
if not pw_hash.startswith("$2"):
    # fallback: try bcryptjs
    hash_js2 = (
        "const b=require('bcryptjs');"
        f"b.hash('{ADMIN_PASSWORD}',10).then(h=>process.stdout.write(h));"
    )
    code3, hash_out = run(
        f"docker exec dentauae-backend-1 node -e \"{hash_js2}\"",
        timeout=30, show=False
    )
    pw_hash = hash_out.strip()

if pw_hash.startswith("$2"):
    print(f"   ✅ Hash generated: {pw_hash[:20]}...")
else:
    print(f"   ⚠️  Hash generation failed: {hash_out[:200]}")
    print("   Trying medusa user command instead...")
    run(
        f"docker exec dentauae-backend-1 sh -c "
        f"\"npx medusa user --email '{ADMIN_EMAIL}' --password '{ADMIN_PASSWORD}' 2>&1\"",
        timeout=90
    )

print("\n6️⃣  Checking auth_identity table structure...")
_, tables_out = run(
    'docker exec dentauae-postgres-1 psql -U postgres -d "medusa-dentalanti" -c '
    '"\\\\d auth_identity" 2>&1 | head -30',
    show=True
)

print("\n7️⃣  Checking existing auth_identity entries...")
_, ai_out = psql(
    "SELECT id, provider_identities FROM auth_identity LIMIT 5;"
)
print(ai_out)

# Build the provider_identities JSON
provider_json = json.dumps([{
    "provider": "emailpass",
    "provider_identity_id": ADMIN_EMAIL,
    "hashed_password": pw_hash,
    "entity_id": ADMIN_EMAIL
}]).replace("'", "''")  # escape for SQL

print("\n8️⃣  Upserting auth_identity for admin user...")

# Check if auth_identity already has this email
_, check_ai = psql(
    f"SELECT id FROM auth_identity WHERE provider_identities::text LIKE '%{ADMIN_EMAIL}%' LIMIT 1;"
)

if "1 row" in check_ai or "rows" in check_ai and "0 rows" not in check_ai:
    # Update existing
    _, update_out = psql(
        f"UPDATE auth_identity "
        f"SET provider_identities = '{provider_json}'::jsonb "
        f"WHERE provider_identities::text LIKE '%{ADMIN_EMAIL}%' "
        f"RETURNING id;"
    )
    print(f"   Update result:\n{update_out}")
else:
    # Insert new auth_identity
    uid_js = "process.stdout.write(require('crypto').randomUUID())"
    _, uid_out = run(f"docker exec dentauae-backend-1 node -e \"{uid_js}\"", show=False)
    new_id = uid_out.strip() or f"auth_{ADMIN_EMAIL.replace('@','_')}"

    _, insert_out = psql(
        f"INSERT INTO auth_identity (id, provider_identities, created_at, updated_at) "
        f"VALUES ('{new_id}', '{provider_json}'::jsonb, NOW(), NOW()) "
        f"ON CONFLICT DO NOTHING RETURNING id;"
    )
    print(f"   Insert result:\n{insert_out}")

    # Also update the user table to reference the auth_identity if column exists
    psql(
        f"UPDATE public.\\\"user\\\" "
        f"SET password_hash='{pw_hash}' "
        f"WHERE email='{ADMIN_EMAIL}';"
    )

# ── Step 4: Test login via curl ───────────────────────────────────────────────
print("\n9️⃣  Testing login API directly from VPS...")
time.sleep(3)

code4, login_out = run(
    f"""curl -sv -X POST http://localhost:9000/auth/user/emailpass \\
  -H "Content-Type: application/json" \\
  -d '{{"email":"{ADMIN_EMAIL}","password":"{ADMIN_PASSWORD}"}}' 2>&1""",
    timeout=20
)

if "token" in login_out.lower() or '"type"' in login_out or '"access_token"' in login_out:
    print("\n   ✅ LOGIN SUCCESSFUL — token returned!")
elif "401" in login_out or "unauthorized" in login_out.lower():
    print("\n   ❌ Still 401 — trying alternative: update password_hash in user table + medusa user CLI")

    # Try medusa user CLI as last resort
    run(
        f"docker exec dentauae-backend-1 sh -c "
        f"\"npx medusa user --email '{ADMIN_EMAIL}' --password '{ADMIN_PASSWORD}' 2>&1\"",
        timeout=90
    )

    # Re-test
    time.sleep(5)
    code5, login_out2 = run(
        f"""curl -s -X POST http://localhost:9000/auth/user/emailpass \\
  -H "Content-Type: application/json" \\
  -d '{{"email":"{ADMIN_EMAIL}","password":"{ADMIN_PASSWORD}"}}' 2>&1""",
        timeout=15
    )
    if "token" in login_out2.lower() or '"access_token"' in login_out2:
        print("\n   ✅ LOGIN SUCCESSFUL after CLI reset!")
    else:
        print(f"\n   ❌ Still failing. Raw response:\n{login_out2[:500]}")
        print("\n   Showing recent backend auth logs:")
        run(f"cd {REPO_DIR} && docker compose logs backend --tail=30 2>&1 | grep -i 'auth\\|pass\\|error\\|401'")
else:
    print(f"\n   Response:\n{login_out[:400]}")

# ── Final summary ─────────────────────────────────────────────────────────────
print("\n" + "=" * 65)
print(f"""
  📋  Admin Login Details:
      URL:      https://api.dentauae.com/app
      Email:    {ADMIN_EMAIL}
      Password: {ADMIN_PASSWORD}

  If login STILL fails in the browser after this script:
    → Clear browser cookies for api.dentauae.com
    → Try in an incognito window
    → The curl test above shows the true auth status
""")

client.close()
input("Press Enter to exit...")
