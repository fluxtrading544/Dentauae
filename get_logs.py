"""Quick diagnostic - get backend logs and container status"""
import sys
try:
    import paramiko
except ImportError:
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect("76.13.254.103", port=22, username="root", password="BxCY;RBM#,2Fhs2b", timeout=15)
print("✅ Connected\n")

def run(cmd, timeout=30):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    print(out)
    return out

print("=== Container status ===")
run("cd /root/Dentauae && docker compose ps")

print("\n=== Backend logs (last 80 lines) ===")
run("cd /root/Dentauae && docker compose logs backend --tail=80", timeout=20)

print("\n=== .medusa directory in image ===")
run("docker run --rm dentauae-backend find /app/.medusa -maxdepth 3 | sort 2>/dev/null || echo 'could not inspect image'", timeout=20)

client.close()
input("\nPress Enter to exit...")
