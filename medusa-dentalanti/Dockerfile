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

# ── Verify admin index.html exists at the correct location ────────────────────
# medusa build ALWAYS puts admin files in .medusa/server/public/admin/
# admin.outDir in config = "/app/.medusa/server/public/admin"
# admin-bundler serve() checks: path.resolve(outDir, "index.html")
#                              = /app/.medusa/server/public/admin/index.html
# This step fails the build early if the file is missing (no silent failures).
RUN \
  TARGET="/app/.medusa/server/public/admin/index.html" && \
  if [ -f "$TARGET" ]; then \
    echo "✅ index.html confirmed at $TARGET"; \
  else \
    echo "❌ FATAL: index.html not found at $TARGET" && \
    echo "=== Full .medusa tree ===" && \
    find /app/.medusa -name "*.html" 2>/dev/null | sort && \
    exit 1; \
  fi

# ── Final verification ─────────────────────────────────────────────────────────
RUN echo "=== Verifying admin file ===" \
    && ls -la /app/.medusa/server/public/ 2>/dev/null || echo "public/ not found"

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
