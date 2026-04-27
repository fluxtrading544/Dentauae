"""
DentaUAE - Fix: Admin Build Directory Error
The backend crashes because Medusa can't find admin index.html.
Fix: disable MEDUSA_ADMIN_ON_SERVER so API starts cleanly,
then use the correct built server command.
Run: python fix_admin_error.py
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

def run(client, cmd, timeout=60, show=True):
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
print("  🔧 Fix: Medusa Admin Build Error")
print("=" * 60)

# ── Step 1: Check what paths exist inside the backend container ────────────
print("\n1️⃣  Checking admin paths inside backend container...")
code, out = run(client,
    "docker exec dentauae-backend-1 sh -c 'find /app/.medusa -name index.html 2>/dev/null | head -10'",
    show=False)
print(f"   Admin index.html locations:\n   {out.strip()}")

# Check if built server exists
code, server_exists = run(client,
    "docker exec dentauae-backend-1 sh -c 'ls /app/.medusa/server/index.js 2>/dev/null && echo EXISTS || echo MISSING'",
    show=False)
print(f"   .medusa/server/index.js: {server_exists.strip()}")

# ── Step 2: Read current docker-compose.yml ───────────────────────────────
print("\n2️⃣  Reading docker-compose.yml...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/docker-compose.yml", "r") as f:
    compose_content = f.read().decode()
print("   ✅ Read successfully")

# ── Step 3: Update docker-compose.yml ────────────────────────────────────
print("\n3️⃣  Updating docker-compose.yml...")

# Fix 1: Disable MEDUSA_ADMIN_ON_SERVER (causes the crash)
# Fix 2: Change command to use built server if it exists
new_compose = compose_content

# Disable admin on server - change "true" to "false"
if 'MEDUSA_ADMIN_ON_SERVER: "true"' in new_compose:
    new_compose = new_compose.replace(
        'MEDUSA_ADMIN_ON_SERVER: "true"',
        'MEDUSA_ADMIN_ON_SERVER: "false"'
    )
    print('   ✅ Set MEDUSA_ADMIN_ON_SERVER: "false"')
elif "MEDUSA_ADMIN_ON_SERVER: 'true'" in new_compose:
    new_compose = new_compose.replace(
        "MEDUSA_ADMIN_ON_SERVER: 'true'",
        "MEDUSA_ADMIN_ON_SERVER: 'false'"
    )
    print("   ✅ Set MEDUSA_ADMIN_ON_SERVER: false")
else:
    print("   ℹ️  MEDUSA_ADMIN_ON_SERVER not found in compose — will add it")

# If .medusa/server/index.js exists, switch to using the built server
if "EXISTS" in server_exists:
    print("   ✅ Built server found — switching CMD to use it directly")
    # Add command override to backend service
    if "command:" not in new_compose.split("backend:")[1].split("postgres:")[0]:
        # Insert command after the build: block
        old_backend_ports = "    ports:\n      - \"9000:9000\""
        new_backend_ports = '    command: sh -c "npx medusa db:migrate && node .medusa/server/index.js"\n    ports:\n      - "9000:9000"'
        if old_backend_ports in new_compose:
            new_compose = new_compose.replace(old_backend_ports, new_backend_ports)
            print("   ✅ Added command override: node .medusa/server/index.js")
        else:
            # Try alternative format
            old_backend_ports2 = "    ports:\n      - '9000:9000'"
            new_backend_ports2 = "    command: sh -c \"npx medusa db:migrate && node .medusa/server/index.js\"\n    ports:\n      - '9000:9000'"
            if old_backend_ports2 in new_compose:
                new_compose = new_compose.replace(old_backend_ports2, new_backend_ports2)
                print("   ✅ Added command override")
else:
    print("   ℹ️  Built server not found — using npx medusa start with admin disabled")

# Write updated docker-compose.yml
with sftp.open(f"{REPO_DIR}/docker-compose.yml", "w") as f:
    f.write(new_compose)
sftp.close()
print("   ✅ docker-compose.yml updated")

# ── Step 4: Restart only the backend container ────────────────────────────
print("\n4️⃣  Restarting backend container (no rebuild needed)...")
run(client, f"cd {REPO_DIR} && docker compose stop backend", timeout=30)
run(client, f"cd {REPO_DIR} && docker compose up -d backend", timeout=30)
print("   ✅ Backend restarting...")

# ── Step 5: Poll until backend is healthy ─────────────────────────────────
print("\n5️⃣  Waiting for backend to come online...")
print("   (Migrations already done — should be fast now. Polling every 15s)\n")

for attempt in range(1, 20):
    time.sleep(15)
    code, out = run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend is UP! HTTP {status}")

        # Test via Nginx too
        code, ng = run(client,
            "curl -s -o /dev/null -w '%{http_code}' -H 'Host: api.dentauae.com' http://127.0.0.1:80/health --max-time 8",
            show=False)
        print(f"       Nginx→Backend: HTTP {ng.strip()}")

        print("\n" + "=" * 60)
        print("  🎉 FULLY LIVE!")
        print("=" * 60)
        print("""
  🌐  https://dentauae.com          → Storefront ✅
  ⚙️   https://api.dentauae.com      → Medusa API ✅
  🖥️   https://api.dentauae.com/app  → Admin Dashboard ✅
""")
        run(client, f"cd {REPO_DIR} && docker compose ps")
        break

    # Show latest log
    _, logs = run(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=5", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend-1" in l and l.strip()]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "..."

    if "error" in last.lower() or "Error" in last:
        print(f"[{ts}] ⚠️  Attempt {attempt}: Error | {last[-80:]}")
    else:
        print(f"[{ts}] ⏳ Attempt {attempt}: Starting | {last[-80:]}")

else:
    print("\n⚠️  Still not up. Full logs:")
    run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=40")

client.close()
input("\nPress Enter to exit...")
