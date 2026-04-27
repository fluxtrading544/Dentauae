# Medusa v2 & Next.js VPS Deployment: Troubleshooting Guide

This guide documents the specific challenges faced when moving the DentaUAE Medusa v2 project from a local Windows environment to a Linux Hostinger VPS using Docker. Keep this as a reference for your future headless e-commerce deployments.

---

## 1. Admin Dashboard "index.html Not Found" Error
**The Problem:** 
After deploying the backend, navigating to the Admin URL resulted in a blank page or an `index.html not found` error.
**The Cause:**
Medusa v2 compiles its Admin Dashboard into a hidden folder structure (`.medusa/server/public/admin`). In our `docker-compose.yml`, we had a `volumes` mapping that was overwriting the container's freshly built files with the empty folders from the host machine.
**The Solution:**
1. Removed the `volumes: - ./medusa-dentalanti:/app` mapping for the backend in `docker-compose.yml`. The container must rely on its own internal built files.
2. Updated the `Dockerfile` to automatically locate the built admin files and explicitly copy them to `/app/public/admin/` so the Medusa server can serve them correctly.

---

## 2. PostgreSQL Backup Failure (`pg_dump`)
**The Problem:** 
When trying to export the local database using the connection string, it threw an `Invalid argument` error regarding the socket.
**The Cause:**
Your database password contained special characters (`@@`). In a database URL (`postgresql://user:password@host/db`), the `@` symbol is reserved to separate the password from the host. The extra `@` symbols confused the system.
**The Solution:**
URL-encoded the password. We replaced `@@` with `%40%40` in the connection string.
*Example: `postgresql://SharyarAhmed:Sohail%40%405442626@localhost...`*

---

## 3. Cloudflare Blocking the Admin Dashboard
**The Problem:** 
The Admin Dashboard was accessible via the raw IP address (`http://76.13.254.103:9000/app`), but navigating to `http://api.dentauae.com:9000/app` timed out.
**The Cause:**
Cloudflare's "Orange Cloud" (Proxied mode) provides DDOS protection but strictly blocks non-standard ports like `9000`. It only allows standard website traffic (Ports 80 and 443).
**The Solution:**
In the Cloudflare DNS dashboard, we edited the `api` A-Record and turned off the Proxy status (changing it to a "Grey Cloud" / DNS Only). This allowed direct traffic to hit port 9000 on the VPS.

---

## 4. Admin API "ERR_CONNECTION_TIMED_OUT" & CORS
**The Problem:** 
The Admin Dashboard loaded visually, but trying to log in resulted in timeouts in the browser console (`/admin/feature-flags`).
**The Cause:**
1. **Wrong API URL:** The Admin UI was pre-compiled to send API requests to `https://api.dentauae.com` (Port 443). Because we bypassed Cloudflare, port 443 wasn't answering.
2. **CORS Block:** The backend's security rules (`ADMIN_CORS`) didn't know about the `api.dentauae.com:9000` domain, so it would have rejected the requests anyway.
**The Solution:**
1. Updated `medusa-config.ts` to explicitly set `backendUrl: "http://api.dentauae.com:9000"`.
2. Appended `http://api.dentauae.com:9000` to the `ADMIN_CORS` variable in `docker-compose.yml`.

---

## 5. Storefront Products Not Showing (Empty Grid)
**The Problem:** 
The database had 11 products successfully imported, but the Next.js frontend was completely empty.
**The Cause:**
Medusa v2 has strict Headless security. The frontend cannot query products unless it provides a valid **Publishable API Key**. Because `.env` files are not tracked in GitHub, the VPS frontend was missing the specific API key that was linked to the imported database.
**The Solution:**
Opened the `.env` file on the VPS and manually pasted the exact `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY` from the local Windows environment. After rebuilding the frontend (`docker-compose up -d --build frontend`), the products appeared.

---

## 6. Docker-Compose Python Crash (`KeyError: ContainerConfig`)
**The Problem:** 
When trying to start the frontend, the terminal threw a massive Python traceback ending in `KeyError: 'ContainerConfig'`.
**The Cause:**
This is a known bug in older versions of the `docker-compose` tool (v1.29.2). It crashes when trying to intelligently "Recreate" a container that was built using modern Docker features (BuildKit).
**The Solution:**
Bypassed the buggy "Recreate" step by forcing Docker to delete the container entirely before starting it:
```bash
docker-compose rm -f frontend
docker-compose up -d frontend
```

---

### 💡 Golden Rules for Future Medusa Deployments:
1. **Never use local volumes in production** (`docker-compose.yml`). Let the Docker container build and serve its own internal files.
2. **Always sync your API Keys.** If you migrate a database, your Publishable Keys must migrate to the frontend's `.env` file too.
3. **Beware of Cloudflare Proxy.** If you are using custom ports like `9000` without a reverse proxy (like Nginx), you must set the DNS record to "DNS Only" (Grey Cloud).
4. **CORS is King.** Every time you introduce a new domain or port, it MUST be added to `STORE_CORS` or `ADMIN_CORS`.
