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

# Build everything (builds admin to .medusa/client/ and server to .medusa/server/)
RUN npx medusa build

# Ensure admin files are at the path the admin bundler checks
RUN cp -r .medusa/client/. .medusa/server/public/admin/ 2>/dev/null || true

EXPOSE 9000

# Run DB migrations then start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
