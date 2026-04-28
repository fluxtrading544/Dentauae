FROM node:20

WORKDIR /app

RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# ── Build ──────────────────────────────────────────────────────────────────────
# medusa build v2 outputs:
#   .medusa/server/           → compiled backend (medusa-config.js, src/, etc.)
#   .medusa/server/public/    → compiled admin UI  (index.html, assets)
#   .medusa/client/           → intermediate client bundle (same content)
RUN npx medusa build

# ── Show build output (visible in docker build --progress=plain logs) ──────────
RUN echo "=== .medusa tree after build ===" \
    && find /app/.medusa -maxdepth 4 | sort 2>/dev/null || true

# ── Move admin files UP one level so index.html is at outDir root ─────────────
# medusa build puts admin UI at:  /app/.medusa/server/public/admin/
# admin.outDir in config is:      /app/.medusa/server/public
# serve() checks: path.resolve(outDir, "index.html")
#               = /app/.medusa/server/public/index.html  ← must exist here
#
# Fix: copy admin/* → public/ so index.html is directly in outDir.
# Assets end up at public/assets/ (correct — SPA references /assets/...).
RUN \
  SRC="/app/.medusa/server/public/admin" && \
  DST="/app/.medusa/server/public" && \
  if [ -f "$SRC/index.html" ]; then \
    echo "Copying $SRC → $DST ..." && \
    cp -r "$SRC/." "$DST/" && \
    echo "✅ index.html confirmed at $DST/index.html" && \
    ls -la "$DST/"; \
  else \
    echo "❌ FATAL: no index.html at $SRC" && \
    find /app/.medusa -name "*.html" 2>/dev/null | sort && \
    exit 1; \
  fi

# ── Final verification ─────────────────────────────────────────────────────────
RUN echo "=== Verifying admin file ===" \
    && ls -la /app/.medusa/server/public/ 2>/dev/null || echo "public/ not found"

EXPOSE 9000

# ── Startup: guarantee admin index.html is at outDir root before medusa start ─
# outDir = /app/.medusa/server/public
# medusa build puts admin files in /app/.medusa/server/public/admin/
# serve() checks /app/.medusa/server/public/index.html → must exist there
# This runs at container start, guaranteeing the file is always present.
CMD ["sh", "-c", "\
  echo '--- Pre-start: ensuring admin index.html is at outDir ---' && \
  SRC=/app/.medusa/server/public/admin && \
  DST=/app/.medusa/server/public && \
  if [ -f \"$DST/index.html\" ]; then \
    echo 'index.html already at outDir root'; \
  elif [ -f \"$SRC/index.html\" ]; then \
    echo 'Copying admin/* to outDir root...' && \
    cp -r \"$SRC/.\" \"$DST/\" && \
    echo 'Done.' ; \
  else \
    echo 'WARNING: no index.html found in admin build'; \
  fi && \
  npx medusa db:migrate && npx medusa start"]
