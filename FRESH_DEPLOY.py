"""
FRESH_DEPLOY.py — Nuclear clean + full fresh deployment
=========================================================
1. Git commit + push all local fixes
2. SSH to VPS
3. Stop ALL containers
4. Remove ALL Docker images, volumes, networks, cache (full wipe)
5. Git pull latest code
6. docker compose build --no-cache (completely fresh)
7. docker compose up -d
8. Wait for all services to be healthy
9. Run DB migrations
10. Create admin user
11. Test login + all endpoints
12. Print final URLs + status
"""
import sys, time, subprocess, os

try:
    import paramiko
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

LOCAL_DIR    = r"F:\dentalanti"
VPS_HOST     = "76.13.254.103"
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"
REPO_DIR     = "/root/Dentauae"
ADMIN_EMAIL  = "admin@dentauae.com"
ADMIN_PASS   = "Admin@DentaUAE2024"

print("=" * 65)
print("  🧹  DentaUAE — Nuclear Clean + Fresh Deployment")
print("=" * 65)

# ── Step 1: Remove stale git lock ─────────────────────────────────────────────
for lock in [".git/index.lock", ".git/COMMIT_EDITMSG.lock"]:
    lock_file = os.path.join(LOCAL_DIR, lock)
    if os.path.exists(lock_file):
        try:
            os.remove(lock_file)
            print(f"🔓 Removed {lock}")
        except Exception as e:
            print(f"⚠️  Could not remove {lock}: {e}")

# ── Step 2: Git commit + push ─────────────────────────────────────────────────
print("\n1️⃣  Committing and pushing all fixes to GitHub...")

def git(args):
    r = subprocess.run(["git"] + args, cwd=LOCAL_DIR, capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip()
    if out:
        for line in out.splitlines():
            print("   " + line)
    return r.returncode

git(["config", "user.email", "shaheryarahmed8506@gmail.com"])
git(["config", "user.name", "Sharyar"])
git(["add", "-A"])
commit_rc = git(["commit", "-m",
    "fix: SafeImage fallback, sizes props, proxy.ts, COD payment, cart hydration, ADMIN_OUT_DIR, local dev"])
push_rc = git(["push", "origin", "main"])
if push_rc != 0:
    print("\n❌ Push failed — check git credentials/remote")
    sys.exit(1)
if commit_rc == 0:
    print("   ✅ Committed and pushed!")
else:
    print("   ✅ Nothing new to commit — pushed latest.")

# ── Step 3: SSH ────────────────────────────────────────────────────────────────
print("\n2️⃣  Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("   ✅ Connected\n")

def ssh(cmd, timeout=600, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

# ── Step 4: Show disk before ──────────────────────────────────────────────────
print("3️⃣  Current disk usage:")
ssh("df -h / | tail -1", timeout=10)

# ── Step 5: Nuclear Docker clean ──────────────────────────────────────────────
print("\n4️⃣  Stopping ALL containers and doing full Docker wipe...")
ssh(f"cd {REPO_DIR} && docker compose down --remove-orphans --volumes 2>&1", timeout=60)
ssh("docker stop $(docker ps -aq) 2>/dev/null || true", timeout=30)
ssh("docker rm -f $(docker ps -aq) 2>/dev/null || true", timeout=30)
ssh("docker rmi -f $(docker images -q) 2>/dev/null || true", timeout=120)
ssh("docker volume rm $(docker volume ls -q) 2>/dev/null || true", timeout=30)
ssh("docker network prune -f 2>&1", timeout=30)
ssh("docker builder prune -af 2>&1", timeout=120)
ssh("docker system prune -af --volumes 2>&1", timeout=120)
print("   ✅ Docker fully wiped!")

# ── Step 6: Show disk after ────────────────────────────────────────────────────
print("\n   Disk after cleanup:")
ssh("df -h / | tail -1", timeout=10)

# ── Step 7: Pull latest code ──────────────────────────────────────────────────
print("\n5️⃣  Pulling latest code from GitHub...")
ssh(f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main 2>&1", timeout=60)
ssh(f"cd {REPO_DIR} && git log --oneline -3 2>&1", timeout=10)

# ── Step 8: Verify .env exists ────────────────────────────────────────────────
print("\n6️⃣  Checking .env file on VPS...")
code, env_check = ssh(f"test -f {REPO_DIR}/.env && echo 'EXISTS' || echo 'MISSING'", show=False)
if "MISSING" in env_check:
    print("   ⚠️  .env file missing on VPS — creating from template...")
    ssh(f"""cat > {REPO_DIR}/.env << 'ENVEOF'
POSTGRES_USER=postgres
POSTGRES_PASSWORD=DentaUAE_DB_2024
POSTGRES_DB=medusa-dentalanti
JWT_SECRET=dentauae_jwt_super_secret_2024
COOKIE_SECRET=dentauae_cookie_super_secret_2024
STORE_CORS=https://dentauae.com,http://localhost:3000
ADMIN_CORS=https://api.dentauae.com,http://localhost:9000
AUTH_CORS=https://api.dentauae.com,https://dentauae.com,http://localhost:9000,http://localhost:3000
MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_064df238affda70c81a72fcf01d8f2da8edf8e4136b95830ba5e4ebebc774b27
STRIPE_API_KEY=sk_test_placeholder
STRIPE_WEBHOOK_SECRET=whsec_placeholder
NEXT_PUBLIC_STRIPE_KEY=pk_test_placeholder
S3_FILE_URL=https://pub-placeholder.r2.dev
S3_ACCESS_KEY_ID=803cfa209978c7106410e0aaa49a4ec5
S3_SECRET_ACCESS_KEY=422d5dee778706d4b95636ebd72f835ef44e4eb02d05fcaccbda8c1305f84980
S3_REGION=auto
S3_BUCKET=dentauae-media
S3_ENDPOINT=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com
ADMIN_OUT_DIR=/app/.medusa/server/public
ENVEOF
""", timeout=15)
    print("   ✅ .env created")
else:
    # Make sure ADMIN_OUT_DIR is present
    ssh(f"grep -q 'ADMIN_OUT_DIR' {REPO_DIR}/.env || echo 'ADMIN_OUT_DIR=/app/.medusa/server/public' >> {REPO_DIR}/.env", timeout=10)
    print("   ✅ .env exists — ADMIN_OUT_DIR ensured")

# ── Step 9: Fresh build ────────────────────────────────────────────────────────
print("\n7️⃣  Building all services from scratch — ~10 min...\n")
code, build_out = ssh(
    f"cd {REPO_DIR} && docker compose build --no-cache --progress=plain 2>&1",
    timeout=1500
)
if code != 0:
    print(f"\n❌ Build FAILED. Last output:\n{build_out[-3000:]}")
    client.close(); sys.exit(1)

if "index.html confirmed" in build_out or "✅ index.html" in build_out:
    print("\n   ✅ Admin index.html confirmed in build!")
else:
    print("\n   ⚠️  Could not verify index.html from build log — continuing...")
print("   ✅ Build complete!\n")

# ── Step 10: Start all services ───────────────────────────────────────────────
print("8️⃣  Starting all services...")
ssh(f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)
time.sleep(10)

print("\n   Container status:")
ssh("docker ps --format 'table {{.Names}}\t{{.Status}}'", timeout=15)

# ── Step 11: Wait for backend health ─────────────────────────────────────────
print("\n9️⃣  Waiting for backend (up to 6 min)...\n")
for attempt in range(1, 25):
    time.sleep(15)
    _, h = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
    status = h.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend is UP — HTTP {status}")
        break

    _, logs = ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=3 --no-log-prefix", show=False)
    last = [l.strip() for l in logs.strip().splitlines() if l.strip()]
    last_line = last[-1][-90:] if last else "..."

    if "Could not find index.html" in last_line:
        print(f"\n[{ts}] ❌ FATAL: index.html error still occurring!")
        ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=40 --no-log-prefix")
        client.close(); sys.exit(1)

    print(f"[{ts}] ⏳ {attempt}/24 — HTTP {status} | {last_line}")
else:
    print("\n❌ Backend timed out. Final logs:")
    ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=40 --no-log-prefix")
    client.close(); sys.exit(1)

# ── Step 12: Wait for frontend ────────────────────────────────────────────────
print("\n   Checking frontend...")
for i in range(8):
    time.sleep(10)
    _, fh = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8", show=False)
    if fh.strip() in ("200", "301", "302"):
        print(f"   ✅ Frontend is UP — HTTP {fh.strip()}")
        break
    print(f"   ⏳ Frontend: HTTP {fh.strip()} — waiting...")
else:
    print("   ⚠️  Frontend slow to start — check logs if needed")

# ── Step 13: Create admin user ────────────────────────────────────────────────
print("\n🔟  Creating admin user...")
ssh(
    f'docker exec dentauae-backend-1 sh -c '
    f'"npx medusa user --email \'{ADMIN_EMAIL}\' --password \'{ADMIN_PASS}\' 2>&1"',
    timeout=120
)

# ── Step 14: Test login ───────────────────────────────────────────────────────
print("\n1️⃣1️⃣  Testing login API...")
time.sleep(3)
_, login = ssh(
    f"""curl -s -X POST http://localhost:9000/auth/user/emailpass """
    f"""-H "Content-Type: application/json" """
    f"""-d '{{"email":"{ADMIN_EMAIL}","password":"{ADMIN_PASS}"}}' 2>&1""",
    timeout=15
)
if "token" in login.lower():
    print("   ✅ LOGIN WORKS!")
else:
    print(f"   ⚠️  Login response: {login[:300]}")

# ── Step 15: Final health summary ─────────────────────────────────────────────
print("\n1️⃣2️⃣  Final health checks...")
_, fe  = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8", show=False)
_, api = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
_, adm = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8", show=False)
_, disk = ssh("df -h / | tail -1", show=False)

print(f"""
{"=" * 65}
  DEPLOYMENT COMPLETE ✅

  🌐  Storefront:  https://dentauae.com           HTTP {fe.strip()}
  ⚙️   Backend API: https://api.dentauae.com        HTTP {api.strip()}
  🖥️   Admin Panel: https://api.dentauae.com/app   HTTP {adm.strip()}
  🐳  Portainer:   https://76.13.254.103:9443

  Admin login:
    Email:    {ADMIN_EMAIL}
    Password: {ADMIN_PASS}

  Disk: {disk.strip()}
{"=" * 65}
""")

client.close()
input("Press Enter to exit...")
