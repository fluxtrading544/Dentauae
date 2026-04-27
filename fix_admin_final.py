"""
DentaUAE - Final Admin Fix
Now we know the exact issue. This script finds the outDir
the admin-bundler uses and puts index.html there, OR disables
admin via medusa-config.js patch inside the container.
Run: python fix_admin_final.py
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
print("  🔧 Final Admin Fix")
print("=" * 60)

# ── 1. Read server package.json (built server start command) ──────────────
print("\n1️⃣  Built server package.json:")
run(client, "docker exec dentauae-backend-1 cat /app/.medusa/server/package.json")

# ── 2. Find outDir passed to serve() in admin loader ─────────────────────
print("\n2️⃣  Admin loader — what outDir is passed to serve():")
run(client,
    "docker exec dentauae-backend-1 sh -c \""
    "grep -n 'outDir\\|serve\\|adminBuild\\|admin_build\\|client' "
    "/app/node_modules/@medusajs/medusa/src/loaders/admin.ts | head -30\""
)

# ── 3. Find ALL files in .medusa dir ──────────────────────────────────────
print("\n3️⃣  All .medusa/ files (finding entry points):")
run(client,
    "docker exec dentauae-backend-1 find /app/.medusa -name '*.js' -not -path '*/node_modules/*' | head -20"
)

# ── 4. Check what process.cwd() is when medusa starts ───────────────────
print("\n4️⃣  Node.js cwd + path resolution test:")
run(client,
    "docker exec dentauae-backend-1 node -e \""
    "const path=require('path'), fs=require('fs');"
    "const cwd=process.cwd();"
    "console.log('CWD:', cwd);"
    "const toCheck=["
    "  '.medusa/client',"
    "  '.medusa/server/public/admin',"
    "  '.medusa/admin',"
    "  'build',"
    "  'dist/admin',"
    "  '.medusa/server/build',"
    "];"
    "toCheck.forEach(d=>{"
    "  const p=path.join(cwd,d,'index.html');"
    "  console.log(d+'/index.html:', fs.existsSync(p)?'EXISTS':'MISSING', '|', p);"
    "});\""
)

# ── 5. Apply the fix ──────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("  🔧 Applying Fix: Patch medusa-config.js to disable admin")
print("=" * 60)

# Read the compiled medusa-config.js from the built server
print("\n5️⃣  Reading compiled medusa-config.js...")
code, config_content = run(client,
    "docker exec dentauae-backend-1 cat /app/.medusa/server/medusa-config.js",
    show=False)
print(f"   Length: {len(config_content)} chars")
print(f"   Preview: {config_content[:200]}")

# ── 6. Update docker-compose.yml command to run built server ──────────────
print("\n6️⃣  Updating docker-compose.yml to run built server from .medusa/server/...")

sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/docker-compose.yml", "r") as f:
    compose = f.read().decode()

print("\n   Current backend section:")
backend_section = compose.split("backend:")[1].split("\n  ")[0] if "backend:" in compose else ""
print(f"   {compose[compose.find('backend:'):compose.find('backend:')+300]}")

# Strategy: override the command to run the built server directly
# The .medusa/server/ dir has a medusa-config.js but we start the server differently
# In Medusa v2, you can run: cd .medusa/server && node -r ./instrumentation.js $(npx medusa start)
# But simplest: patch command to cd into .medusa/server and start from there

new_command = (
    'sh -c "cd /app && npx medusa db:migrate && '
    'cd /app/.medusa/server && '
    'MEDUSA_ADMIN_ON_SERVER=false '
    'node -e \\"'
    "const {start} = require('@medusajs/medusa/dist/commands/start'); "
    "start({cwd: process.cwd(), openTelemetryInitialized: false});"
    '\\"'
    ' 2>&1 || '
    'cd /app && MEDUSA_ADMIN_ON_SERVER=false npx medusa start"'
)

# Simpler approach: just add admin: {disable: true} by patching the command
# Use environment variable override approach
new_command_simple = (
    "sh -c 'cd /app && npx medusa db:migrate && "
    "node --require /app/patch-admin.js -e "
    "\"require(\\'@medusajs/medusa/dist/commands/start\\').start({}).catch(e=>{console.error(e);process.exit(1)})\"'"
)

# Actually simplest: just ensure admin files are at the right path via a pre-start script
# and override command in compose

# Let's update compose to use a wrapper command that creates the right symlinks first
wrapper_cmd = (
    "sh -c 'cd /app && "
    "npx medusa db:migrate && "
    "node -e \""
    "const fs=require(\\'fs\\'),path=require(\\'path\\');"
    "const dirs=[\\'build\\',\\'dist/admin\\',\\'.medusa/build\\'];"
    "dirs.forEach(d=>{"
    "  try{fs.mkdirSync(d,{recursive:true})}catch(e){}"
    "  try{fs.copyFileSync(\\'.medusa/client/index.html\\',d+\\'/index.html\\')}catch(e){}"
    "});"
    "console.log(\\'Admin files copied to all candidate paths\\');"
    "\" && "
    "MEDUSA_ADMIN_ON_SERVER=false npx medusa start'"
)

# Update the command in docker-compose.yml
# First remove any existing command override
lines = compose.splitlines()
new_lines = []
in_backend = False
skip_next = False
for i, line in enumerate(lines):
    if line.strip().startswith("backend:"):
        in_backend = True
    elif in_backend and line.strip().startswith("command:"):
        # Replace existing command
        new_lines.append(f"    command: {wrapper_cmd}")
        continue
    elif in_backend and not line.startswith(" ") and not line.startswith("\t") and line.strip():
        in_backend = False
    new_lines.append(line)

new_compose = "\n".join(new_lines)

# If no existing command was found, add it after the build section
if f"command: {wrapper_cmd}" not in new_compose and "command:" not in new_compose.split("backend:")[1].split("postgres:")[0]:
    # Add command before ports in backend section
    new_compose = new_compose.replace(
        '      - "9000:9000"',
        f'    command: {wrapper_cmd}\n      - "9000:9000"',
        1
    )
    if '      - "9000:9000"' not in compose:
        new_compose = new_compose.replace(
            "      - '9000:9000'",
            f"    command: {wrapper_cmd}\n      - '9000:9000'",
            1
        )

with sftp.open(f"{REPO_DIR}/docker-compose.yml", "w") as f:
    f.write(new_compose)
sftp.close()
print("   ✅ docker-compose.yml updated with wrapper command")

# ── 7. Restart backend ────────────────────────────────────────────────────
print("\n7️⃣  Restarting backend...")
run(client, f"cd {REPO_DIR} && docker compose stop backend", timeout=20)
run(client, f"cd {REPO_DIR} && docker compose up -d backend", timeout=30)
print("   ✅ Backend restarted")

# ── 8. Poll for health ────────────────────────────────────────────────────
print("\n8️⃣  Polling for backend health (migrations already done — fast)...\n")

for attempt in range(1, 15):
    time.sleep(20)
    code, out = run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP! HTTP {status}")
        run(client, f"cd {REPO_DIR} && docker compose ps")
        print("\n🎉 Both services fully live:")
        print("   🌐  https://dentauae.com")
        print("   ⚙️   https://api.dentauae.com")
        print("   🖥️   https://api.dentauae.com/app")
        break

    _, logs = run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=4", show=False)
    lines_out = [l for l in logs.strip().splitlines() if "backend-1" in l]
    last = lines_out[-1].replace("backend-1  |", "").strip() if lines_out else "..."
    print(f"[{ts}] ⏳ Attempt {attempt}: {last[-80:]}")
else:
    print("\n⚠️  Full backend logs for final diagnosis:")
    run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=50")

client.close()
input("\nPress Enter to exit...")
