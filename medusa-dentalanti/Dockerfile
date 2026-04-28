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
# medusa-config.ts now uses hardcoded outDir = "/app/.medusa/server/public"
# so medusa build writes the admin UI there directly.
# BUT: if build put it elsewhere (e.g. /app/public or .medusa/client),
# this step finds it and copies it to the required location.
RUN \
  TARGET="/app/.medusa/server/public" && \
  if [ -f "$TARGET/index.html" ]; then \
    echo "✅ index.html confirmed at $TARGET/"; \
  else \
    echo "⚠️  index.html not at $TARGET — searching all locations..." && \
    SRC_DIR="" && \
    for CANDIDATE in \
      /app/.medusa/client \
      /app/public \
      /app/.medusa/server/public/admin \
      /app/.medusa/client/admin; \
    do \
      if [ -f "$CANDIDATE/index.html" ]; then \
        SRC_DIR="$CANDIDATE"; \
        break; \
      fi; \
    done && \
    if [ -n "$SRC_DIR" ]; then \
      echo "Found at $SRC_DIR — copying to $TARGET" && \
      mkdir -p "$TARGET" && \
      cp -r "$SRC_DIR/." "$TARGET/" && \
      echo "✅ Copied successfully"; \
    else \
      echo "No candidate dirs found — deep searching..." && \
      FOUND=$(find /app -name "index.html" 2>/dev/null | grep -v node_modules | head -1) && \
      if [ -n "$FOUND" ]; then \
        FOUND_DIR=$(dirname "$FOUND") && \
        echo "Deep found at $FOUND_DIR — copying to $TARGET" && \
        mkdir -p "$TARGET" && \
        cp -r "$FOUND_DIR/." "$TARGET/" && \
        echo "✅ Copied (deep search)"; \
      else \
        echo "❌ FATAL: No admin index.html found ANYWHERE after build" && \
        find /app/.medusa -maxdepth 5 | sort 2>/dev/null || true && \
        exit 1; \
      fi; \
    fi; \
  fi

# ── Final verification ─────────────────────────────────────────────────────────
RUN echo "=== Verifying admin file ===" \
    && ls -la /app/.medusa/server/public/ 2>/dev/null || echo "public/ not found"

EXPOSE 9000

CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
