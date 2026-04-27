"""
DentaUAE – Master Deploy Script
Pushes all bug fixes to GitHub and deploys them on the VPS in one command.

Fixes included in this deploy:
  1. S3 endpoint env var mismatch (S3_URL → S3_ENDPOINT) — images were silently failing
  2. Cloudflare R2 image domain added to next.config.ts
  3. Admin panel CSP hardcoded localhost → reads MEDUSA_BACKEND_URL from env
  4. Redis now properly wired in medusa-config.ts (no more fake in-memory fallback)
  5. Dockerfile: robust admin file copy (detects .medusa/server/public OR .medusa/client)
  6. docker-compose: health checks + proper startup order (Postgres ready before backend)
  7. Region caching: eliminates 4+ redundant API calls per page load
  8. Auth middleware: correct Medusa v2 cookie names
  9. Related products: server-side category filter instead of fetching ALL products
  10. Customer registration: auto-login after register

Run:  python deploy_fixes.py
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

# ── Canonical VPS .env ────────────────────────────────────────────────────────
# FIX: Standardised to S3_ENDPOINT (consistent with medusa-config.ts fix)
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

def run_ssh(client, cmd, timeout=120, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

def run_local(cmd):
    print(f"   $ {cmd}")
    r = subprocess.run(cmd, shell=True, cwd=LOCAL_DIR, capture_output=True, text=True)
    if r.stdout.strip(): print(f"   {r.stdout.strip()}")
    if r.returncode != 0 and r.stderr.strip(): print(f"   ⚠️  {r.stderr.strip()}")
    return r.returncode

print("=" * 65)
print("  🚀  DentaUAE – Deploy All Bug Fixes")
print("=" * 65)

# ── 1. Push to GitHub ─────────────────────────────────────────────────────────
print("\n1️⃣  Pushing all fixes to GitHub...")
run_local("git add -A")
run_local('git commit -m "fix: comprehensive bug fixes - S3 endpoint, R2 images, CSP, Redis, health checks, region cache, auth cookies, related products, registration flow"')
rc = run_local("git push origin main")
if rc != 0:
    print("❌ Git push failed. Check credentials and try again.")
    sys.exit(1)
print("   ✅ Pushed!\n")

# ── 2. Connect to VPS ─────────────────────────────────────────────────────────
print("2️⃣  Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("   ✅ Connected\n")

# ── 3. Pull latest code ───────────────────────────────────────────────────────
print("3️⃣  Pulling latest code on VPS...")
run_ssh(client, f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main")

# ── 4. Restore .env ───────────────────────────────────────────────────────────
print("\n4️⃣  Writing .env (with S3_ENDPOINT fix + REDIS_URL)...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/.env", "w") as f:
    f.write(VPS_ENV)
sftp.close()
print("   ✅ .env written\n")

# ── 5. Stop old containers ────────────────────────────────────────────────────
print("5️⃣  Stopping running containers...")
run_ssh(client, f"cd {REPO_DIR} && docker compose down", timeout=30)

# ── 6. Rebuild backend (no cache) ─────────────────────────────────────────────
print("\n6️⃣  Rebuilding backend image (--no-cache, takes 10-15 min)...")
print("   This will also show the .medusa directory tree so we can confirm admin files.\n")
code, out = run_ssh(client,
    f"cd {REPO_DIR} && docker compose build --no-cache backend 2>&1",
    timeout=1200)
if code != 0:
    print(f"\n❌ Backend build FAILED. Last output:\n{out[-1000:]}")
    client.close()
    sys.exit(1)
print("   ✅ Backend build complete!\n")

# ── 7. Rebuild frontend (no cache) ────────────────────────────────────────────
print("7️⃣  Rebuilding frontend image (--no-cache)...")
code, out = run_ssh(client,
    f"cd {REPO_DIR} && docker compose build --no-cache frontend 2>&1",
    timeout=900)
if code != 0:
    print(f"\n❌ Frontend build FAILED. Last output:\n{out[-500:]}")
    client.close()
    sys.exit(1)
print("   ✅ Frontend build complete!\n")

# ── 8. Start all services ─────────────────────────────────────────────────────
print("8️⃣  Starting all containers...")
run_ssh(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)
print()

# ── 9. Poll backend health ────────────────────────────────────────────────────
print("9️⃣  Waiting for backend to be healthy...\n")
admin_ok = False
for attempt in range(1, 30):
    time.sleep(20)
    code, out = run_ssh(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP — HTTP {status}")

        code_adm, adm = run_ssh(client,
            "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8",
            show=False)
        adm_status = adm.strip()
        print(f"       Admin (/app): HTTP {adm_status}")
        if adm_status in ("200", "301", "302"):
            admin_ok = True
        break

    _, logs = run_ssh(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=5", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend" in l.lower()]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "…"
    icon = "❌" if "error" in last.lower() or "could not find" in last.lower() else "⏳"
    print(f"[{ts}] {icon} Attempt {attempt}: {last[-100:]}")
else:
    print("\n⏱️  Timed out. Showing backend logs:")
    run_ssh(client, f"cd {REPO_DIR} && docker compose logs backend --tail=60")

# ── 10. Final summary ─────────────────────────────────────────────────────────
print("\n" + "=" * 65)
code_fe, out_fe = run_ssh(client,
    "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8",
    show=False)

print(f"""
  🌐  Storefront:  https://dentauae.com          HTTP {out_fe.strip()}
  ⚙️   Backend API: https://api.dentauae.com       HTTP {status if 'status' in dir() else '?'}
  🖥️   Admin Panel: https://api.dentauae.com/app   HTTP {adm_status if 'adm_status' in dir() else '?'}
""")

if admin_ok:
    print("  🎉 ALL SYSTEMS GREEN — including admin panel!")
else:
    print("  ℹ️  Backend is up. If admin still shows an error, run the diagnostics below:")
    print("     python find_admin_outdir.py")

print()
run_ssh(client, f"cd {REPO_DIR} && docker compose ps")
client.close()
input("\nPress Enter to exit...")
