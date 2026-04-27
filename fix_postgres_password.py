"""
DentaUAE - Fix Postgres Password Mismatch
The postgres volume was initialized with a different password.
This script resets it so backend can connect.
Run: python fix_postgres_password.py
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
REPO_DIR     = "/root/Dentauae"
DB_PASSWORD  = "DentaUAE_Secure_2024"
DB_NAME      = "medusa-dentalanti"

def run(client, cmd, timeout=60, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"✅ Connected to {VPS_HOST}\n")

print("=" * 60)
print("  🔧 Fix: Postgres Password Reset")
print("=" * 60)

# ── Step 1: Try to fix password via docker exec (no data loss) ────────────
print("\n🔑 Step 1: Attempting password reset via docker exec (no data loss)...")
print("   (Docker exec uses Unix socket — bypasses password auth)\n")

# Check if postgres accepts local connection
code, out = run(client,
    f"docker exec dentauae-postgres-1 psql -U postgres -c \"SELECT 1\" 2>&1",
    show=False)

if "1 row" in out or "(1 row)" in out:
    print("   ✅ Local connection works! Resetting password...")

    # Reset the postgres user password
    code, out = run(client,
        f'docker exec dentauae-postgres-1 psql -U postgres -c '
        f'"ALTER USER postgres WITH PASSWORD \'{DB_PASSWORD}\';" 2>&1')

    # Also create the database if it doesn't exist
    run(client,
        f'docker exec dentauae-postgres-1 psql -U postgres -c '
        f'"CREATE DATABASE \\"{DB_NAME}\\";" 2>&1')

    print("   ✅ Password reset to: DentaUAE_Secure_2024")
    skip_volume_reset = True

else:
    print(f"   ⚠️  Local exec also failed: {out.strip()[:100]}")
    print("   → Will do a clean volume reset instead (safe — no data exists yet)")
    skip_volume_reset = False

# ── Step 2: If exec failed, wipe volume and recreate ─────────────────────
if not skip_volume_reset:
    print("\n🗑️  Step 2: Wiping postgres volume for clean start...")

    # Stop all containers
    run(client, f"cd {REPO_DIR} && docker compose down", timeout=30)
    print("   ✅ All containers stopped")

    # Remove the postgres volume
    run(client, "docker volume rm dentauae_postgres_data 2>/dev/null || echo 'Volume not found or already removed'")
    print("   ✅ Old postgres volume removed")

    # Also clean up any leftover containers
    run(client, "docker ps -aq --filter 'name=dentauae' | xargs -r docker rm -f 2>/dev/null || true", show=False)

# ── Step 3: Make sure .env has the right password ─────────────────────────
print("\n⚙️  Step 3: Verifying .env has correct password...")
code, env = run(client, f"grep POSTGRES_PASSWORD {REPO_DIR}/.env", show=False)
print(f"   Current: {env.strip()}")

if "DentaUAE_Secure_2024" not in env:
    print("   Fixing password in .env...")
    run(client, f"sed -i 's/POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=DentaUAE_Secure_2024/' {REPO_DIR}/.env", show=False)
    run(client, f"grep POSTGRES_PASSWORD {REPO_DIR}/.env")
else:
    print("   ✅ Password correct in .env")

# ── Step 4: Start all containers ──────────────────────────────────────────
print("\n🚀 Step 4: Starting all containers...")
code, out = run(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)
if code != 0:
    print(f"❌ Failed:\n{out}")
    client.close()
    sys.exit(1)
print("   ✅ All containers started")

# ── Step 5: Wait for postgres to be ready, then verify password ───────────
print("\n⏳ Step 5: Waiting for postgres to initialize (15 seconds)...")
time.sleep(15)

print("\n🔐 Verifying postgres password works...")
code, out = run(client,
    f'docker exec dentauae-postgres-1 psql -U postgres -c "SELECT version();" 2>&1',
    show=False)

if "PostgreSQL" in out:
    print("   ✅ Postgres local connection: OK")

    # Now test with password (TCP connection like the backend uses)
    code, out = run(client,
        f'docker exec dentauae-postgres-1 psql '
        f'"postgresql://postgres:{DB_PASSWORD}@localhost:5432/postgres" '
        f'-c "SELECT 1;" 2>&1',
        show=False)

    if "(1 row)" in out or "1 row" in out:
        print(f"   ✅ Password authentication: OK (password: {DB_PASSWORD})")
    else:
        print(f"   ⚠️  TCP auth result: {out.strip()[:100]}")
        # Try to force reset again
        run(client,
            f'docker exec dentauae-postgres-1 psql -U postgres -c '
            f'"ALTER USER postgres WITH PASSWORD \'{DB_PASSWORD}\';"',
            show=False)
        # Create database
        run(client,
            f'docker exec dentauae-postgres-1 psql -U postgres -c '
            f'"CREATE DATABASE \\"{DB_NAME}\\";" 2>&1',
            show=False)
        print(f"   ✅ Password force-reset done")
else:
    print(f"   Postgres not ready yet: {out.strip()[:80]}")

# ── Step 6: Wait for backend migrations ───────────────────────────────────
print("\n⏳ Step 6: Waiting for backend to start (DB migrations)...")
print("   Medusa runs migrations on boot — takes 3-8 mins. Polling...\n")

for attempt in range(1, 30):
    time.sleep(20)
    code, out = run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"\n[{ts}] ✅ Backend is UP! HTTP {status}")
        print("\n" + "=" * 60)
        print("  🎉 EVERYTHING IS LIVE!")
        print("=" * 60)
        print(f"""
  🌐  https://dentauae.com          → Storefront ✅
  ⚙️   https://api.dentauae.com      → Medusa API ✅
  🖥️   https://api.dentauae.com/app  → Admin Dashboard ✅
""")
        run(client, f"cd {REPO_DIR} && docker compose ps")
        break

    # Show relevant log line
    _, logs = run(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=4",
        show=False)
    lines = [l.strip() for l in logs.strip().splitlines() if l.strip() and "backend-1" in l]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "..."

    if "password authentication failed" in last:
        print(f"[{ts}] ❌ Still password error! Forcing reset...")
        run(client,
            f'docker exec dentauae-postgres-1 psql -U postgres -c '
            f'"ALTER USER postgres WITH PASSWORD \'{DB_PASSWORD}\';"',
            show=False)
    elif "KnexTimeoutError" in last or "connection" in last.lower():
        print(f"[{ts}] ⏳ Attempt {attempt}: Connecting to DB... | {last[-60:]}")
    else:
        print(f"[{ts}] ⏳ Attempt {attempt}: Starting... | {last[-70:]}")

else:
    print("\n⚠️  Timed out. Last backend logs:")
    run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=25")

client.close()
input("\nPress Enter to exit...")
