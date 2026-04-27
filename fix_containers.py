"""
DentaUAE - Fix: Install Docker Compose v2 & Restart All Containers
Run: python fix_containers.py
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

def run(client, cmd, timeout=120, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

print("=" * 60)
print("  🔧 DentaUAE - Compose v2 Install & Container Restart")
print("=" * 60)

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"✅ Connected to {VPS_HOST}\n")

# ── Step 1: Install Docker Compose v2 manually ────────────────────────────
print("📦 Step 1: Installing Docker Compose v2 plugin (manual download)...")

install_cmd = """
mkdir -p /usr/local/lib/docker/cli-plugins && \
curl -SL https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64 \
     -o /usr/local/lib/docker/cli-plugins/docker-compose && \
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
"""
code, out = run(client, install_cmd, timeout=60, show=True)

code, out = run(client, "docker compose version 2>&1", show=False)
if code == 0 and "version" in out.lower():
    compose_cmd = "docker compose"
    print(f"   ✅ Docker Compose v2 installed: {out.strip()}")
else:
    print(f"   ⚠️  v2 install failed ({out.strip()[:80]})")
    print("   ↩️  Falling back to docker-compose v1 (containers already removed — safe)")
    compose_cmd = "docker-compose"

print(f"\n   Using: [{compose_cmd}]")

# ── Step 2: Make sure all old containers are gone ─────────────────────────
print("\n🧹 Step 2: Ensuring all old containers are removed...")
run(client, "docker ps -aq --filter 'name=dentauae' | xargs -r docker rm -f 2>/dev/null || true", show=False)
run(client, f"cd {REPO_DIR} && docker-compose rm -f 2>/dev/null || true", show=False, timeout=30)
code, out = run(client, "docker ps -a --filter 'name=dentauae' --format '{{.Names}}'", show=False)
remaining = out.strip()
if remaining:
    print(f"   ⚠️  Still found: {remaining}")
    run(client, f"docker rm -f {remaining} 2>/dev/null || true", show=False)
print("   ✅ All old containers cleared")

# ── Step 3: Verify images exist (so no rebuild needed) ────────────────────
print("\n🖼️  Step 3: Checking Docker images...")
code, out = run(client, "docker images --format '{{.Repository}}:{{.Tag}}' | grep dentauae", show=False)
if out.strip():
    for img in out.strip().splitlines():
        print(f"   ✅ Found image: {img}")
else:
    print("   ⚠️  No pre-built images found — will need to build (takes ~10 min)")

# ── Step 4: Start all containers fresh ────────────────────────────────────
print(f"\n🚀 Step 4: Starting all containers...")
if out.strip():
    # Images exist, start without rebuild
    code, start_out = run(client, f"cd {REPO_DIR} && {compose_cmd} up -d 2>&1", timeout=120)
else:
    # No images, need to build first
    print("   Building images first (no cache available)...")
    code, start_out = run(client, f"cd {REPO_DIR} && {compose_cmd} up -d --build 2>&1", timeout=900)

if code != 0:
    print(f"\n❌ Failed to start containers. Error output:")
    print(start_out[-1500:])  # last 1500 chars
    client.close()
    input("\nPress Enter to exit...")
    sys.exit(1)

print("   ✅ Containers started!")

# ── Step 5: Wait for Medusa migrations ────────────────────────────────────
print("\n⏳ Step 5: Waiting 25 seconds for Medusa DB migrations...")
time.sleep(25)

# ── Step 6: Full verification ─────────────────────────────────────────────
print("\n" + "=" * 60)
print("  📊 Final Status Check")
print("=" * 60)

print("\n📦 Container status:")
run(client, f"cd {REPO_DIR} && {compose_cmd} ps")

print("\n🔍 Health checks:")
checks = [
    ("Frontend      (port 3000)", "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8"),
    ("Backend       (port 9000)", "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8"),
    ("Nginx→Frontend (Host: dentauae.com)", "curl -s -o /dev/null -w '%{http_code}' -H 'Host: dentauae.com' http://127.0.0.1:80 --max-time 8"),
    ("Nginx→Backend  (Host: api.dentauae.com)", "curl -s -o /dev/null -w '%{http_code}' -H 'Host: api.dentauae.com' http://127.0.0.1:80/health --max-time 8"),
]
all_ok = True
for label, cmd in checks:
    code, out = run(client, cmd, show=False)
    status = out.strip()
    ok = status in ("200", "204", "301", "302")
    icon = "✅" if ok else ("⏳" if status == "000" else "⚠️")
    print(f"  {icon}  {label}: HTTP {status}")
    if not ok and status != "000":
        all_ok = False

# ── Show backend logs if it's still starting ──────────────────────────────
code, health = run(client, "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 5", show=False)
if health.strip() == "000":
    print("\n📋 Backend is still starting. Last 20 log lines:")
    run(client, f"cd {REPO_DIR} && {compose_cmd} logs backend --tail=20")

print("\n" + "=" * 60)
print("  🎉 DONE!")
print("=" * 60)
print(f"""
  🌐  https://dentauae.com          → Storefront
  🌐  https://www.dentauae.com      → Storefront
  ⚙️   https://api.dentauae.com      → Medusa API
  🖥️   https://api.dentauae.com/app  → Admin dashboard

  ─────────────────────────────────────────────
  ⚡ If dentauae.com still shows 522:
     Cloudflare → SSL/TLS → set mode to "Flexible"
  ─────────────────────────────────────────────
  📋 To watch live logs on VPS:
     ssh root@{VPS_HOST}
     cd {REPO_DIR} && {compose_cmd} logs -f
""")

client.close()
input("Press Enter to exit...")
