"""
DentaUAE VPS Deployment Script
Connects to your VPS via SSH and deploys the full stack automatically.
Run this file with Python: python deploy_vps.py
"""

import sys
import time

# ─── Check & Install paramiko ───────────────────────────────────────────────
try:
    import paramiko
except ImportError:
    print("📦 Installing required SSH library (paramiko)...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "paramiko"])
    import paramiko
    print("✅ paramiko installed.\n")

# ─── VPS Configuration ──────────────────────────────────────────────────────
VPS_HOST     = "76.13.254.103"
VPS_PORT     = 22
VPS_USER     = "root"
VPS_PASSWORD = "BxCY;RBM#,2Fhs2b"
REPO_DIR     = "/root/Dentauae"
GITHUB_REPO  = "https://github.com/fluxtrading544/Dentauae.git"

# ─── .env content for VPS ───────────────────────────────────────────────────
VPS_ENV_CONTENT = """# ── Database ────────────────────────────────────
POSTGRES_USER=postgres
POSTGRES_PASSWORD=DentaUAE_Secure_2024
POSTGRES_DB=medusa-dentalanti

# ── Medusa Backend Secrets ───────────────────────
JWT_SECRET=supersecret
COOKIE_SECRET=supersecret

# ── CORS Settings (VPS IP) ───────────────────────
STORE_CORS=http://76.13.254.103:3000,http://localhost:3000
ADMIN_CORS=http://76.13.254.103:9000,http://localhost:9000
AUTH_CORS=http://76.13.254.103:3000,http://76.13.254.103:9000,http://localhost:3000,http://localhost:9000

# ── Medusa Backend URL ───────────────────────────
MEDUSA_BACKEND_URL=http://76.13.254.103:9000
NEXT_PUBLIC_MEDUSA_BACKEND_URL=http://76.13.254.103:9000
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=pk_064df238affda70c81a72fcf01d8f2da8edf8e4136b95830ba5e4ebebc774b27
MEDUSA_ADMIN_ON_SERVER=true

# ── Stripe ───────────────────────────────────────
STRIPE_API_KEY=sk_test_placeholder
STRIPE_WEBHOOK_SECRET=whsec_placeholder
NEXT_PUBLIC_STRIPE_KEY=pk_test_placeholder

# ── Cloudflare R2 (Image Storage) ────────────────
S3_FILE_URL=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com/dentauae-media
S3_ACCESS_KEY_ID=803cfa209978c7106410e0aaa49a4ec5
S3_SECRET_ACCESS_KEY=422d5dee778706d4b95636ebd72f835ef44e4eb02d05fcaccbda8c1305f84980
S3_REGION=auto
S3_BUCKET=dentauae-media
S3_ENDPOINT=https://0bc91299699f94afd21ff4d0f4bb.r2.cloudflarestorage.com
"""

# ─── Helper: Run a command on VPS ───────────────────────────────────────────
def run(client, command, timeout=300, show_output=True):
    """Run a command via SSH and return (exit_code, stdout, stderr)."""
    print(f"\n▶  {command}")
    print("─" * 60)
    stdin, stdout, stderr = client.exec_command(command, timeout=timeout, get_pty=True)

    full_output = ""
    while True:
        line = stdout.readline()
        if not line:
            break
        if show_output:
            print(line, end="", flush=True)
        full_output += line

    exit_code = stdout.channel.recv_exit_status()
    err = stderr.read().decode(errors="replace")

    if err and show_output:
        print(err)

    if exit_code != 0:
        print(f"\n⚠️  Command exited with code {exit_code}")
        if err:
            print(f"   Error: {err[:300]}")

    return exit_code, full_output, err


def run_silent(client, command, timeout=30):
    """Run a command quietly and return (exit_code, stdout)."""
    stdin, stdout, stderr = client.exec_command(command, timeout=timeout)
    out = stdout.read().decode(errors="replace").strip()
    exit_code = stdout.channel.recv_exit_status()
    return exit_code, out


# ─── Step 1: Connect ─────────────────────────────────────────────────────────
def connect():
    print("=" * 60)
    print("  🚀 DentaUAE VPS Deployment Script")
    print("=" * 60)
    print(f"\n📡 Connecting to {VPS_HOST} as {VPS_USER}...")

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        client.connect(
            VPS_HOST, port=VPS_PORT,
            username=VPS_USER, password=VPS_PASSWORD,
            timeout=20, auth_timeout=20
        )
        print("✅ SSH connection established!\n")
        return client
    except Exception as e:
        print(f"❌ Connection failed: {e}")
        print("\nPlease check:")
        print("  • VPS is running and port 22 is open")
        print("  • Credentials are correct")
        sys.exit(1)


# ─── Step 2: Install Docker ───────────────────────────────────────────────────
def ensure_docker(client):
    print("\n" + "=" * 60)
    print("  🐳 Checking Docker Installation")
    print("=" * 60)

    code, out = run_silent(client, "docker --version 2>/dev/null")
    if code == 0 and "Docker version" in out:
        print(f"✅ Docker already installed: {out}")
    else:
        print("📦 Docker not found. Installing Docker...")
        run(client, "curl -fsSL https://get.docker.com | sh", timeout=300)
        run(client, "systemctl enable docker && systemctl start docker", timeout=30)
        code, out = run_silent(client, "docker --version")
        if code != 0:
            print("❌ Docker installation failed!")
            sys.exit(1)
        print(f"✅ Docker installed: {out}")

    # Check Docker Compose
    code, out = run_silent(client, "docker compose version 2>/dev/null || docker-compose --version 2>/dev/null")
    if code == 0:
        print(f"✅ Docker Compose: {out}")
    else:
        print("📦 Installing Docker Compose plugin...")
        run(client, 'apt-get update && apt-get install -y docker-compose-plugin', timeout=120)


# ─── Step 3: Clone / Pull Repo ───────────────────────────────────────────────
def setup_repo(client):
    print("\n" + "=" * 60)
    print("  📂 Setting Up Repository")
    print("=" * 60)

    code, _ = run_silent(client, f"test -d {REPO_DIR}/.git")
    if code == 0:
        print(f"📁 Repo already exists at {REPO_DIR}. Pulling latest...")
        run(client, f"cd {REPO_DIR} && git fetch origin && git reset --hard origin/main && git pull origin main", timeout=120)
    else:
        print(f"📥 Cloning repository from GitHub...")
        run(client, f"git clone {GITHUB_REPO} {REPO_DIR}", timeout=120)

    # Verify
    code, out = run_silent(client, f"ls {REPO_DIR}/docker-compose.yml")
    if code != 0:
        print("❌ Repository setup failed — docker-compose.yml not found!")
        sys.exit(1)
    print(f"✅ Repository ready at {REPO_DIR}")


# ─── Step 4: Configure .env ──────────────────────────────────────────────────
def setup_env(client):
    print("\n" + "=" * 60)
    print("  ⚙️  Configuring Environment Variables")
    print("=" * 60)

    # Write .env file using Python heredoc over SSH
    env_escaped = VPS_ENV_CONTENT.replace("'", "'\"'\"'")
    write_cmd = f"cat > {REPO_DIR}/.env << 'ENVEOF'\n{VPS_ENV_CONTENT}\nENVEOF"

    sftp = client.open_sftp()
    with sftp.open(f"{REPO_DIR}/.env", "w") as f:
        f.write(VPS_ENV_CONTENT)
    sftp.close()

    print(f"✅ .env file written to {REPO_DIR}/.env")

    # Verify
    code, out = run_silent(client, f"grep 'POSTGRES_USER' {REPO_DIR}/.env")
    if code == 0:
        print(f"✅ Verified: {out}")
    else:
        print("❌ .env verification failed!")
        sys.exit(1)


# ─── Step 5: Stop Old Containers ─────────────────────────────────────────────
def stop_old_containers(client):
    print("\n" + "=" * 60)
    print("  🛑 Stopping Any Running Containers")
    print("=" * 60)

    # Try both docker-compose and docker compose
    code, _ = run_silent(client, f"cd {REPO_DIR} && docker compose down 2>/dev/null || docker-compose down 2>/dev/null")
    print("✅ Old containers stopped (or none were running).")


# ─── Step 6: Build & Start ───────────────────────────────────────────────────
def build_and_start(client):
    print("\n" + "=" * 60)
    print("  🏗️  Building & Launching All Services")
    print("  (This takes 5-15 minutes — building Node.js apps)")
    print("=" * 60)

    # Determine compose command
    code, _ = run_silent(client, "docker compose version 2>/dev/null")
    compose_cmd = "docker compose" if code == 0 else "docker-compose"

    print(f"Using: {compose_cmd}")
    build_cmd = f"cd {REPO_DIR} && {compose_cmd} up -d --build 2>&1"

    code, out, err = run(client, build_cmd, timeout=900)  # 15 min timeout

    if code != 0:
        print(f"\n❌ Build failed with exit code {code}")
        print("   Checking logs for clues...")
        run(client, f"cd {REPO_DIR} && {compose_cmd} logs --tail=50", timeout=30)
        sys.exit(1)

    print("\n✅ Docker Compose build completed!")
    return compose_cmd


# ─── Step 7: Verify Services ─────────────────────────────────────────────────
def verify_services(client, compose_cmd):
    print("\n" + "=" * 60)
    print("  ✅ Verifying Running Services")
    print("=" * 60)

    print("\n⏳ Waiting 15 seconds for services to start up...")
    time.sleep(15)

    run(client, f"cd {REPO_DIR} && {compose_cmd} ps", timeout=30)

    # Check if backend is up
    print("\n🔍 Checking backend health (port 9000)...")
    for attempt in range(1, 4):
        code, out = run_silent(client, "curl -s -o /dev/null -w '%{http_code}' http://localhost:9000/health --max-time 5")
        print(f"   Attempt {attempt}: HTTP {out}")
        if out in ("200", "404"):  # 404 means server is up but route not found
            print("✅ Backend is responding!")
            break
        time.sleep(10)
    else:
        print("⚠️  Backend may still be starting (migrations can take a minute)")
        print("   Check logs: docker compose logs backend --tail=30")

    # Check if frontend is up
    print("\n🔍 Checking frontend health (port 3000)...")
    for attempt in range(1, 4):
        code, out = run_silent(client, "curl -s -o /dev/null -w '%{http_code}' http://localhost:3000 --max-time 5")
        print(f"   Attempt {attempt}: HTTP {out}")
        if out in ("200", "404", "301", "302"):
            print("✅ Frontend is responding!")
            break
        time.sleep(10)
    else:
        print("⚠️  Frontend may still be building. Check: docker compose logs frontend --tail=30")

    print("\n" + "=" * 60)
    print("  🎉 DEPLOYMENT COMPLETE!")
    print("=" * 60)
    print(f"\n  🌐 Frontend:  http://{VPS_HOST}:3000")
    print(f"  ⚙️  Backend:   http://{VPS_HOST}:9000")
    print(f"  🖥️  Dashboard: http://{VPS_HOST}:9000/app")
    print("\n  To monitor logs:")
    print(f"    ssh root@{VPS_HOST}")
    print(f"    cd {REPO_DIR}")
    print(f"    {compose_cmd} logs -f\n")


# ─── Main ─────────────────────────────────────────────────────────────────────
def main():
    client = connect()

    try:
        ensure_docker(client)
        setup_repo(client)
        setup_env(client)
        stop_old_containers(client)
        compose_cmd = build_and_start(client)
        verify_services(client, compose_cmd)
    except KeyboardInterrupt:
        print("\n\n⚠️  Deployment interrupted by user.")
    except SystemExit as e:
        print(f"\n❌ Deployment stopped at a critical error (code {e.code}).")
        print("   Fix the issue and re-run this script.")
        raise
    finally:
        client.close()
        print("\n📡 SSH connection closed.")

    input("\nPress Enter to exit...")


if __name__ == "__main__":
    main()
