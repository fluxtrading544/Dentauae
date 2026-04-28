# Local Development Setup

## Prerequisites
- Docker Desktop installed and running
- Node.js 20+ installed
- Git

## First-time setup

### 1. Install Node dependencies
```
cd medusa-dentalanti
npm install
cd ..
npm install
```

### 2. Start everything (one click)
Double-click **`START_DEV.bat`**

This will:
- Start Postgres (port 5432) + Redis (port 6379) in Docker
- Open a Backend terminal running `medusa develop` (hot-reload, port 9000)
- Open a Frontend terminal running `next dev` (hot-reload, port 3000)

### 3. Create your admin user (first time only)
Wait for the backend to fully start (you'll see "Server is ready"), then double-click:

**`CREATE_DEV_ADMIN.bat`**

- Email: `admin@dentauae.com`
- Password: `Admin@Local2024`

## URLs

| Service    | URL                          |
|------------|------------------------------|
| Storefront | http://localhost:3000        |
| Backend    | http://localhost:9000        |
| Admin UI   | http://localhost:9000/app    |
| Postgres   | localhost:5432               |
| Redis      | localhost:6379               |

## Stopping dev environment

Double-click **`STOP_DEV.bat`** — stops Postgres + Redis.
Close the two terminal windows for backend and frontend.

## Environment files

| File                                    | Purpose                        |
|-----------------------------------------|-------------------------------|
| `medusa-dentalanti/.env.development`    | Backend local env vars         |
| `.env.local`                            | Next.js storefront env vars    |
| `docker-compose.dev.yml`               | Postgres + Redis only          |

## Notes

- **Hot reload**: Both backend (`medusa develop`) and frontend (`next dev`) restart automatically when you save files.
- **No S3 needed locally**: Files upload to `medusa-dentalanti/uploads/images/` instead.
- **No real Stripe needed**: Placeholder keys are fine for dev — checkout UI renders but won't charge.
- **Database**: Fresh `medusa-dev` DB in Docker. Data persists in a Docker volume between restarts.

## Deploying to production after local changes

```
git add .
git commit -m "your changes"
git push origin main
```

Then run **`DEPLOY_BACKEND_FIX.bat`** to push to VPS and rebuild.
