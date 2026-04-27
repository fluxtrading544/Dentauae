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

# ── Guarantee admin index.html at /app/.medusa/server/public/ ─────────────────
# WHY: medusa-config.ts sets admin.outDir = path.join(__dirname, "public").
#      __dirname in the compiled medusa-config.js = /app/.medusa/server/
#      so outDir = /app/.medusa/server/public/
#
# medusa build already writes index.html to .medusa/server/public/, but if it
# only wrote to .medusa/client/ we need to copy it across.
RUN \
  if [ -f /app/.medusa/server/public/index.html ]; then \
    echo "✅ index.html confirmed at .medusa/server/public/"; \
  elif [ -f /app/.medusa/client/index.html ]; then \
    echo "⚠️  index.html only in .medusa/client/ — copying to .medusa/server/public/"; \
    mkdir -p /app/.medusa/server/public; \
    cp -r /app/.medusa/client/. /app/.medusa/server/public/; \
    echo "✅ Copied"; \
  else \
    echo "❌ No admin index.html found anywhere — admin UI will not work"; \
    find /app/.medusa -name "*.html" 2>/dev/null || true; \
  fi

# ── Final verification ─────────────────────────────────────────────────────────
RUN echo "=== Verifying admin file ===" \
    && ls -la /app/.medusa/server/public/ 2>/dev/null || echo "public/ not found"

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
