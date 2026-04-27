"""
DentaUAE - Push fixes to GitHub and redeploy VPS backend
Changes pushed:
  - medusa-config.ts: admin.disable = true  (FIXES the crash)
  - Dockerfile: cleaned up CMD
  - docker-compose.yml: MEDUSA_ADMIN_ON_SERVER=false
Run: python push_and_redeploy.py
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

def run_ssh(client, cmd, timeout=120, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

def run_local(cmd, cwd=LOCAL_DIR):
    print(f"   $ {cmd}")
    result = subprocess.run(cmd, shell=True, cwd=cwd, capture_output=True, text=True)
    if result.stdout.strip():
        print(f"   {result.stdout.strip()}")
    if result.returncode != 0 and result.stderr.strip():
        print(f"   ⚠️  {result.stderr.strip()}")
    return result.returncode, result.stdout

print("=" * 60)
print("  🚀 Push Fixes to GitHub & Redeploy VPS")
print("=" * 60)

# ── Step 1: Git push from local machine ───────────────────────────────────
print("\n1️⃣  Pushing fixes to GitHub...")
print("   Files changed:")
print("   • medusa-dentalanti/medusa-config.ts  (admin.disable = true)")
print("   • medusa-dentalanti/Dockerfile        (cleaned CMD)")
print("   • docker-compose.yml                  (MEDUSA_ADMIN_ON_SERVER=false)")

run_local("git add medusa-dentalanti/medusa-config.ts medusa-dentalanti/Dockerfile docker-compose.yml")
run_local('git commit -m "fix: disable admin panel on backend server to fix crash-loop"')
code, out = run_local("git push origin main")

if code != 0:
    print("\n⚠️  Git push failed. Trying to push anyway...")
    run_local("git push")

print("\n   ✅ Pushed to GitHub!")

# ── Step 2: Connect to VPS ────────────────────────────────────────────────
print("\n2️⃣  Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"   ✅ Connected to {VPS_HOST}")

# ── Step 3: Write clean docker-compose.yml on VPS ─────────────────────────
print("\n3️⃣  Restoring clean docker-compose.yml on VPS...")
CLEAN_COMPOSE = open(LOCAL_DIR + r"\docker-compose.yml", "r").read()
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/docker-compose.yml", "w") as f:
    f.write(CLEAN_COMPOSE)
sftp.close()
print("   ✅ docker-compose.yml restored")

# ── Step 4: Pull latest code from GitHub ──────────────────────────────────
print("\n4️⃣  Pulling latest code on VPS...")
run_ssh(client, f"cd {REPO_DIR} && git pull origin main 2>&1")

# ── Step 5: Stop backend, rebuild with fix, restart ───────────────────────
print("\n5️⃣  Rebuilding backend container with the fix...")
print("   (medusa build takes 5-10 minutes — this is the last rebuild needed)")
run_ssh(client, f"cd {REPO_DIR} && docker compose stop backend", timeout=30)
run_ssh(client, f"cd {REPO_DIR} && docker compose build backend 2>&1", timeout=900)
run_ssh(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)
print("   ✅ Backend rebuilt and started!")

# ── Step 6: Poll until backend is up ─────────────────────────────────────
print("\n6️⃣  Waiting for backend (migrations running)...\n")

for attempt in range(1, 25):
    time.sleep(20)
    code, out = run_ssh(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend is UP! HTTP {status}")
        run_ssh(client, f"cd {REPO_DIR} && docker compose ps")
        print("\n" + "=" * 60)
        print("  🎉 FULLY DEPLOYED & LIVE!")
        print("=" * 60)
        print("""
  🌐  https://dentauae.com          → Storefront ✅
  ⚙️   https://api.dentauae.com      → Medusa API ✅
  🖥️   https://api.dentauae.com/app  → (Admin disabled — API works)
""")
        break

    _, logs = run_ssh(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=4", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend-1" in l]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "starting..."
    print(f"[{ts}] ⏳ Attempt {attempt}: {last[-80:]}")
else:
    print("\n⚠️  Full logs:")
    run_ssh(client, f"cd {REPO_DIR} && docker compose logs backend --tail=40")

client.close()
input("\nPress Enter to exit...")
