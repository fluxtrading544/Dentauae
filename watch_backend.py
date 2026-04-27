"""
DentaUAE - Watch Backend Startup Live
Run: python watch_backend.py
Shows live backend logs and polls until it's healthy.
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

def run(client, cmd, timeout=30, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"✅ Connected to {VPS_HOST}")
print("📋 Watching backend logs (Ctrl+C to stop)...\n")
print("=" * 60)

# Show last 30 log lines first
run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=30")

print("=" * 60)
print("\n🔄 Polling backend health every 15 seconds...\n")

attempt = 0
while True:
    attempt += 1
    code, out = run(client, "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
    status = out.strip()
    timestamp = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{timestamp}] ✅ Backend is UP! HTTP {status}")
        print("\n🎉 api.dentauae.com is now live!")
        print(f"   https://api.dentauae.com/app  → Admin dashboard")

        # Show final container status
        print("\n📦 Final container status:")
        run(client, f"cd {REPO_DIR} && docker compose ps")
        break
    elif status == "000":
        print(f"[{timestamp}] ⏳ Attempt {attempt}: Backend still running migrations...")
        # Show last 5 log lines to show progress
        _, logs = run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=5", show=False)
        for line in logs.strip().splitlines()[-3:]:
            if line.strip():
                print(f"   {line.strip()}")
    else:
        print(f"[{timestamp}] ⚠️  Attempt {attempt}: HTTP {status} — checking logs...")
        run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=10")

    time.sleep(15)

client.close()
input("\nPress Enter to exit...")
