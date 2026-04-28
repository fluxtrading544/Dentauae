"""
Diagnose and fix Medusa admin login issues.
Tests the login API directly from the VPS, resets password, verifies DB state.
Run: python fix_admin_login.py
"""
import sys, time
try:
    import paramiko
except ImportError:
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

VPS_HOST     = "76.13.254.103"
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"

ADMIN_EMAIL    = "admin@dentauae.com"
ADMIN_PASSWORD = "Admin@DentaUAE2024"   # new known password

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("✅ Connected\n")

def run(cmd, timeout=40, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

# ── Step 1: Test the login API directly from VPS ──────────────────────────────
print("=" * 60)
print("1️⃣  Testing login API directly (curl from VPS)...")
print("=" * 60)

code, login_out = run(
    f"""curl -s -X POST http://localhost:9000/auth/user/emailpass \\
  -H "Content-Type: application/json" \\
  -d '{{"email":"{ADMIN_EMAIL}","password":"supersecret"}}' | python3 -m json.tool 2>/dev/null || echo "raw:$?"
""", timeout=15)

print(f"\nWith 'supersecret':\n{login_out[:300]}\n")

# ── Step 2: Check what users exist in the DB ──────────────────────────────────
print("=" * 60)
print("2️⃣  Admin users in the database...")
print("=" * 60)
run("""docker exec dentauae-postgres-1 psql -U postgres -d medusa-dentalanti -c \
"SELECT id, email, created_at FROM public.\\\"user\\\" ORDER BY created_at DESC LIMIT 10;" """)

# ── Step 3: Check the identity table (Medusa v2 auth) ─────────────────────────
print("=" * 60)
print("3️⃣  Auth identities in the database (Medusa v2 uses separate auth table)...")
print("=" * 60)

# Medusa v2 stores auth separately in auth_identity table
run("""docker exec dentauae-postgres-1 psql -U postgres -d medusa-dentalanti -c \
"SELECT id, provider_identities FROM auth_identity LIMIT 10;" 2>/dev/null \
|| echo "(auth_identity table not found — checking alternative tables)"
""")

run("""docker exec dentauae-postgres-1 psql -U postgres -d medusa-dentalanti -c \
"SELECT tablename FROM pg_tables WHERE schemaname='public' AND tablename LIKE '%auth%' OR tablename LIKE '%user%';" """)

# ── Step 4: Reset password using Medusa CLI ───────────────────────────────────
print("=" * 60)
print(f"4️⃣  Resetting admin password to: {ADMIN_PASSWORD}")
print("=" * 60)

code, out = run(
    f'docker exec dentauae-backend-1 npx medusa user '
    f'--email "{ADMIN_EMAIL}" --password "{ADMIN_PASSWORD}" 2>&1',
    timeout=60
)
print(f"Result: {out[:400]}")

# ── Step 5: Test login again with new password ────────────────────────────────
print("=" * 60)
print("5️⃣  Testing login with new password...")
print("=" * 60)
time.sleep(2)

code, login_out2 = run(
    f"""curl -sv -X POST http://localhost:9000/auth/user/emailpass \\
  -H "Content-Type: application/json" \\
  -d '{{"email":"{ADMIN_EMAIL}","password":"{ADMIN_PASSWORD}"}}' 2>&1 | tail -30
""", timeout=15)

if "token" in login_out2.lower() or '"type"' in login_out2:
    print("✅ Login API returned a token — credentials are CORRECT!")
elif "401" in login_out2 or "unauthorized" in login_out2.lower():
    print("❌ Still getting 401 — auth module or DB issue")

    # Try creating user fresh
    print("\nTrying to create a brand-new admin user...")
    run(
        f'docker exec dentauae-backend-1 sh -c '
        f'"npx medusa user -e admin2@dentauae.com -p \'{ADMIN_PASSWORD}\' 2>&1"',
        timeout=60
    )
else:
    print(f"Response: {login_out2[:400]}")

# ── Step 6: Check backend auth module logs ────────────────────────────────────
print("=" * 60)
print("6️⃣  Recent backend logs (auth-related)...")
print("=" * 60)
run("cd /root/Dentauae && docker compose logs backend --tail=20 2>&1 | grep -i 'auth\\|error\\|warn' | tail -20")

print("\n" + "=" * 60)
print(f"""
  📋  Summary:
      Admin URL:   https://api.dentauae.com/app
      Email:       {ADMIN_EMAIL}
      Password:    {ADMIN_PASSWORD}

  If login still fails after this script, paste the output above
  and we will fix the root cause.
""")

client.close()
input("Press Enter to exit...")
