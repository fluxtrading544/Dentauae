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

# ── Mirror admin build to every path Medusa can serve from ────────────────────
# medusa build puts admin UI at:  /app/.medusa/server/public/admin/
# Our config keeps a copy at:      /app/.medusa/server/public/index.html
# Medusa's production admin loader also resolves from:
#   rootDirectory/public/admin
# In the container, rootDirectory resolves to /app, so we also need:
#   /app/public/admin/index.html
RUN \
  SRC="/app/.medusa/server/public/admin" && \
  DST="/app/.medusa/server/public" && \
  ALT="/app/public/admin" && \
  if [ -f "$SRC/index.html" ]; then \
    echo "Copying $SRC → $DST and $ALT ..." && \
    cp -r "$SRC/." "$DST/" && \
    mkdir -p "$ALT" && \
    cp -r "$SRC/." "$ALT/" && \
    echo "✅ index.html confirmed at $DST/index.html" && \
    echo "✅ index.html confirmed at $ALT/index.html" && \
    ls -la "$DST/" && \
    ls -la "$ALT/"; \
  else \
    echo "❌ FATAL: no index.html at $SRC" && \
    find /app/.medusa -name "*.html" 2>/dev/null | sort && \
    exit 1; \
  fi

# ── Final verification ─────────────────────────────────────────────────────────
RUN echo "=== Verifying admin file ===" \
    && ls -la /app/.medusa/server/public/ 2>/dev/null || echo "public/ not found"

EXPOSE 9000

# ── Startup: guarantee both admin serve paths exist before medusa start ───────
CMD ["sh", "-c", "\
  echo '--- Pre-start: ensuring admin index.html is in every serve path ---' && \
  SRC=/app/.medusa/server/public/admin && \
  DST=/app/.medusa/server/public && \
  ALT=/app/public/admin && \
  mkdir -p \"$ALT\" && \
  if [ -f \"$SRC/index.html\" ]; then \
    if [ ! -f \"$DST/index.html\" ]; then \
      echo 'Copying admin/* to outDir root...' && \
      cp -r \"$SRC/.\" \"$DST/\" ; \
    else \
      echo 'index.html already at outDir root'; \
    fi && \
    if [ ! -f \"$ALT/index.html\" ]; then \
      echo 'Copying admin/* to loader path...' && \
      cp -r \"$SRC/.\" \"$ALT/\" ; \
    else \
      echo 'index.html already at loader path'; \
    fi && \
    ls -la \"$DST/\" && \
    ls -la \"$ALT/\"; \
  else \
    echo 'WARNING: no index.html found in admin build'; \
  fi && \
  npx medusa db:migrate && npx medusa start"]
