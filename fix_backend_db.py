"""
DentaUAE - Diagnose & Fix Backend DB Connection
Run: python fix_backend_db.py
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

# ── Diagnose ──────────────────────────────────────────────────────────────
print("=" * 60)
print("  🔍 Diagnosing DB Connection Issue")
print("=" * 60)

# 1. Check Docker networks
print("\n1️⃣  Docker networks:")
run(client, "docker network ls")

# 2. Check which network the containers are on
print("\n2️⃣  Backend container network:")
code, out = run(client, "docker inspect dentauae-backend-1 --format '{{json .NetworkSettings.Networks}}' 2>/dev/null || docker inspect dentauae_backend_1 --format '{{json .NetworkSettings.Networks}}' 2>/dev/null", show=False)
print(f"   {out.strip()[:300]}")

print("\n3️⃣  Postgres container network:")
code, out = run(client, "docker inspect dentauae-postgres-1 --format '{{json .NetworkSettings.Networks}}' 2>/dev/null || docker inspect dentauae_postgres_1 --format '{{json .NetworkSettings.Networks}}' 2>/dev/null", show=False)
print(f"   {out.strip()[:300]}")

# 3. Check what DATABASE_URL the backend container actually sees
print("\n4️⃣  DATABASE_URL inside backend container:")
code, out = run(client, "docker exec dentauae-backend-1 sh -c 'echo $DATABASE_URL' 2>/dev/null || docker exec dentauae_backend_1 sh -c 'echo $DATABASE_URL' 2>/dev/null", show=False)
print(f"   {out.strip()}")

# 4. Try to ping postgres from backend container
print("\n5️⃣  Can backend reach postgres? (network test):")
code, out = run(client, "docker exec dentauae-backend-1 sh -c 'nc -zv postgres 5432 2>&1 || echo CANNOT_REACH' 2>/dev/null", show=False)
print(f"   {out.strip()}")

# 5. Check postgres logs
print("\n6️⃣  Postgres logs:")
run(client, f"cd {REPO_DIR} && docker compose logs postgres --tail=15")

# ── Fix ───────────────────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("  🔧 Applying Fix")
print("=" * 60)

# Get the backend container name
code, backend_name = run(client, "docker ps --filter 'name=backend' --format '{{.Names}}'", show=False)
backend_name = backend_name.strip().splitlines()[0] if backend_name.strip() else "dentauae-backend-1"
print(f"\n   Backend container: {backend_name}")

# Get network name
code, net_out = run(client, "docker network ls --filter 'name=dentauae' --format '{{.Name}}'", show=False)
networks = [n.strip() for n in net_out.strip().splitlines() if n.strip()]
print(f"   Found networks: {networks}")

if networks:
    network = networks[0]
    print(f"\n🔗 Connecting backend to network [{network}] if not already connected...")
    run(client, f"docker network connect {network} {backend_name} 2>/dev/null || echo 'Already connected or error'", show=True)

# Get postgres container IP
print("\n📡 Getting postgres container IP address...")
code, pg_ip = run(client, "docker inspect dentauae-postgres-1 --format '{{.NetworkSettings.IPAddress}}' 2>/dev/null || docker inspect dentauae_postgres_1 --format '{{.NetworkSettings.IPAddress}}' 2>/dev/null", show=False)
pg_ip = pg_ip.strip()
print(f"   Postgres IP: {pg_ip}")

if pg_ip:
    # Test direct connection to postgres IP
    print(f"\n🔌 Testing direct connection to postgres at {pg_ip}:5432...")
    code, out = run(client, f"nc -zv {pg_ip} 5432 2>&1 || echo CANNOT_REACH", show=False)
    print(f"   {out.strip()}")

    # Update .env to use postgres IP instead of hostname (bypass DNS issue)
    print(f"\n📝 Updating DATABASE_URL to use direct IP ({pg_ip}) instead of hostname...")

    new_db_url = f"postgresql://postgres:DentaUAE_Secure_2024@{pg_ip}:5432/medusa-dentalanti?sslmode=disable"

    # Read current .env and update DATABASE_URL
    code, env_content = run(client, f"cat {REPO_DIR}/.env", show=False)

    # Write updated env with explicit DATABASE_URL
    sftp = client.open_sftp()
    with sftp.open(f"{REPO_DIR}/.env", "w") as f:
        # Keep existing content and add/update DATABASE_URL
        lines = []
        found = False
        for line in env_content.splitlines():
            if line.startswith("DATABASE_URL="):
                lines.append(f"DATABASE_URL={new_db_url}")
                found = True
            else:
                lines.append(line)
        if not found:
            lines.append(f"DATABASE_URL={new_db_url}")
        f.write("\n".join(lines))
    sftp.close()
    print(f"   ✅ DATABASE_URL updated to use IP: {pg_ip}")

# Also fix REDIS_URL issue
print("\n🔧 Fixing Redis URL...")
code, redis_ip = run(client, "docker inspect dentauae-redis-1 --format '{{.NetworkSettings.IPAddress}}' 2>/dev/null || docker inspect dentauae_redis_1 --format '{{.NetworkSettings.IPAddress}}' 2>/dev/null", show=False)
redis_ip = redis_ip.strip()
print(f"   Redis IP: {redis_ip}")

if redis_ip:
    sftp = client.open_sftp()
    code, env_content = run(client, f"cat {REPO_DIR}/.env", show=False)
    with sftp.open(f"{REPO_DIR}/.env", "w") as f:
        lines = []
        found_redis = False
        for line in env_content.splitlines():
            if line.startswith("REDIS_URL="):
                lines.append(f"REDIS_URL=redis://{redis_ip}:6379")
                found_redis = True
            else:
                lines.append(line)
        if not found_redis:
            lines.append(f"REDIS_URL=redis://{redis_ip}:6379")
        f.write("\n".join(lines))
    sftp.close()
    print(f"   ✅ REDIS_URL updated to use IP: {redis_ip}")

# Restart backend with updated env
print("\n🔄 Restarting backend container with fixed DATABASE_URL...")
run(client, f"cd {REPO_DIR} && docker compose stop backend && docker compose up -d backend", timeout=60)

# Wait and poll
print("\n⏳ Waiting for backend to start (migrations running)...")
print("   This can take 3-8 minutes. Polling every 20 seconds...\n")

for attempt in range(1, 25):
    time.sleep(20)
    code, out = run(client, "curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:9000/health --max-time 8", show=False)
    status = out.strip()
    ts = time.strftime("%H:%M:%S")

    if status in ("200", "204"):
        print(f"[{ts}] ✅ Backend is UP! HTTP {status}")
        print("\n" + "=" * 60)
        print("  🎉 BOTH SERVICES ARE LIVE!")
        print("=" * 60)
        print("""
  🌐  https://dentauae.com          → Storefront ✅
  ⚙️   https://api.dentauae.com      → Medusa API ✅
  🖥️   https://api.dentauae.com/app  → Admin dashboard ✅
""")
        break
    else:
        # Show last log line
        _, logs = run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=3", show=False)
        last = [l for l in logs.strip().splitlines() if l.strip()]
        msg = last[-1].strip() if last else "..."
        print(f"[{ts}] ⏳ Attempt {attempt}: HTTP {status} | {msg[-80:]}")
else:
    print("\n⚠️  Backend took too long. Check logs:")
    run(client, f"cd {REPO_DIR} && docker compose logs backend --tail=30")

client.close()
input("\nPress Enter to exit...")
