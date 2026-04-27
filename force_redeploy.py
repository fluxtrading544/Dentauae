"""
DentaUAE - Force redeploy: reset VPS repo + no-cache rebuild
Run: python force_redeploy.py
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

# The correct .env for VPS (preserved through git reset)
VPS_ENV = """# ── Database ────────────────────────────────────
POSTGRES_USER=postgres
POSTGRES_PASSWORD=DentaUAE_Secure_2024
POSTGRES_DB=medusa-dentalanti

# ── Medusa Backend Secrets ───────────────────────
JWT_SECRET=supersecret
COOKIE_SECRET=supersecret

# ── CORS Settings ────────────────────────────────
STORE_CORS=https://dentauae.com,https://www.dentauae.com,http://localhost:3000
ADMIN_CORS=https://api.dentauae.com,https://dentauae.com,http://localhost:9000
AUTH_CORS=https://dentauae.com,https://www.dentauae.com,https://api.dentauae.com,http://localhost:3000,http://localhost:9000

# ── Medusa Backend URL ───────────────────────────
MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_064df238affda70c81a72fcf01d8f2da8edf8e4136b95830ba5e4ebebc774b27
MEDUSA_ADMIN_ON_SERVER=false

# ── Stripe ───────────────────────────────────────
STRIPE_API_KEY=sk_test_placeholder
STRIPE_WEBHOOK_SECRET=whsec_placeholder
NEXT_PUBLIC_STRIPE_KEY=pk_test_placeholder

# ── Cloudflare R2 (Image Storage) ────────────────
S3_FILE_URL=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com/dentauae-media
S3_ACCESS_KEY_ID=803cfa209978c7106410e0aaa49a4ec5
S3_SECRET_ACCESS_KEY=422d5dee778706d4b95636ebd72f835ef44e4eb02d05fcaccbda8c1305f84980
S3_REGION=auto
S3_BUCKET=dentauae-media
S3_ENDPOINT=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com
"""

def run(client, cmd, timeout=60, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

print("=" * 60)
print("  🔄 Force Redeploy with Fixed Code")
print("=" * 60)

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"\n✅ Connected to {VPS_HOST}")

# ── Step 1: Stop containers ───────────────────────────────────────────────
print("\n1️⃣  Stopping containers...")
run(client, f"cd {REPO_DIR} && docker compose stop backend frontend", timeout=30)
print("   ✅ Stopped")

# ── Step 2: Force reset VPS repo to match GitHub ─────────────────────────
print("\n2️⃣  Force-resetting VPS repo to match GitHub...")
run(client, f"cd {REPO_DIR} && git fetch origin main")
run(client, f"cd {REPO_DIR} && git reset --hard origin/main")
print("   ✅ VPS code now matches GitHub")

# ── Step 3: Verify the fix is present ────────────────────────────────────
print("\n3️⃣  Verifying medusa-config.ts has the fix...")
code, out = run(client, f"grep -n 'disable' {REPO_DIR}/medusa-dentalanti/medusa-config.ts", show=False)
print(f"   {out.strip()}")
if "true" in out:
    print("   ✅ Fix confirmed: admin.disable = true")
else:
    print("   ⚠️  Fix not found — check GitHub push")

# ── Step 4: Restore .env (git reset wipes it) ────────────────────────────
print("\n4️⃣  Restoring .env file (not tracked by git)...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/.env", "w") as f:
    f.write(VPS_ENV)
sftp.close()
print("   ✅ .env restored")

# ── Step 5: Rebuild backend with --no-cache ───────────────────────────────
print("\n5️⃣  Rebuilding backend (--no-cache so fix is included)...")
print("   This takes 8-12 minutes — building fresh with admin disabled.\n")
code, out = run(client,
    f"cd {REPO_DIR} && docker compose build --no-cache backend 2>&1",
    timeout=900)
if code != 0:
    print(f"❌ Build failed:\n{out[-500:]}")
    client.close()
    sys.exit(1)
print("\n   ✅ Backend rebuilt successfully!")

# ── Step 6: Start everything ──────────────────────────────────────────────
print("\n6️⃣  Starting all containers...")
run(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)
print("   ✅ All containers started")

# ── Step 7: Poll backend health ───────────────────────────────────────────
print("\n7️⃣  Waiting for backend to come online...\n")

for attempt in range(1, 25):
    time.sleep(20)
    code, out = run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend is UP! HTTP {status}")

        # Nginx check
        code, ng = run(client,
            "curl -s -o /dev/null -w '%{http_code}' -H 'Host: api.dentauae.com' http://127.0.0.1:80/health --max-time 8",
            show=False)
        print(f"       Nginx→api.dentauae.com: HTTP {ng.strip()}")

        print("\n📦 Container status:")
        run(client, f"cd {REPO_DIR} && docker compose ps")

        print("\n" + "=" * 60)
        print("  🎉 FULLY DEPLOYED!")
        print("=" * 60)
        print("""
  🌐  https://dentauae.com          → Storefront ✅
  ⚙️   https://api.dentauae.com      → Medusa API ✅
  ⚙️   https://api.dentauae.com/health → Should return 200
""")
        break

    # Show log tail
    _, logs = run(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=4", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend-1" in l]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "starting..."

    if "error" in last.lower() or "Error" in last:
        print(f"[{ts}] ⚠️  Attempt {attempt}: {last[-80:]}")
    else:
        print(f"[{ts}] ⏳ Attempt {attempt}: {last[-80:]}")

else:
    print("\n⚠️  Timed out. Backend logs:")
    run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=40")

client.close()
input("\nPress Enter to exit...")
