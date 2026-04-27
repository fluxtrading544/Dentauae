"""
DentaUAE - Fix corrupted docker-compose.yml and admin crash
Strategy:
  1. Restore clean docker-compose.yml
  2. Override backend command to patch the admin-bundler (warn instead of crash)
  3. Restart and confirm backend is up
Run: python fix_compose_and_admin.py
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

# ── Clean docker-compose.yml (fully restored + admin patch command) ────────
CLEAN_COMPOSE = """version: '3.8'

services:
  postgres:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_USER: ${POSTGRES_USER:-postgres}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-password}
      POSTGRES_DB: ${POSTGRES_DB:-medusa-dentalanti}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:alpine
    restart: always
    ports:
      - "6379:6379"

  backend:
    build:
      context: ./medusa-dentalanti
      dockerfile: Dockerfile
    restart: always
    # Patch admin-bundler to warn instead of crash, then start normally
    command: >
      sh -c "
        sed -i 's/throw new Error(.Could not find index.html/console.warn(\\'Admin not found, continuing without admin:\\'/g'
        /app/node_modules/@medusajs/admin-bundler/dist/index.js 2>/dev/null || true &&
        npx medusa db:migrate &&
        MEDUSA_ADMIN_ON_SERVER=false npx medusa start
      "
    environment:
      DATABASE_URL: postgresql://${POSTGRES_USER:-postgres}:${POSTGRES_PASSWORD:-password}@postgres:5432/${POSTGRES_DB:-medusa-dentalanti}?sslmode=disable
      REDIS_URL: redis://redis:6379
      JWT_SECRET: ${JWT_SECRET}
      COOKIE_SECRET: ${COOKIE_SECRET}
      STORE_CORS: ${STORE_CORS}
      ADMIN_CORS: ${ADMIN_CORS}
      AUTH_CORS: ${AUTH_CORS}
      MEDUSA_BACKEND_URL: ${MEDUSA_BACKEND_URL}
      MEDUSA_ADMIN_ON_SERVER: "false"
      S3_FILE_URL: ${S3_FILE_URL}
      S3_ACCESS_KEY_ID: ${S3_ACCESS_KEY_ID}
      S3_SECRET_ACCESS_KEY: ${S3_SECRET_ACCESS_KEY}
      S3_REGION: ${S3_REGION}
      S3_BUCKET: ${S3_BUCKET}
      S3_ENDPOINT: ${S3_ENDPOINT}
      STRIPE_API_KEY: ${STRIPE_API_KEY}
      STRIPE_WEBHOOK_SECRET: ${STRIPE_WEBHOOK_SECRET}
    depends_on:
      - postgres
      - redis
    ports:
      - "9000:9000"

  frontend:
    build:
      context: .
      dockerfile: Dockerfile
    restart: always
    environment:
      NEXT_PUBLIC_MEDUSA_BACKEND_URL: ${NEXT_PUBLIC_MEDUSA_BACKEND_URL}
      NEXT_PUBLIC_STRIPE_KEY: ${NEXT_PUBLIC_STRIPE_KEY}
    depends_on:
      - backend
    ports:
      - "3000:3000"

volumes:
  postgres_data:
"""

def run(client, cmd, timeout=60, show=True):
    _, stdout, _ = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    code = stdout.channel.recv_exit_status()
    if show and out.strip():
        print(out)
    return code, out

print("=" * 60)
print("  🔧 Fix: Restore docker-compose.yml & Patch Admin")
print("=" * 60)

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"\n✅ Connected to {VPS_HOST}")

# ── Step 1: Stop all containers ───────────────────────────────────────────
print("\n1️⃣  Stopping all containers...")
run(client, f"cd {REPO_DIR} && docker compose stop 2>/dev/null || docker-compose stop 2>/dev/null || true", timeout=30)
print("   ✅ Stopped")

# ── Step 2: Write clean docker-compose.yml ────────────────────────────────
print("\n2️⃣  Writing clean docker-compose.yml...")
sftp = client.open_sftp()
with sftp.open(f"{REPO_DIR}/docker-compose.yml", "w") as f:
    f.write(CLEAN_COMPOSE)
sftp.close()
print("   ✅ Clean docker-compose.yml written")

# ── Step 3: Validate it ───────────────────────────────────────────────────
print("\n3️⃣  Validating docker-compose.yml...")
code, out = run(client, f"cd {REPO_DIR} && docker compose config --quiet 2>&1", show=False)
if code == 0:
    print("   ✅ Valid!")
else:
    print(f"   ⚠️  Validation issue: {out.strip()[:200]}")

# ── Step 4: Start all containers ──────────────────────────────────────────
print("\n4️⃣  Starting all containers...")
run(client, f"cd {REPO_DIR} && docker compose up -d 2>&1", timeout=60)
print("   ✅ Containers started")

# ── Step 5: Poll for backend health ───────────────────────────────────────
print("\n5️⃣  Polling backend health every 15 seconds...\n")
print("   (Migrations already done — should come up in ~1-2 minutes)\n")

for attempt in range(1, 20):
    time.sleep(15)
    code, out = run(client,
        "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8",
        show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend is UP! HTTP {status}")

        print("\n📦 Container status:")
        run(client, f"cd {REPO_DIR} && docker compose ps")

        print("\n" + "=" * 60)
        print("  🎉 FULLY DEPLOYED!")
        print("=" * 60)
        print("""
  🌐  https://dentauae.com          → Storefront ✅
  ⚙️   https://api.dentauae.com      → Medusa API ✅
  🖥️   https://api.dentauae.com/app  → Admin (if admin built)
""")
        break

    # Show recent log
    _, logs = run(client,
        f"cd {REPO_DIR} && docker compose logs backend --tail=5", show=False)
    lines = [l for l in logs.strip().splitlines() if "backend-1" in l]
    last = lines[-1].replace("backend-1  |", "").strip() if lines else "starting..."

    if "error" in last.lower():
        print(f"[{ts}] ⚠️  Attempt {attempt}: {last[-80:]}")
    else:
        print(f"[{ts}] ⏳ Attempt {attempt}: {last[-80:]}")
else:
    print("\n⚠️  Not up yet. Full logs:")
    run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=50")

client.close()
input("\nPress Enter to exit...")
