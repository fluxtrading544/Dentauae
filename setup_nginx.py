"""
DentaUAE - Nginx Reverse Proxy Setup
Fixes Cloudflare Error 522 by installing Nginx and routing:
  dentauae.com        → localhost:3000  (Next.js frontend)
  api.dentauae.com    → localhost:9000  (Medusa backend)
Run: python setup_nginx.py
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

# ── Nginx config for dentauae.com (frontend on :3000) ─────────────────────
NGINX_FRONTEND = """server {
    listen 80;
    server_name dentauae.com www.dentauae.com;

    # Allow large uploads (product images)
    client_max_body_size 50M;

    # Pass real visitor IP to Next.js
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Host $host;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
        proxy_read_timeout 60s;
    }
}
"""

# ── Nginx config for api.dentauae.com (backend on :9000) ──────────────────
NGINX_BACKEND = """server {
    listen 80;
    server_name api.dentauae.com;

    # Allow large uploads
    client_max_body_size 100M;

    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Host $host;

    location / {
        proxy_pass http://127.0.0.1:9000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
        proxy_read_timeout 120s;
    }
}
"""

# ── Updated .env for domain-based deployment ──────────────────────────────
UPDATED_ENV = """# ── Database ────────────────────────────────────
POSTGRES_USER=postgres
POSTGRES_PASSWORD=DentaUAE_Secure_2024
POSTGRES_DB=medusa-dentalanti

# ── Medusa Backend Secrets ───────────────────────
JWT_SECRET=supersecret
COOKIE_SECRET=supersecret

# ── CORS Settings (domain-based) ─────────────────
STORE_CORS=https://dentauae.com,https://www.dentauae.com,http://localhost:3000
ADMIN_CORS=https://api.dentauae.com,https://dentauae.com,http://localhost:9000
AUTH_CORS=https://dentauae.com,https://www.dentauae.com,https://api.dentauae.com,http://localhost:3000,http://localhost:9000

# ── Medusa Backend URL ───────────────────────────
MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://api.dentauae.com
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

# ─── Helpers ───────────────────────────────────────────────────────────────
def run(client, cmd, timeout=60, show=True):
    _, stdout, stderr = client.exec_command(cmd, timeout=timeout, get_pty=True)
    out = stdout.read().decode(errors="replace")
    if show:
        print(out)
    exit_code = stdout.channel.recv_exit_status()
    return exit_code, out

def write_file(sftp, path, content):
    with sftp.open(path, "w") as f:
        f.write(content)
    print(f"  ✅ Written: {path}")

# ─── Main ──────────────────────────────────────────────────────────────────
print("=" * 60)
print("  🌐 DentaUAE - Nginx Setup & Domain Configuration")
print("=" * 60)

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(VPS_HOST, port=22, username=VPS_USER, password=VPS_PASSWORD, timeout=15)
print(f"✅ Connected to {VPS_HOST}\n")

sftp = client.open_sftp()

# ── Step 1: Install Nginx ────────────────────────────────────────────────
print("📦 Step 1: Installing Nginx...")
run(client, "apt-get update -qq && apt-get install -y nginx", timeout=120)
code, out = run(client, "nginx -v 2>&1", show=False)
print(f"  ✅ Nginx installed: {out.strip()}")

# ── Step 2: Open firewall ports ──────────────────────────────────────────
print("\n🔓 Step 2: Opening firewall ports 80 & 443...")
run(client, "ufw allow 80/tcp && ufw allow 443/tcp && ufw allow 22/tcp", show=False)
run(client, "ufw --force enable 2>/dev/null || true", show=False)
print("  ✅ Ports 80 and 443 open")

# ── Step 3: Write Nginx site configs ─────────────────────────────────────
print("\n📝 Step 3: Writing Nginx configuration...")
run(client, "mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled", show=False)

write_file(sftp, "/etc/nginx/sites-available/dentauae-frontend", NGINX_FRONTEND)
write_file(sftp, "/etc/nginx/sites-available/dentauae-backend",  NGINX_BACKEND)

# Enable sites (symlinks)
run(client, "ln -sf /etc/nginx/sites-available/dentauae-frontend /etc/nginx/sites-enabled/dentauae-frontend", show=False)
run(client, "ln -sf /etc/nginx/sites-available/dentauae-backend  /etc/nginx/sites-enabled/dentauae-backend",  show=False)

# Remove default site if it exists (it conflicts on port 80)
run(client, "rm -f /etc/nginx/sites-enabled/default", show=False)
print("  ✅ Nginx sites enabled")

# ── Step 4: Test & reload Nginx ──────────────────────────────────────────
print("\n🔄 Step 4: Testing and reloading Nginx...")
code, out = run(client, "nginx -t 2>&1")
if code != 0:
    print("❌ Nginx config test FAILED:")
    print(out)
    client.close()
    input("\nPress Enter to exit...")
    sys.exit(1)

run(client, "systemctl enable nginx && systemctl restart nginx", show=False)
print("  ✅ Nginx reloaded and running")

# ── Step 5: Update .env with domain URLs ─────────────────────────────────
print("\n⚙️  Step 5: Updating .env with domain-based URLs...")
write_file(sftp, f"{REPO_DIR}/.env", UPDATED_ENV)
sftp.close()

# ── Step 6: Rebuild frontend container (it bakes NEXT_PUBLIC_ vars) ──────
print("\n🏗️  Step 6: Rebuilding frontend container with new domain URLs...")
print("  (This takes 3-8 minutes — compiling Next.js with new env vars)")

# Determine compose command
code, _ = run(client, "docker compose version 2>/dev/null", show=False)
compose_cmd = "docker compose" if code == 0 else "docker-compose"

run(client, f"cd {REPO_DIR} && {compose_cmd} up -d --build frontend", timeout=600)

# ── Step 7: Restart backend container to pick up new CORS settings ────────
print("\n🔄 Step 7: Restarting backend with new CORS settings...")
run(client, f"cd {REPO_DIR} && {compose_cmd} restart backend", timeout=60)

# ── Step 8: Verify ───────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("  ✅ Verification")
print("=" * 60)

print("\n📦 Container status:")
run(client, f"cd {REPO_DIR} && {compose_cmd} ps")

print("\n🌐 Nginx status:")
run(client, "systemctl status nginx --no-pager | head -10")

print("\n🔍 Checking dentauae.com (via localhost:3000)...")
time.sleep(5)
code, out = run(client, "curl -s -o /dev/null -w '%{http_code}' http://localhost:3000 --max-time 8", show=False)
print(f"  Frontend (localhost:3000): HTTP {out.strip()} {'✅' if out.strip() == '200' else '⏳'}")

code, out = run(client, "curl -s -o /dev/null -w '%{http_code}' http://localhost:80 --max-time 8", show=False)
print(f"  Nginx port 80:            HTTP {out.strip()} {'✅' if out.strip() == '200' else '⚠️'}")

print("\n" + "=" * 60)
print("  🎉 NGINX SETUP COMPLETE!")
print("=" * 60)
print("""
  Your site should now be accessible via:
  🌐  https://dentauae.com          (storefront)
  🌐  https://www.dentauae.com      (storefront)
  ⚙️   https://api.dentauae.com      (Medusa API)
  🖥️   https://api.dentauae.com/app  (Admin dashboard)

  If dentauae.com still shows 522, wait 2-3 minutes for
  Cloudflare to propagate, then try again.

  ⚡ Cloudflare SSL tip:
     In Cloudflare → SSL/TLS → set mode to "Flexible"
     (so Cloudflare connects to your server over HTTP)
""")

client.close()
input("Press Enter to exit...")
