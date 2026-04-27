"""
DentaUAE - Admin Panel Fix v2
Inspects the actual container to find where admin files are, then applies correct fix.
Run: python fix_admin_v2.py
"""
import sys, time, subprocess

try:
    import paramiko
except ImportError:
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko

VPS_HOST     = "76.13.254.103"
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"
REPO_DIR     = "/root/Dentauae"
LOCAL_DIR    = r"F:\dentalanti"

VPS_ENV = """POSTGRES_USER=postgres
POSTGRES_PASSWORD=DentaUAE_Secure_2024
POSTGRES_DB=medusa-dentalanti
JWT_SECRET=supersecret
COOKIE_SECRET=supersecret
STORE_CORS=https://dentauae.com,https://www.dentauae.com,http://localhost:3000
ADMIN_CORS=https://api.dentauae.com,https://dentauae.com,http://localhost:9000
AUTH_CORS=https://dentauae.com,https://www.dentauae.com,https://api.dentauae.com,http://localhost:3000,http://localhost:9000
MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_064df238affda70c81a72fcf01d8f2da8edf8e4136b95830ba5e4ebebc774b27
MEDUSA_ADMIN_ON_SERVER=false
STRIPE_API_KEY=sk_test_placeholder
STRIPE_WEBHOOK_SECRET=whsec_placeholder
NEXT_PUBLIC_STRIPE_KEY=pk_test_placeholder
S3_FILE_URL=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com/dentauae-media
S3_ACCESS_KEY_ID=803cfa209978c7106410e0aaa49a4ec5
S3_SECRET_ACCESS_KEY=422d5dee778706d4b95636ebd72f835ef44e4eb02d05fcaccbda8c1305f84980
S3_REGION=auto
S3_BUCKET=dentauae-media
S3_ENDPOINT=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com
"""

def ssh_run(client, cmd, timeout=60, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

def local(cmd):
    print(f"   $ {cmd}")
    r = subprocess.run(cmd, shell=True, cwd=LOCAL_DIR, capture_output=True, text=True)
    if r.stdout.strip(): print(f"   {r.stdout.strip()}")
    if r.returncode != 0 and r.stderr.strip(): print(f"   ⚠️  {r.stderr.strip()}")
    return r.returncode

print("=" * 65)
print("  🔧  DentaUAE Admin Fix v2")
print("=" * 65)

# ── Connect ───────────────────────────────────────────────────────────────────
print("\n🔌 Connecting to VPS...")
client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print("   ✅ Connected\n")

# ── Start stable temp container ───────────────────────────────────────────────
print("🔍 Starting temp inspection container (stable - won't crash)...")
ssh_run(client, "docker rm -f temp_inspect 2>/dev/null || true", show=False)
code, out = ssh_run(client,
    f"docker run -d --name temp_inspect "
    f"--env-file {REPO_DIR}/.env "
    f"dentauae-backend sleep 7200",
    show=False)
if code != 0:
    print(f"❌ Failed to start temp container:\n{out}")
    client.close()
    sys.exit(1)
time.sleep(3)
print("   ✅ Temp container running\n")

# ── Find all index.html files under /app/.medusa ─────────────────────────────
print("=" * 65)
print("📁 All index.html files under /app/.medusa:")
code, out = ssh_run(client,
    "docker exec temp_inspect find /app/.medusa -name 'index.html' 2>/dev/null | sort",
    show=False)
if out.strip():
    print(out)
else:
    print("   (none found in .medusa)")

print("\n📁 Full .medusa directory tree (depth 4):")
ssh_run(client, "docker exec temp_inspect find /app/.medusa -maxdepth 4 | sort")

# ── Check admin.js for outDir ─────────────────────────────────────────────────
print("\n" + "=" * 65)
print("🔎 Admin loader - outDir references:")
ssh_run(client,
    "docker exec temp_inspect sh -c \""
    "grep -n 'outDir\\|adminBuild\\|client\\|\\.medusa\\|public\\|serve(' "
    "/app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null | head -50"
    "\"")

print("\n🔎 Admin bundler serve() - outDir usage:")
ssh_run(client,
    "docker exec temp_inspect sh -c \""
    "grep -n 'outDir\\|index\\.html\\|Could not find' "
    "/app/node_modules/@medusajs/admin-bundler/dist/index.js 2>/dev/null | head -30"
    "\"")

print("\n🔎 Lines around 'serveProductionBuild' in admin.js:")
ssh_run(client,
    "docker exec temp_inspect sh -c \""
    "grep -n -B2 -A10 'serveProductionBuild\\|serve(' "
    "/app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null | head -60"
    "\"")

# ── Check what actually exists ────────────────────────────────────────────────
print("\n" + "=" * 65)
print("📂 Contents of /app/.medusa/server/ (if exists):")
ssh_run(client,
    "docker exec temp_inspect ls -la /app/.medusa/server/ 2>/dev/null || echo '  (not found)'")

print("\n📂 Contents of /app/.medusa/server/public/ (if exists):")
ssh_run(client,
    "docker exec temp_inspect ls -la /app/.medusa/server/public/ 2>/dev/null || echo '  (not found)'")

print("\n📂 Contents of /app/.medusa/client/ (if exists):")
ssh_run(client,
    "docker exec temp_inspect ls -la /app/.medusa/client/ 2>/dev/null || echo '  (not found)'")

print("\n📂 Find index.html ANYWHERE under /app (excluding node_modules):")
code, out = ssh_run(client,
    "docker exec temp_inspect find /app -name 'index.html' "
    "-not -path '*/node_modules/*' 2>/dev/null | sort",
    show=False)
if out.strip():
    print(out)
else:
    print("   (no index.html found outside node_modules!)")

# ── Parse outDir from admin.js ────────────────────────────────────────────────
print("\n" + "=" * 65)
print("📖 Full admin.js content (first 80 lines):")
ssh_run(client,
    "docker exec temp_inspect sh -c \""
    "head -80 /app/node_modules/@medusajs/medusa/dist/loaders/admin.js 2>/dev/null"
    "\"")

# ── Cleanup temp container ────────────────────────────────────────────────────
ssh_run(client, "docker rm -f temp_inspect", show=False)
print("\n✅ Temp container removed")

# ── Determine fix based on findings ──────────────────────────────────────────
print("\n" + "=" * 65)
print("🛠️  Applying comprehensive Dockerfile fix...")
print("   Strategy: Ensure admin files exist at ALL possible locations\n")

# Write a new Dockerfile that handles all outDir possibilities
new_dockerfile = '''FROM node:20

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \\
    python3 \\
    build-essential \\
    libvips-dev \\
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# Build everything (compiles admin UI + backend)
RUN npx medusa build

# Debug: show what medusa build produced
RUN echo "=== .medusa tree after build ===" && find /app/.medusa -maxdepth 4 | sort || true

# Ensure admin index.html is accessible at every path the bundler might check:
# 1) .medusa/server/public/ (Medusa v2 standard output)
# 2) .medusa/client/ (alternative outDir some versions use)
# 3) .medusa/server/public/app/ (path variant)
RUN set -e; \\
    if [ -d /app/.medusa/server/public ] && [ -f /app/.medusa/server/public/index.html ]; then \\
        echo "Admin already at .medusa/server/public/"; \\
        mkdir -p /app/.medusa/client; \\
        cp -r /app/.medusa/server/public/. /app/.medusa/client/ 2>/dev/null || true; \\
    elif [ -d /app/.medusa/client ] && [ -f /app/.medusa/client/index.html ]; then \\
        echo "Admin at .medusa/client/, copying to .medusa/server/public/"; \\
        mkdir -p /app/.medusa/server/public; \\
        cp -r /app/.medusa/client/. /app/.medusa/server/public/ 2>/dev/null || true; \\
    else \\
        echo "WARNING: No admin index.html found after medusa build!"; \\
        find /app/.medusa -name "index.html" 2>/dev/null || true; \\
    fi

EXPOSE 9000

# Run DB migrations then start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
'''

# Write locally
with open(r"F:\dentalanti\medusa-dentalanti\Dockerfile", "w") as f:
    f.write(new_dockerfile)
print("   ✅ Dockerfile updated locally")

# ── Push to GitHub ────────────────────────────────────────────────────────────
print("\n📤 Pushing to GitHub...")
local("git add medusa-dentalanti/Dockerfile medusa-dentalanti/medusa-config.ts")
local('git commit -m "fix: robust admin file path handling - copy to all possible outDir locations"')
rc = local("git push origin main")
if rc != 0:
    print("   ⚠️  Git push failed - check your git credentials")
    client.close()
    sys.exit(1)
print("   ✅ Pushed!")

# ── Pull on VPS ───────────────────────────────────────────────────────────────
print("\n📥 Pulling on VPS...")
ssh_run(client, f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main")

# ── Restore .env ──────────────────────────────────────────────────────────────
print("\n🔑 Restoring .env...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/.env", "w") as f:
    f.write(VPS_ENV)
sftp.close()
print("   ✅ .env restored")

# ── Rebuild backend ───────────────────────────────────────────────────────────
print("\n🏗️  Rebuilding backend (--no-cache, takes 10-15 min)...")
ssh_run(client, f"cd {REPO_DIR} && docker compose stop backend", timeout=20)
code, out = ssh_run(client,
    f"cd {REPO_DIR} && docker compose build --no-cache backend 2>&1",
    timeout=1200)
if code != 0:
    print(f"\n❌ Build failed. Last 500 chars:\n{out[-500:]}")
    client.close()
    sys.exit(1)
print("   ✅ Build complete!")

# ── Start all ─────────────────────────────────────────────────────────────────
print("\n🚀 Starting all containers...")
ssh_run(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)

# ── Poll for health ───────────────────────────────────────────────────────────
print("\n⏳ Waiting for backend to come up...\n")
admin_ok = False
for attempt in range(1, 25):
    time.sleep(20)
    code, out = ssh_run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend UP! HTTP {status}")

        code, adm = ssh_run(client,
            "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/app --max-time 8",
            show=False)
        adm_status = adm.strip()
        print(f"       Admin (/app): HTTP {adm_status}")
        if adm_status in ("200", "301", "302"):
            admin_ok = True
        break

    _, logs = ssh_run(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=5", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend-1" in l or "backend" in l.lower()]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "..."

    if "Could not find index.html" in last:
        print(f"[{ts}] ❌ Still hitting index.html error: {last[-80:]}")
        print("       → Checking build output in running container...")
        ssh_run(client,
            "docker exec dentauae-backend-1 find /app/.medusa -name 'index.html' 2>/dev/null | head -10 || true",
            show=False)
        break
    elif "error" in last.lower():
        print(f"[{ts}] ⚠️  Attempt {attempt}: {last[-80:]}")
    else:
        print(f"[{ts}] ⏳ Attempt {attempt}: {last[-80:]}")
else:
    print("\n⏱️  Timed out waiting. Showing backend logs:")
    ssh_run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=50")

# ── Final status ──────────────────────────────────────────────────────────────
print("\n" + "=" * 65)
if admin_ok:
    print("  🎉 SUCCESS! Admin panel is accessible!")
    print("""
  🌐  https://dentauae.com            → Storefront
  ⚙️   https://api.dentauae.com        → Medusa API
  🖥️   https://api.dentauae.com/app    → Admin Panel
""")
else:
    print("  ℹ️  Backend is running. Check output above for admin status.")
    print("     If admin still fails, run python check_admin_v2.py for deeper diagnosis.")

ssh_run(client, f"cd {REPO_DIR} && docker compose ps")
client.close()
input("\nPress Enter to exit...")
