# Stage 1: Build
FROM node:20-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY package*.json ./
RUN npm install

COPY . .

# Explicitly build server and admin
RUN npx medusa build

# MOVE ADMIN FILES TO CORRECT LOCATION
# Medusa v2 expects admin at .medusa/admin, but build puts it in server/public/admin
RUN mkdir -p .medusa/admin && cp -r .medusa/server/public/admin/* .medusa/admin/

# Stage 2: Runner
FROM node:20-slim AS runner

WORKDIR /app

ENV NODE_ENV production

# Install runtime dependencies for sharp
RUN apt-get update && apt-get install -y \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
# Copy everything from builder
COPY --from=builder /app ./

EXPOSE 9000

# Run migrations and start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
