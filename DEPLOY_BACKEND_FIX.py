"""
DEPLOY_BACKEND_FIX.py  — Permanent fix for the index.html crash + login
========================================================================
Changes applied:
  1. medusa-config.ts: admin.outDir hardcoded to /app/.medusa/server/public
  2. Dockerfile: bulletproof index.html search (fails build if not found)
  3. medusa-config.ts: session_cookie.secure=false (fixes login cookies)

Run: python DEPLOY_BACKEND_FIX.py
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
print("  🔧  Backend Fix Deploy — admin outDir + session cookie")
print("=" * 65)

# ── Step 1: Remove stale git lock ─────────────────────────────────────────────
lock_file = os.path.join(LOCAL_DIR, ".git", "index.lock")
if os.path.exists(lock_file):
    try:
        os.remove(lock_file)
        print("🔓 Removed stale git index.lock\n")
    except Exception as e:
        print(f"❌ Cannot remove index.lock: {e}")
        print("   Manually delete: F:\\.git\\index.lock then re-run")
        sys.exit(1)

# ── Step 2: Git commit + push ─────────────────────────────────────────────────
print("1️⃣  Pushing fixes to GitHub...")

def git(args, check=False):
    r = subprocess.run(["git"] + args, cwd=LOCAL_DIR,
                       capture_output=True, text=True)
    out = (r.stdout + r.stderr).strip()
    if out:
        print("   " + "\n   ".join(out.splitlines()))
    return r.returncode

git(["config", "user.email", "shaheryarahmed8506@gmail.com"])
git(["config", "user.name", "Sharyar"])
git(["add", "medusa-dentalanti/medusa-config.ts", "medusa-dentalanti/Dockerfile"])
commit_rc = git(["commit", "-m",
    "fix: hardcode admin outDir /app/.medusa/server/public + secure=false cookie"])
push_rc = git(["push", "origin", "main"])
if push_rc != 0:
    print("\n   ❌ Push failed — check git credentials/remote")
    sys.exit(1)
if commit_rc == 0:
    print("   ✅ Committed and pushed!\n")
else:
    print("   ✅ Already up to date — pushed.\n")

# ── Step 3: SSH to VPS ────────────────────────────────────────────────────────
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

# ── Step 4: Pull latest code ──────────────────────────────────────────────────
print("3️⃣  Pulling latest code on VPS...")
ssh(f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main 2>&1")

# Verify the fix is in the pulled code
_, cfg = ssh(f"grep 'adminOutDir' {REPO_DIR}/medusa-dentalanti/medusa-config.ts", show=False)
if "/app/.medusa/server/public" in cfg:
    print("   ✅ Hardcoded outDir confirmed in pulled code\n")
else:
    print(f"   ⚠️  outDir value: {cfg.strip()}")
    print("   May not have the fix — continuing anyway\n")

# ── Step 5: Rebuild backend ───────────────────────────────────────────────────
print("4️⃣  Rebuilding backend --no-cache (~5 min)...")
print("   Watch for '✅ index.html confirmed' in output\n")
code, build_out = ssh(
    f"cd {REPO_DIR} && docker compose build --no-cache --progress=plain backend 2>&1",
    timeout=900
)
if code != 0:
    print(f"\n❌ Build FAILED:\n{build_out[-2000:]}")
    client.close(); sys.exit(1)

if "index.html confirmed" in build_out or "Copied successfully" in build_out or "Copied (deep search)" in build_out:
    print("\n   ✅ Admin index.html CONFIRMED — fix is working!")
elif "FATAL" in build_out:
    print("\n   ❌ Build failed — index.html not found after medusa build")
    client.close(); sys.exit(1)
else:
    print("\n   ⚠️  Could not verify index.html from build log — continuing")

# ── Step 6: Restart backend only ─────────────────────────────────────────────
print("\n5️⃣  Starting backend container...")
ssh(f"cd {REPO_DIR} && docker compose up -d --no-deps backend 2>&1", timeout=60)

# ── Step 7: Wait for healthy ──────────────────────────────────────────────────
print("\n6️⃣  Waiting for backend to boot (up to 5 min)...\n")
for attempt in range(1, 22):
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
        print(f"\n[{ts}] ❌ index.html error STILL present — build fix didn't apply!")
        ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=30 --no-log-prefix")
        client.close(); sys.exit(1)
    print(f"[{ts}] ⏳ {attempt}/21: HTTP {status} — {last_line}")
else:
    print("\n❌ Backend timed out. Last 30 logs:")
    ssh(f"cd {REPO_DIR} && docker compose logs backend --tail=30 --no-log-prefix")
    client.close(); sys.exit(1)

# ── Step 8: Create admin user ─────────────────────────────────────────────────
print("\n7️⃣  Creating/updating admin user...")
ssh(
    f'docker exec dentauae-backend-1 sh -c '
    f'"npx medusa user --email \'{ADMIN_EMAIL}\' --password \'{ADMIN_PASS}\' 2>&1"',
    timeout=90
)

# ── Step 9: Test login ────────────────────────────────────────────────────────
print("\n8️⃣  Testing login API from VPS...")
time.sleep(3)
_, login = ssh(
    f"""curl -s -X POST http://localhost:9000/auth/user/emailpass """
    f"""-H "Content-Type: application/json" """
    f"""-d '{{"email":"{ADMIN_EMAIL}","password":"{ADMIN_PASS}"}}' 2>&1""",
    timeout=15
)
if "token" in login.lower() or "access_token" in login:
    print("\n   ✅ LOGIN WORKS — token returned!")
elif "401" in login or "unauthorized" in login.lower():
    print(f"\n   ⚠️  Auth 401. Raw response:\n   {login[:400]}")
    print("   → Clear browser cookies for api.dentauae.com and try again")
else:
    print(f"\n   Response: {login[:400]}")

# ── Summary ───────────────────────────────────────────────────────────────────
_, fe  = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 5", show=False)
_, api = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 5", show=False)
_, adm = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 5", show=False)

print(f"""
{"=" * 65}
  🌐  Storefront:  https://dentauae.com         HTTP {fe.strip()}
  ⚙️   Backend:     https://api.dentauae.com      HTTP {api.strip()}
  🖥️   Admin:       https://api.dentauae.com/app  HTTP {adm.strip()}
  🐳  Portainer:   https://76.13.254.103:9443

  Admin credentials:
    Email:    {ADMIN_EMAIL}
    Password: {ADMIN_PASS}
""")

client.close()
input("Press Enter to exit...")
