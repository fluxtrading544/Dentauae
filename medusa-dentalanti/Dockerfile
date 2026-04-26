# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# Install build dependencies for sharp and other native modules
RUN apk add --no-cache libc6-compat build-base python3

COPY package*.json ./
RUN npm install

COPY . .

# Build the Medusa application
RUN npm run build

# Stage 2: Runner
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV production

# Install runtime dependencies for sharp
RUN apk add --no-cache libvips

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/.medusa ./.medusa
COPY --from=builder /app/medusa-config.ts ./medusa-config.ts
COPY --from=builder /app/src ./src

EXPOSE 9000

# Run migrations and start the server
CMD ["npx", "medusa", "db:migrate", "&&", "npm", "run", "start"]
