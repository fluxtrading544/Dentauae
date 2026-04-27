"""Check exact outDir the admin loader uses, then enable admin properly"""
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

def run(cmd, timeout=20):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    return out

# Check admin.ts - specifically serveProductionBuild and what outDir is passed
print("=== Admin loader (lines 70-120) ===")
print(run("docker exec dentauae-backend-1 sh -c \"awk 'NR>=70 && NR<=120' /app/node_modules/@medusajs/medusa/src/loaders/admin.ts\""))

print("=== All outDir references in admin.ts ===")
print(run("docker exec dentauae-backend-1 sh -c \"grep -n 'outDir\\|adminDir\\|client\\|buildPath' /app/node_modules/@medusajs/medusa/src/loaders/admin.ts\""))

print("=== .medusa/client contents ===")
print(run("docker exec dentauae-backend-1 ls -la /app/.medusa/client/"))

client.close()
input("Press Enter to exit...")
