"""
DentaUAE - Re-enable Admin Panel
Pushes updated medusa-config.ts (admin enabled with backendUrl)
and rebuilds the backend.
Run: python enable_admin.py
"""
import sys, time, subprocess

try:
    import paramiko
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

VPS_HOST     = "76.13.254.103"
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"
REPO_DIR     = "/root/Dentauae"
LOCAL_DIR    = r"F:\dentalanti"

VPS_ENV = """POSTGRES_USER=postgres
POSTGRES_PASSWORD=DentaUAE_Secure_2024
POSTGRES_DB=medusa-dentalanti
JWT_SECRET=supersecret
COOKIE_SECRET=supersecret
STORE_CORS=https://dentauae.com,https://www.dentauae.com,http://localhost:3000
ADMIN_CORS=https://api.dentauae.com,https://dentauae.com,http://localhost:9000
AUTH_CORS=https://dentauae.com,https://www.dentauae.com,https://api.dentauae.com,http://localhost:3000,http://localhost:9000
MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_064df238affda70c81a72fcf01d8f2da8edf8e4136b95830ba5e4ebebc774b27
MEDUSA_ADMIN_ON_SERVER=false
STRIPE_API_KEY=sk_test_placeholder
STRIPE_WEBHOOK_SECRET=whsec_placeholder
NEXT_PUBLIC_STRIPE_KEY=pk_test_placeholder
S3_FILE_URL=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com/dentauae-media
S3_ACCESS_KEY_ID=803cfa209978c7106410e0aaa49a4ec5
S3_SECRET_ACCESS_KEY=422d5dee778706d4b95636ebd72f835ef44e4eb02d05fcaccbda8c1305f84980
S3_REGION=auto
S3_BUCKET=dentauae-media
S3_ENDPOINT=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com
"""

def ssh_run(client, cmd, timeout=120, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

def local(cmd):
    print(f"   $ {cmd}")
    r = subprocess.run(cmd, shell=True, cwd=LOCAL_DIR, capture_output=True, text=True)
    if r.stdout.strip(): print(f"   {r.stdout.strip()}")
    if r.returncode != 0 and r.stderr.strip(): print(f"   ⚠️  {r.stderr.strip()}")
    return r.returncode

print("=" * 60)
print("  🖥️  Enable Medusa Admin Panel")
print("=" * 60)

# ── Push to GitHub ────────────────────────────────────────────────────────
print("\n1️⃣  Pushing updated medusa-config.ts to GitHub...")
local("git add medusa-dentalanti/medusa-config.ts medusa-dentalanti/Dockerfile")
local('git commit -m "feat: re-enable admin panel with backendUrl for production"')
local("git push origin main")
print("   ✅ Pushed!")

# ── Connect to VPS ────────────────────────────────────────────────────────
print("\n2️⃣  Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"   ✅ Connected")

# ── Force pull ────────────────────────────────────────────────────────────
print("\n3️⃣  Pulling latest code on VPS...")
ssh_run(client, f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main")

# ── Restore .env ──────────────────────────────────────────────────────────
print("\n4️⃣  Restoring .env...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/.env", "w") as f:
    f.write(VPS_ENV)
sftp.close()
print("   ✅ .env restored")

# ── Rebuild backend ───────────────────────────────────────────────────────
print("\n5️⃣  Rebuilding backend with admin enabled...")
print("   (medusa build now compiles admin UI too — takes 10-15 min)\n")
ssh_run(client, f"cd {REPO_DIR} && docker compose stop backend", timeout=20)
code, out = ssh_run(client,
    f"cd {REPO_DIR} && docker compose build --no-cache backend 2>&1",
    timeout=1200)
if code != 0:
    print(f"❌ Build failed:\n{out[-500:]}")
    client.close()
    sys.exit(1)
print("   ✅ Build complete!")

# ── Start ─────────────────────────────────────────────────────────────────
print("\n6️⃣  Starting all containers...")
ssh_run(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)

# ── Poll ──────────────────────────────────────────────────────────────────
print("\n7️⃣  Waiting for backend...\n")
for attempt in range(1, 25):
    time.sleep(20)
    code, out = ssh_run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP! HTTP {status}")

        # Check admin route
        code, adm = ssh_run(client,
            "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8",
            show=False)
        print(f"       Admin (/app):  HTTP {adm.strip()}")

        print("\n" + "=" * 60)
        print("  🎉 DONE!")
        print("=" * 60)
        print("""
  🌐  https://dentauae.com            → Storefront
  ⚙️   https://api.dentauae.com        → Medusa API
  🖥️   https://api.dentauae.com/app    → Admin Panel
""")
        ssh_run(client, f"cd {REPO_DIR} && docker compose ps")
        break

    _, logs = ssh_run(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=3", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend-1" in l]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "..."
    icon = "⚠️ " if "error" in last.lower() else "⏳"
    print(f"[{ts}] {icon} Attempt {attempt}: {last[-80:]}")
else:
    ssh_run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=40")

client.close()
input("\nPress Enter to exit...")
