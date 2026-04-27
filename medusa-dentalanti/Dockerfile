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

EXPOSE 9000

# Run DB migrations then start the server
CMD ["sh", "-c", "npx medusa db:migrate && npx medusa start"]
