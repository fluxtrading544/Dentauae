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

# Build everything
RUN npx medusa build

# MAP ADMIN FOLDERS AGGRESSIVELY
RUN mkdir -p .medusa/admin && cp -r .medusa/client/* .medusa/admin/ || true
RUN mkdir -p .medusa/server/public/admin && cp -r .medusa/client/* .medusa/server/public/admin/ || true

EXPOSE 9000

# Run migrations and start the server (with a deep search for index.html)
CMD ["sh", "-c", "echo '🔍 Searching for index.html...' && find . -name index.html && npx medusa db:migrate && npx medusa start"]
