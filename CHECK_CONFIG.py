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

def run(cmd):
    _, stdout, _ = client.exec_command(cmd, timeout=30, get_pty=True)
    out = stdout.read().decode(errors="replace")
    stdout.channel.recv_exit_status()
    print(out)

print("=== Compiled medusa-config.js outDir value ===")
run("docker exec dentauae-backend-1 grep -n 'outDir\\|adminOutDir\\|admin' /app/.medusa/server/medusa-config.js 2>/dev/null | head -20")

print("=== VPS git HEAD ===")
run("cd /root/Dentauae && git log --oneline -3")

print("=== admin.outDir in VPS source ===")
run("grep 'adminOutDir' /root/Dentauae/medusa-dentalanti/medusa-config.ts")

print("=== Files at runtime in container ===")
run("docker exec dentauae-backend-1 ls -la /app/.medusa/server/public/ 2>/dev/null || echo 'DIR NOT FOUND'")
run("docker exec dentauae-backend-1 ls -la /app/.medusa/server/public/admin/ 2>/dev/null || echo 'admin/ NOT FOUND'")

client.close()
input("Press Enter...")
