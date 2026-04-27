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

# Build everything in the final image
RUN npx medusa build

# MAP ADMIN FOLDERS
RUN mkdir -p .medusa/admin && cp -r .medusa/client/* .medusa/admin/ || true

EXPOSE 9000

# Run migrations and start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
