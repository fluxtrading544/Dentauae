"""Inspect exactly what outDir admin-bundler's serve() uses, then apply targeted fix."""
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
    print(out)
    return out

# 1. Show admin-bundler serve() - the exact lines that fail
print("=== admin-bundler serve() - lines around 1610-1625 ===")
run("docker run --rm dentauae-backend sed -n '1600,1640p' "
    "/app/node_modules/@medusajs/admin-bundler/dist/index.js 2>/dev/null")

# 2. Show what serveProductionBuild passes as outDir
print("=== admin.ts - serveProductionBuild (full function) ===")
run("docker run --rm dentauae-backend grep -n -A30 'serveProductionBuild' "
    "/app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null | head -50")

# 3. Show compiled medusa-config.js - what admin options were baked in
print("=== .medusa/server/medusa-config.js (admin section) ===")
run("docker run --rm dentauae-backend cat /app/.medusa/server/medusa-config.js 2>/dev/null")

# 4. Exactly what paths exist for index.html
print("=== All index.html paths in the image ===")
run("docker run --rm dentauae-backend find /app/.medusa -name 'index.html' | sort")

# 5. What is process.cwd() at runtime inside the running container?
print("=== process.cwd() at container runtime ===")
run("docker exec dentauae-backend-1 node -e 'console.log(process.cwd())' 2>/dev/null || echo 'container not running - try: docker run --rm dentauae-backend node -e \"console.log(process.cwd())\"'")
run("docker run --rm dentauae-backend node -e 'console.log(process.cwd())'")

client.close()
input("\nPress Enter to exit...")
