"""
Find exact outDir the admin loader uses by running a temp container.
Then apply the permanent fix.
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
print("✅ Connected\n")

# ── Start a stable temp container (sleep instead of medusa start) ─────────
print("🔍 Starting temp container for inspection (no crash loop)...")
run(client, "docker rm -f temp_inspect 2>/dev/null || true", show=False)
run(client,
    "docker run -d --name temp_inspect "
    f"--env-file {REPO_DIR}/.env "
    "dentauae-backend sleep 3600",
    show=False)
time.sleep(3)

print("\n=== admin.js - outDir references ===")
code, out = run(client,
    "docker exec temp_inspect sh -c \""
    "grep -n 'outDir\\|adminBuild\\|client\\|\\.medusa' "
    "/app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null | head -30\""
)

print("\n=== Lines around serveProductionBuild ===")
run(client,
    "docker exec temp_inspect sh -c \""
    "grep -n -A5 'serveProductionBuild\\|productionBuild\\|serve(' "
    "/app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null | head -40\""
)

print("\n=== .medusa directory structure ===")
run(client, "docker exec temp_inspect find /app/.medusa -maxdepth 3 | sort")

print("\n=== What node_modules/@medusajs/admin-bundler outDir default is ===")
run(client,
    "docker exec temp_inspect sh -c \""
    "grep -n 'outDir\\|default\\|client' "
    "/app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null\""
)

print("\n=== Full admin.js (first 60 lines) ===")
run(client,
    "docker exec temp_inspect sh -c \""
    "head -60 /app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null\""
)

run(client, "docker rm -f temp_inspect", show=False)
print("\n✅ Temp container removed")

client.close()
input("\nPress Enter to exit...")
