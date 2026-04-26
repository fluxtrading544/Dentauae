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
