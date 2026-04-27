FROM node:20

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# Build everything (compiles admin UI + backend)
RUN npx medusa build

# Debug: show what medusa build produced
RUN echo "=== .medusa tree after build ===" && find /app/.medusa -maxdepth 4 | sort || true

# Ensure admin index.html is accessible at every path the bundler might check:
# 1) .medusa/server/public/ (Medusa v2 standard output)
# 2) .medusa/client/ (alternative outDir some versions use)
# 3) .medusa/server/public/app/ (path variant)
RUN set -e; \
    if [ -d /app/.medusa/server/public ] && [ -f /app/.medusa/server/public/index.html ]; then \
        echo "Admin already at .medusa/server/public/"; \
        mkdir -p /app/.medusa/client; \
        cp -r /app/.medusa/server/public/. /app/.medusa/client/ 2>/dev/null || true; \
    elif [ -d /app/.medusa/client ] && [ -f /app/.medusa/client/index.html ]; then \
        echo "Admin at .medusa/client/, copying to .medusa/server/public/"; \
        mkdir -p /app/.medusa/server/public; \
        cp -r /app/.medusa/client/. /app/.medusa/server/public/ 2>/dev/null || true; \
    else \
        echo "WARNING: No admin index.html found after medusa build!"; \
        find /app/.medusa -name "index.html" 2>/dev/null || true; \
    fi

EXPOSE 9000

# Run DB migrations then start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
