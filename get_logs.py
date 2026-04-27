"""Quick script to dump full backend logs"""
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

_, stdout, _ = client.exec_command(
    "cd /root/Dentauae && docker compose logs backend --tail=80 2>&1",
    timeout=30, get_pty=True
)
print(stdout.read().decode(errors="replace"))
client.close()
input("Press Enter to exit...")
