# Stage 1: Build Vue app
FROM node:20-bullseye AS builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy app code
COPY . .

# Build production frontend
RUN npm run build

# Stage 2: Serve using Nginx
FROM nginx:alpine

# Copy built frontend
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose Nginx port
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
