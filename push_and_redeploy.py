"""
PUSH_AND_REDEPLOY.py
====================
1. Kills any stale git processes holding the lock
2. Removes .git/index.lock if present
3. Commits the proxy.ts fix and pushes to GitHub
4. SSHes to VPS and runs a targeted frontend-only rebuild
   (backend image is fine — only Next.js build failed last time)
"""
import sys, os, time, subprocess

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
print("  DentaUAE — Push Fix + Redeploy Frontend")
print("=" * 65)

# Step 1: Kill stale git processes
print("\n1. Clearing any stale git locks...")
try:
    subprocess.run(["taskkill", "/F", "/IM", "git.exe"], capture_output=True, text=True)
    print("   (killed any running git.exe)")
except Exception:
    pass
time.sleep(1)

# Step 2: Remove lock files
for lock in [".git/index.lock", ".git/COMMIT_EDITMSG.lock", ".git/MERGE_HEAD.lock"]:
    lpath = os.path.join(LOCAL_DIR, lock)
    if os.path.exists(lpath):
        try:
            os.remove(lpath)
            print(f"   Removed {lock}")
        except Exception as e:
            print(f"   Could not remove {lock}: {e}")
    else:
        print(f"   No lock: {lock}")

# Step 3: Git commit + push
print("\n2. Committing and pushing proxy.ts fix...")

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
commit_rc = git(["commit", "-m", "fix: rename proxy.ts export from middleware to proxy (Next.js 16 requirement)"])
push_rc = git(["push", "origin", "main"])

if push_rc != 0:
    print("\nERROR: Push failed — check git credentials/remote")
    sys.exit(1)

if commit_rc == 0:
    print("   Committed and pushed!")
else:
    print("   Already committed — pushed latest.")

# Step 4: SSH to VPS
print("\n3. Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("   Connected\n")

def ssh(cmd, timeout=600, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

# Step 5: Show current state
print("4. Current container state:")
ssh("docker ps --format 'table {{.Names}}\t{{.Status}}'", timeout=15)

# Step 6: Pull latest code
print("\n5. Pulling latest code (with proxy.ts fix)...")
ssh(f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main 2>&1", timeout=60)
ssh(f"cd {REPO_DIR} && git log --oneline -2 2>&1", timeout=10)

# Step 7: Stop frontend, rebuild
print("\n6. Stopping old frontend container...")
ssh(f"cd {REPO_DIR} && docker compose stop frontend && docker compose rm -f frontend 2>&1", timeout=30)
ssh("docker rmi -f $(docker images | grep 'frontend\\|dentauae.*front' | awk '{print $3}') 2>/dev/null || true", timeout=30)

print("\n   Rebuilding frontend only (no cache) — ~5 min...\n")
code, build_out = ssh(
    f"cd {REPO_DIR} && docker compose build --no-cache --progress=plain frontend 2>&1",
    timeout=900
)
if code != 0:
    print(f"\nERROR: Frontend build FAILED:\n{build_out[-3000:]}")
    client.close()
    sys.exit(1)
print("\n   Frontend build complete!\n")

# Step 8: Start frontend
print("7. Starting frontend container...")
ssh(f"cd {REPO_DIR} && docker compose up -d frontend 2>&1", timeout=60)
time.sleep(8)

# Step 9: Wait for frontend
print("\n8. Waiting for frontend to come up...")
for i in range(12):
    time.sleep(10)
    _, fh = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8", show=False)
    ts = time.strftime("%H:%M:%S")
    if fh.strip() in ("200", "301", "302"):
        print(f"[{ts}] Frontend is UP — HTTP {fh.strip()}")
        break
    print(f"[{ts}] ({i+1}/12) Frontend: HTTP {fh.strip()}")
else:
    print("   Frontend slow — check: docker compose logs frontend --tail=30")

# Step 10: Final status
print("\n9. Final health checks...")
_, fe  = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8", show=False)
_, api = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
_, adm = ssh("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8", show=False)

print(f"""
{"=" * 65}
  DEPLOYMENT COMPLETE

  Storefront:   https://dentauae.com           HTTP {fe.strip()}
  Backend API:  https://api.dentauae.com        HTTP {api.strip()}
  Admin Panel:  https://api.dentauae.com/app   HTTP {adm.strip()}
  Portainer:    https://76.13.254.103:9443

  Admin login:
    Email:    {ADMIN_EMAIL}
    Password: {ADMIN_PASS}
{"=" * 65}
""")

client.close()
input("Press Enter to exit...")
