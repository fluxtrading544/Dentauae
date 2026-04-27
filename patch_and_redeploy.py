"""
Quick patch: fix TypeScript type error then redeploy frontend + backend.
Run: python patch_and_redeploy.py
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
REDIS_URL=redis://redis:6379
"""

def ssh(client, cmd, timeout=120, show=True):
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

print("=" * 65)
print("  🔧  Patch: TypeScript fix + redeploy")
print("=" * 65)

print("\n1️⃣  Pushing fix to GitHub...")
local("git add src/lib/store.ts")
local('git commit -m "fix: make password required in StoreAuthEmailPassword (TypeScript strict)"')
rc = local("git push origin main")
if rc != 0:
    print("❌ Push failed"); sys.exit(1)
print("   ✅ Pushed!\n")

print("2️⃣  Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("   ✅ Connected\n")

print("3️⃣  Pulling latest code...")
ssh(client, f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main")

print("\n4️⃣  Restoring .env...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/.env", "w") as f:
    f.write(VPS_ENV)
sftp.close()
print("   ✅ .env written\n")

# Backend was already built in the previous run — only rebuild frontend
print("5️⃣  Rebuilding frontend (--no-cache)...")
code, out = ssh(client,
    f"cd {REPO_DIR} && docker compose build --no-cache frontend 2>&1",
    timeout=900)
if code != 0:
    print(f"\n❌ Frontend build FAILED:\n{out[-800:]}")
    client.close(); sys.exit(1)
print("   ✅ Frontend build done!\n")

print("6️⃣  Starting all containers...")
ssh(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)

print("\n7️⃣  Waiting for backend health...\n")
adm_status = "?"
status = "?"
for attempt in range(1, 25):
    time.sleep(20)
    code, out = ssh(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP — HTTP {status}")
        code, adm = ssh(client,
            "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8",
            show=False)
        adm_status = adm.strip()
        print(f"       Admin (/app): HTTP {adm_status}")
        break

    _, logs = ssh(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=3", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend" in l.lower()]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "…"
    print(f"[{ts}] ⏳ Attempt {attempt}: {last[-100:]}")

print("\n" + "=" * 65)
code_fe, fe = ssh(client,
    "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8",
    show=False)
print(f"""
  🌐  Storefront:  https://dentauae.com         HTTP {fe.strip()}
  ⚙️   Backend API: https://api.dentauae.com      HTTP {status}
  🖥️   Admin Panel: https://api.dentauae.com/app  HTTP {adm_status}
""")
ssh(client, f"cd {REPO_DIR} && docker compose ps")
client.close()
input("\nPress Enter to exit...")
