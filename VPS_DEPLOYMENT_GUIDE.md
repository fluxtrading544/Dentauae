# VPS Deployment Guide

This is the current deployment runbook for `dentauae.com` and `api.dentauae.com`.

## Stack

- Next.js storefront
- Medusa v2 backend
- Postgres and Redis in Docker

## Live URLs

- storefront: `https://dentauae.com`
- backend: `https://api.dentauae.com`
- admin: `https://api.dentauae.com/app`
- health: `https://api.dentauae.com/health`

## Required env alignment

The live VPS `.env` must keep these values aligned:

```env
MEDUSA_BACKEND_URL=https://api.dentauae.com
NEXT_PUBLIC_MEDUSA_BACKEND_URL=https://api.dentauae.com
MEDUSA_ADMIN_ON_SERVER=true
ADMIN_OUT_DIR=/app/.medusa/server/public
NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY=<must match api_key.token in Postgres>
```

If the database changes, re-check the publishable key in Postgres:

```sql
SELECT token
FROM api_key
WHERE type = 'publishable'
ORDER BY created_at DESC
LIMIT 1;
```

If that key changes, rebuild the frontend container.

## Admin panel behavior

The Medusa admin bundle is built under:

```text
.medusa/server/public/admin
```

Production admin serving is kept working by:
- enabling admin serving in `medusa-config.ts`
- copying the built admin bundle into runtime paths in `medusa-dentalanti/Dockerfile`

If `/app` breaks, inspect those two files first.

## Catalog recovery workflow

If products or images disappear:

1. Check backend health.
2. Query `product` and `image` counts in Postgres.
3. If counts are empty but health is `200`, treat it as a data/volume problem, not a connection problem.
4. Restore from a known-good SQL dump.
5. Re-check the publishable key.
6. Rebuild the frontend if the key changed.

## Post-deploy verification

After each production rebuild, verify:

1. `https://api.dentauae.com/health` returns `200`
2. `https://api.dentauae.com/app` returns `200`
3. admin auth works through `/auth/user/emailpass`
4. `/admin/products` returns products with a valid admin token
5. store API returns products with the current publishable key
6. `https://dentauae.com/shop` renders catalog data
