"""
Gets backend crash logs from VPS to diagnose startup failure.
Run: python GET_LOGS.py
"""
import sys

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

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)

def run(cmd, timeout=30):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    stdout.channel.recv_exit_status()
    print(out)
    return out

print("=" * 60)
print("CONTAINER STATUS")
print("=" * 60)
run("docker ps -a --format '{{.Names}} | {{.Status}}'")

print("=" * 60)
print("LAST 80 BACKEND LOG LINES (full)")
print("=" * 60)
run(f"cd {REPO_DIR} && docker compose logs backend --tail=80 --no-log-prefix 2>&1")

print("=" * 60)
print("ACTUAL ERRORS ONLY")
print("=" * 60)
run(f"cd {REPO_DIR} && docker compose logs backend --no-log-prefix 2>&1 | grep -i 'error\\|Error\\|FATAL\\|Cannot\\|Failed\\|ECONNREFUSED\\|listening\\|port 9000\\|ready' | tail -20")

print("=" * 60)
print("IS PORT 9000 LISTENING?")
print("=" * 60)
run("ss -tlnp | grep 9000 || echo 'NOT listening'")

client.close()
input("\nPress Enter to exit...")
