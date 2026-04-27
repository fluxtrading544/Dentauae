# Stage 1: Build
FROM node:20 AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# Build everything
RUN npx medusa build

# MAP ALL POSSIBLE ADMIN FOLDERS
# Medusa v2 is inconsistent with folder names (client vs admin)
RUN mkdir -p .medusa/admin && cp -r .medusa/client/* .medusa/admin/ || true
RUN mkdir -p .medusa/server/public/admin && cp -r .medusa/client/* .medusa/server/public/admin/ || true
RUN mkdir -p .medusa/server/public/dashboard && cp -r .medusa/client/* .medusa/server/public/dashboard/ || true

# Stage 2: Runner
FROM node:20 AS runner

WORKDIR /app

ENV NODE_ENV production

# Install runtime dependencies for sharp
RUN apt-get update && apt-get install -y \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
# Copy the entire build output explicitly
COPY --from=builder /app/.medusa ./.medusa
COPY --from=builder /app/medusa-config.ts ./medusa-config.ts
COPY --from=builder /app/tsconfig.json ./tsconfig.json
COPY --from=builder /app/src ./src

EXPOSE 9000

# Run migrations and start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
