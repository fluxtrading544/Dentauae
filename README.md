# DentaUAE

Headless commerce project with:
- Next.js storefront in the repo root
- Medusa v2 backend in `medusa-dentalanti/`
- Docker Compose for VPS runtime

## Local development

Use [SETUP_DEV.md](SETUP_DEV.md).

Recommended entry point:

```bash
START_DEV.bat
```

That script starts the local Docker services and syncs `medusa-dentalanti/.env.development` into `medusa-dentalanti/.env` before running Medusa.

## Production runtime

Public endpoints:
- storefront: `https://dentauae.com`
- backend: `https://api.dentauae.com`
- admin: `https://api.dentauae.com/app`

Important production rule:
- `NEXT_PUBLIC_*` values are compiled into the Next.js production build.
- If `NEXT_PUBLIC_MEDUSA_BACKEND_URL` or `NEXT_PUBLIC_MEDUSA_PUBLISHABLE_KEY` changes, rebuild the frontend container.

## Admin panel

Production admin serving depends on:
- `medusa-dentalanti/medusa-config.ts`
- `medusa-dentalanti/Dockerfile`

Those files now keep the built admin bundle available under the paths Medusa resolves in production.

## Incident notes

See [PRODUCTION_FIXES_2026-04-28.md](PRODUCTION_FIXES_2026-04-28.md) for the production issues fixed on 2026-04-28.
