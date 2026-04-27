FROM node:20

WORKDIR /app

# Install build dependencies (sharp image processing, native addons)
RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# ── Build ──────────────────────────────────────────────────────────────────
# medusa build v2 produces:
#   .medusa/server/          → compiled backend Node.js server
#   .medusa/server/public/   → compiled admin UI (index.html lives here)
# Some medusa versions may also use .medusa/client/ as an intermediate step.
RUN npx medusa build

# ── Diagnostics (visible in docker build log) ──────────────────────────────
RUN echo "=== .medusa directory after build ===" \
    && find /app/.medusa -maxdepth 4 | sort 2>/dev/null || true

# ── Guarantee admin files exist at both paths the loader might check ───────
# The admin-bundler's serve() resolves: path.resolve(outDir, "index.html")
# outDir defaults to .medusa/server/public in Medusa v2.
# Cross-copy so the server can find it regardless of which path it checks.
RUN \
    HAS_SERVER_PUBLIC=0; \
    HAS_CLIENT=0; \
    [ -f /app/.medusa/server/public/admin/index.html ] && HAS_SERVER_PUBLIC=1 || true; \
    [ -f /app/.medusa/client/index.html ]        && HAS_CLIENT=1        || true; \
    \
    if [ "$HAS_SERVER_PUBLIC" = "1" ]; then \
        echo "✅ Admin at .medusa/server/public/admin/ — mirroring to public/admin/"; \
        mkdir -p /app/public/admin; \
        cp -r /app/.medusa/server/public/admin/. /app/public/admin/; \
    elif [ "$HAS_CLIENT" = "1" ]; then \
        echo "✅ Admin at .medusa/client/ — copying to public/admin/"; \
        mkdir -p /app/public/admin; \
        cp -r /app/.medusa/client/. /app/public/admin/; \
    else \
        echo "⚠️  No admin index.html found — admin UI will be unavailable"; \
        find /app -name "*.html" 2>/dev/null || true; \
    fi

EXPOSE 9000

# Run DB migrations first, then start the production Medusa server.
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
