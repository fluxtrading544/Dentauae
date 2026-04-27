# ── Stage 1: Builder ──────────────────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /app

# libc6-compat is needed for sharp and other native addons on Alpine
RUN apk add --no-cache libc6-compat

COPY package*.json ./
RUN npm install

COPY . .

# Build the Next.js application.
# Because next.config.ts sets output: "standalone", this creates
# .next/standalone/ — a minimal self-contained server with no node_modules copy needed.
RUN npm run build

# ── Stage 2: Runner ───────────────────────────────────────────────────────────
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# FIX: Use Next.js standalone output for dramatically smaller Docker images.
# The old Dockerfile copied the full node_modules (~500 MB) into the runner stage.
# Standalone output includes only the required modules (~50 MB typical saving).
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

EXPOSE 3000

# Standalone output uses server.js as the entrypoint (not `npm start`)
CMD ["node", "server.js"]
