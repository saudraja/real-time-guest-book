#!/bin/bash

echo "Starting Real-Time Guestbook Project..."

# Step 1: Install frontend dependencies
echo "Installing Vue frontend dependencies..."
cd guestbook-frontend
npm install

# Step 2: Start the Vue dev server
echo "Starting Vue frontend..."
npm run dev &
FRONTEND_PID=$!
cd ..

# Step 3: Start Rails API and Postgres via Docker Compose
echo "Starting backend services (Rails + Postgres)..."
cd guestbook_api
docker-compose up --build

# Optional: Clean up when user stops the script
trap "kill $FRONTEND_PID" EXIT
