# DentaUAE VPS Deployment Strategy (Enterprise Standard)

To deploy your premium dental platform, we will use the **GitHub + Docker** workflow. This is the safest and most efficient method.

## 🏁 The Workflow Summary
1.  **Local:** Commit and push your code to **GitHub**.
2.  **VPS:** Pull the latest code from **GitHub**.
3.  **VPS:** Run `docker-compose up` to build and start everything.

---

## 🛠️ Phase 1: Local Preparation (GitHub)

### 1. Push your latest changes
Run these commands on your local computer:
```bash
git add .
git commit -m "feat: connected cloudflare R2 and enabled auto-webp optimization"
git push origin main
```

---

## 🚀 Phase 2: VPS Setup

### 1. Initial Clone
Log into your VPS and run:
```bash
git clone https://github.com/fluxtrading544/Dentauae.git
cd Dentauae
```

### 2. Configure Environment Variables
**CRITICAL:** Never push `.env` to GitHub. You must create it manually on the VPS.
```bash
# In the root folder of Dentauae on your VPS
cp .env.example .env
nano .env  # Update with your Cloudflare, Stripe, and Database credentials
```

---

## 📦 Phase 3: Launching with Docker

Run this command to build and start your entire stack (Postgres + Redis + Backend + Storefront):
```bash
docker-compose up -d --build
```

---

## 💾 Phase 4: Database Migration (Local to VPS)

Since you want to keep your existing products and clinical data:

1.  **On your Local Machine (Windows):**
    ```powershell
    pg_dump -U postgres medusa-medusa-dentalanti > dental_backup.sql
    ```
2.  **Upload to VPS:** Use SCP or FileZilla to move `dental_backup.sql` to your VPS.
3.  **On your VPS:**
    ```bash
    # Import the data into the Docker container
    cat dental_backup.sql | docker exec -i <postgres_container_name> psql -U postgres -d medusa-dentalanti
    ```

---

## ✨ Features included in this Deployment:
*   **Auto-WebP Engine:** Automatically optimizes every dental product image you upload.
*   **Cloudflare R2 Integration:** Global delivery for clinical photography.
*   **Persistent Storage:** Your database data is saved in a Docker Volume, so it won't be lost if you restart the VPS.
*   **SSL Ready:** All you need is a simple Nginx reverse proxy (I can help you with this once you are online).

---

## 🔄 How to update the site in the future?
Whenever we make a change, the update process is just 2 commands on your VPS:
1. `git pull origin main`
2. `docker-compose up -d --build`
