"""
Quick restart — brings all Docker containers back up on the VPS.
Also installs Portainer for web-based Docker management (one-time).
Run: python RESTART_NOW.py
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

print("=" * 55)
print("  🔄  VPS Container Restart + Portainer Setup")
print("=" * 55)

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("✅ Connected\n")

def run(cmd, timeout=90, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

# Show current container status
print("Current container status:")
run("docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'")

# Install Portainer if not already running
print("\nChecking for Portainer...")
code, portainer = run("docker ps -a --filter name=portainer --format '{{.Status}}'", show=False)
if not portainer.strip():
    print("Installing Portainer (Docker management web UI)...")
    run(
        "docker volume create portainer_data && "
        "docker run -d -p 9443:9443 -p 8000:8000 --name portainer --restart=always "
        "-v /var/run/docker.sock:/var/run/docker.sock "
        "-v portainer_data:/data "
        "portainer/portainer-ce:latest 2>&1",
        timeout=60
    )
    print("✅ Portainer installed — will be at https://76.13.254.103:9443")
else:
    print(f"   Portainer already exists: {portainer.strip()}")
    run("docker start portainer 2>&1")

# Start main app containers
print("\nStarting app containers...")
run(f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)

print("\nWaiting 90s for backend to boot...")
time.sleep(90)

print("\nChecking health...")
for i in range(1, 12):
    code, h = run(
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False
    )
    status = h.strip()
    ts = time.strftime("%H:%M:%S")
    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP — HTTP {status}")
        break

    _, logs = run(f"cd {REPO_DIR} && docker compose logs backend --tail=3", show=False)
    last = [l for l in logs.strip().splitlines() if l.strip()]
    last_line = last[-1].replace("backend-1  |", "").strip() if last else "..."
    print(f"[{ts}] ⏳ Attempt {i}: HTTP {status} — {last_line[-80:]}")
    time.sleep(15)
else:
    print("\n❌ Backend not responding. Showing last 20 log lines:")
    run(f"cd {REPO_DIR} && docker compose logs backend --tail=20")

# Final status
print("\nFinal container status:")
run("docker ps --format 'table {{.Names}}\t{{.Status}}'")

code, fe  = run("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:3000 --max-time 8", show=False)
code, api = run("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
code, pt  = run("curl -sk -o /dev/null -w '%{http_code}' https://127.0.0.1:9443 --max-time 8", show=False)

print(f"""
  🌐  Storefront:  https://dentauae.com              HTTP {fe.strip()}
  ⚙️   Backend:     https://api.dentauae.com           HTTP {api.strip()}
  🖥️   Admin:       https://api.dentauae.com/app
  🐳  Portainer:   https://76.13.254.103:9443        HTTP {pt.strip()}
""")

client.close()
input("Press Enter to exit...")
