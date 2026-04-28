"""
CLEAN_DEPLOY.py — Full clean deployment to VPS
===============================================
1. Git commit + push all local fixes
2. SSH to VPS → git pull
3. docker compose down --remove-orphans
4. docker system prune -f (free disk space)
5. docker compose build --no-cache (fresh build)
6. docker compose up -d
7. Wait for backend health
8. Create admin user
9. Test login + storefront + admin
10. Print final status
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
print("  🚀  DentaUAE Clean Deploy")
print("=" * 65)

# ── Step 1: Remove stale git lock ─────────────────────────────────────────────
lock_file = os.path.join(LOCAL_DIR, ".git", "index.lock")
if os.path.exists(lock_file):
    try:
        os.remove(lock_file)
        print("🔓 Removed stale git index.lock\n")
    except Exception as e:
        print(f"❌ Cannot remove index.lock: {e}")
        sys.exit(1)

# ── Step 2: Git commit + push ─────────────────────────────────────────────────
print("1️⃣  Committing and pushing all fixes to GitHub...")

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
    "fix: image fallback+sizes, COD payment, proxy rename, cart hydration, local dev setup"])
push_rc = git(["push", "origin", "main"])
if push_rc != 0:
    print("\n❌ Push failed — check git credentials")
    sys.exit(1)
print("   ✅ Pushed!\n")

# ── Step 3: SSH ────────────────────────────────────────────────────────────────
print("2️⃣  Connecting to VPS...")
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

# ── Step 4: Pull latest ────────────────────────────────────────────────────────
print("3️⃣  Pulling latest code on VPS...")
ssh(f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main 2>&1")

# ── Step 5: Stop everything + clean ───────────────────────────────────────────
print("\n4️⃣  Stopping all containers and cleaning Docker...")
ssh(f"cd {REPO_DIR} && docker compose down --remove-orphans 2>&1", timeout=60)
ssh("docker system prune -f 2>&1", timeout=120)
print("   ✅ Clean!\n")

# ── Step 6: Fresh build ────────────────────────────────────────────────────────
print("5️⃣  Building fresh (no cache) — takes ~8 min...")
print("   Watch for '✅ index.html confirmed' in output\n")
code, build_out = ssh(
    f"cd {REPO_DIR} && docker compose build --no-cache --progress=plain 2>&1",
    timeout=1200
)
if code != 0:
    print(f"\n❌ Build FAILED:\n{build_out[-3000:]}")
    client.close(); sys.exit(1)
print("\n   ✅ Build complete!\n")

# ── Step 7: Start all services ────────────────────────────────────────────────
print("6️⃣  Starting all services...")
ssh(f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)

# ── Step 8: Wait for backend ──────────────────────────────────────────────────
print("\n7️⃣  Waiting for backend to boot (up to 5 min)...\n")
for attempt in range(1, 25):
    time.sleep(15)
    _, h = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
    status = h.strip()
    ts = time.strftime("%H:%M:%S")
    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP — HTTP {status}")
        break
    _, logs = ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=2 --no-log-prefix", show=False)
    last = [l.strip() for l in logs.strip().splitlines() if l.strip()]
    last_line = last[-1][-90:] if last else "..."
    if "Could not find index.html" in last_line:
        print(f"\n[{ts}] ❌ index.html error — checking build output...")
        ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=30 --no-log-prefix")
        client.close(); sys.exit(1)
    print(f"[{ts}] ⏳ {attempt}/24: HTTP {status} — {last_line}")
else:
    print("\n❌ Backend timed out. Last logs:")
    ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=30 --no-log-prefix")
    client.close(); sys.exit(1)

# ── Step 9: Create admin user ─────────────────────────────────────────────────
print("\n8️⃣  Creating/updating admin user...")
ssh(
    f'docker exec dentauae-backend-1 sh -c '
    f'"npx medusa user --email \'{ADMIN_EMAIL}\' --password \'{ADMIN_PASS}\' 2>&1"',
    timeout=90
)

# ── Step 10: Test login ───────────────────────────────────────────────────────
print("\n9️⃣  Testing login API...")
time.sleep(3)
_, login = ssh(
    f"""curl -s -X POST http://localhost:9000/auth/user/emailpass """
    f"""-H "Content-Type: application/json" """
    f"""-d '{{"email":"{ADMIN_EMAIL}","password":"{ADMIN_PASS}"}}' 2>&1""",
    timeout=15
)
if "token" in login.lower():
    print("   ✅ LOGIN WORKS — token returned!")
else:
    print(f"   ⚠️  Auth response: {login[:300]}")

# ── Step 11: Final health checks ──────────────────────────────────────────────
print("\n🔟  Final health checks...")
_, fe  = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8", show=False)
_, api = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
_, adm = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8", show=False)

# Print running containers
ssh("docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'")

print(f"""
{"=" * 65}
  🌐  Storefront:  https://dentauae.com           HTTP {fe.strip()}
  ⚙️   Backend:     https://api.dentauae.com        HTTP {api.strip()}
  🖥️   Admin:       https://api.dentauae.com/app   HTTP {adm.strip()}
  🐳  Portainer:   https://76.13.254.103:9443

  Admin login:
    Email:    {ADMIN_EMAIL}
    Password: {ADMIN_PASS}
{"=" * 65}
""")

client.close()
input("Press Enter to exit...")
