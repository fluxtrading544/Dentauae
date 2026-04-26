#!/bin/bash

# DentaUAE "Sleep-Safe" Deployment Script
echo "🚀 Starting Deployment while you sleep..."

# 1. Pull the latest code
echo "📦 Pulling latest code..."
git pull origin main

# 2. Stop old containers
echo "🛑 Stopping old containers..."
docker-compose down

# 3. Build and start everything in the background
echo "🏗️ Building and starting... (This will keep running even if you close the terminal)"
docker-compose up -d --build

echo "✅ Deployment is running in the background!"
echo "You can go to sleep now. Check http://76.13.254.103:9000/dashboard in the morning!"
