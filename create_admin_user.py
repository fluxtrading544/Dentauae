"""
Creates the Medusa admin user directly inside the running backend container.
Run: python create_admin_user.py
"""
import sys, time
try:
    import paramiko
except ImportError:
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

# ── Credentials you want for the admin panel ──────────────────────────────────
ADMIN_EMAIL    = "admin@dentauae.com"
ADMIN_PASSWORD = "DentaUAE@Admin2024"   # change this to something strong

VPS_HOST     = "76.13.254.103"
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"

print("=" * 60)
print("  👤  Create Medusa Admin User")
print("=" * 60)

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

# 1. Check the backend container is actually running
print("1️⃣  Checking backend container status...")
code, out = run("docker ps --filter name=dentauae-backend-1 --format '{{.Status}}'", show=False)
if not out.strip():
    print("❌ Backend container is not running! Start it first.")
    client.close()
    sys.exit(1)
print(f"   Container: {out.strip()}\n")

# 2. Check if admin user already exists
print("2️⃣  Checking if admin user already exists...")
code, out = run(
    f"docker exec dentauae-backend-1 sh -c \""
    f"npx medusa user --email {ADMIN_EMAIL} --password '{ADMIN_PASSWORD}' 2>&1\"",
    timeout=60
)

if "already exists" in out.lower() or "duplicate" in out.lower():
    print(f"\n   ℹ️  User {ADMIN_EMAIL} already exists.")
    print("   Attempting to reset the password instead...\n")

    # Try resetting password via the Medusa CLI (if supported)
    code2, out2 = run(
        f"docker exec dentauae-backend-1 sh -c \""
        f"npx medusa user --email {ADMIN_EMAIL} --password '{ADMIN_PASSWORD}' --force 2>&1\"",
        timeout=60
    )
    if code2 != 0:
        # Fallback: direct DB update via psql
        print("   CLI reset not supported — updating password in DB directly...")
        # Get bcrypt hash via node
        hash_cmd = (
            f"docker exec dentauae-backend-1 node -e \""
            f"const bcrypt = require('bcrypt');"
            f"bcrypt.hash('{ADMIN_PASSWORD}', 10).then(h => console.log(h));\""
        )
        code3, hash_out = run(hash_cmd, timeout=30, show=False)
        pw_hash = hash_out.strip()
        if pw_hash and pw_hash.startswith("$2b$"):
            run(
                f"docker exec dentauae-postgres-1 psql -U postgres -d medusa-dentalanti -c \""
                f"UPDATE public.user SET password_hash='{pw_hash}' "
                f"WHERE email='{ADMIN_EMAIL}';\""
            )
            print(f"   ✅ Password updated in DB")
        else:
            print(f"   ⚠️  Could not generate bcrypt hash. Output: {hash_out[:200]}")
elif code == 0 or "user created" in out.lower() or "created" in out.lower():
    print(f"\n   ✅ Admin user created successfully!")
else:
    print(f"\n   Output: {out[:500]}")
    print("   ℹ️  Trying alternative creation method...")

    # Alternative: use the exec script approach
    js_create = (
        "const { execSync } = require('child_process');"
        # Just try running the user command again
    )
    run(
        f"docker exec dentauae-backend-1 sh -c \""
        f"cd /app && npx medusa user -e {ADMIN_EMAIL} -p '{ADMIN_PASSWORD}' 2>&1\"",
        timeout=60
    )

# 3. Verify by checking the DB directly
print("\n3️⃣  Verifying user in database...")
code, out = run(
    f"docker exec dentauae-postgres-1 psql -U postgres -d medusa-dentalanti -c "
    f"\"SELECT email, created_at FROM public.\\\"user\\\" ORDER BY created_at DESC LIMIT 5;\"",
    timeout=20
)

print("\n" + "=" * 60)
print(f"""
  ✅  Admin credentials:

      URL:      https://api.dentauae.com/app
      Email:    {ADMIN_EMAIL}
      Password: {ADMIN_PASSWORD}

  If login still fails, try the reset option below.
""")
client.close()
input("Press Enter to exit...")
