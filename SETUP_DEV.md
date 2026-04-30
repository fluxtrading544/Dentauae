# Local Development Setup

## Prerequisites

- Docker Desktop installed and running
- Node.js 20+ installed
- Git

## First-time setup

### 1. Install Node dependencies

```bash
cd medusa-dentalanti
npm install
cd ..
npm install
```

### 2. Start everything

Run:

```bash
START_DEV.bat
```

This script:
- starts Postgres and Redis from `docker-compose.dev.yml`
- copies `medusa-dentalanti/.env.development` to `medusa-dentalanti/.env`
- starts `medusa develop` on port `9000`
- starts `next dev` on port `3000`

That env sync is required because the installed Medusa CLI loads `medusa-dentalanti/.env`. It does not automatically use `.env.development`.

### 3. Create a local admin if needed

After the backend is ready, run:

```bash
CREATE_DEV_ADMIN.bat
```

Local admin credentials created by that script:
- email: `admin-local@dentauae.com`
- password: `Admin@Local2026!`

## URLs

| Service | URL |
|---|---|
| Storefront | `http://localhost:3000` |
| Backend | `http://localhost:9000` |
| Admin UI | `http://localhost:9000/app` |
| Postgres | `localhost:5432` |
| Redis | `localhost:6379` |

## Environment files

| File | Purpose |
|---|---|
| `medusa-dentalanti/.env.development` | backend dev source of truth |
| `medusa-dentalanti/.env` | runtime env actually loaded by Medusa CLI |
| `.env.local` | Next.js storefront env |
| `docker-compose.dev.yml` | local Postgres and Redis only |

## Notes

- Local Medusa development should use the Docker `medusa-dev` database.
- Local image uploads can use file-local storage.
- Placeholder Stripe keys are acceptable for development.
- In production, `NEXT_PUBLIC_*` values are build-time values. If the backend URL or publishable key changes on the VPS, rebuild the frontend container.
