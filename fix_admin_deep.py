"""
DentaUAE - Deep fix for admin build directory error
Run: python fix_admin_deep.py
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
print(f"✅ Connected to {VPS_HOST}\n")

print("=" * 60)
print("  🔍 Deep Diagnosis: Admin Build Directory")
print("=" * 60)

# ── 1. What's inside .medusa/server/ ─────────────────────────────────────
print("\n1️⃣  Contents of .medusa/server/:")
run(client, "docker exec dentauae-backend-1 find /app/.medusa/server -maxdepth 3 -type f | head -30")

# ── 2. What exact path does admin-bundler check? ──────────────────────────
print("\n2️⃣  Exact path the admin-bundler checks for index.html:")
run(client,
    "docker exec dentauae-backend-1 sh -c \""
    "grep -n 'admin build directory\\|index.html\\|adminDir\\|buildDir' "
    "/app/node_modules/@medusajs/admin-bundler/dist/index.js | head -20\""
)

# ── 3. Read medusa-config.ts ──────────────────────────────────────────────
print("\n3️⃣  medusa-config.ts admin section:")
run(client, "docker exec dentauae-backend-1 cat /app/medusa-config.ts 2>/dev/null | head -60")

# ── 4. Check admin.ts loader to understand expected path ──────────────────
print("\n4️⃣  Admin loader expected path:")
run(client,
    "docker exec dentauae-backend-1 sh -c \""
    "grep -n 'adminDir\\|admin_dir\\|public/admin\\|buildPath\\|distPath' "
    "/app/node_modules/@medusajs/medusa/src/loaders/admin.ts 2>/dev/null | head -20\""
)

# ── 5. Find the exact line 1617 in admin-bundler ─────────────────────────
print("\n5️⃣  admin-bundler line 1610-1625 (error location):")
run(client,
    "docker exec dentauae-backend-1 sh -c \""
    "awk 'NR>=1610 && NR<=1625' "
    "/app/node_modules/@medusajs/admin-bundler/dist/index.js\""
)

client.close()
print("\n" + "=" * 60)
print("Diagnosis complete — paste the output above for the fix.")
input("Press Enter to exit...")
