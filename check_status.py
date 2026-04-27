"""
DentaUAE - VPS Status Checker
Run this to check backend logs and health after deployment.
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

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)

def run(cmd, timeout=30):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    return stdout.read().decode(errors="replace")

print("\n📦 CONTAINER STATUS:")
print(run("cd /root/Dentauae && docker-compose ps"))

print("\n📋 BACKEND LOGS (last 50 lines):")
print(run("cd /root/Dentauae && docker-compose logs backend --tail=50", timeout=40))

print("\n🔍 BACKEND HEALTH:")
health = run("curl -s -o /dev/null -w '%{http_code}' http://localhost:9000/health --max-time 8")
print(f"  HTTP Status: {health}")

if health.strip() in ("200", "204"):
    print("  ✅ Backend is UP and healthy!")
elif health.strip() == "000":
    print("  ⏳ Backend still starting (migrations running). Wait 1-2 more minutes.")
else:
    print(f"  ⚠️  Backend returned: {health}")

print("\n🔍 FRONTEND HEALTH:")
fe = run("curl -s -o /dev/null -w '%{http_code}' http://localhost:3000 --max-time 8")
print(f"  HTTP Status: {fe} — {'✅ UP' if fe.strip() == '200' else '⚠️ Check logs'}")

print(f"\n🌐 Frontend:  http://{VPS_HOST}:3000")
print(f"⚙️  Backend:   http://{VPS_HOST}:9000")
print(f"🖥️  Dashboard: http://{VPS_HOST}:9000/app")

client.close()
input("\nPress Enter to exit...")
