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

# THE FIX: Medusa v2 builds to .medusa/client, but the loader looks for .medusa/admin
RUN mkdir -p .medusa/admin && cp -r .medusa/client/* .medusa/admin/
# Also ensure the server/public/admin is covered just in case
RUN mkdir -p .medusa/server/public/admin && cp -r .medusa/client/* .medusa/server/public/admin/ || true

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
COPY --from=builder /app ./

EXPOSE 9000

# Run migrations and start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
