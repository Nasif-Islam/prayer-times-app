
# Stage 1: Build the React App
FROM node:20-alpine AS build

# Set working directory
WORKDIR /app

# Install dependencies first for better caching
COPY frontend/package*.json ./
RUN npm ci --omit=dev || npm install

# Copy source and build
COPY frontend/ .
RUN npm run build

# Stage 2: Serve with lightweight Nginx web server
FROM nginx:alpine

# Copy production build from previous stage to Nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose Nginx's default HTTP port
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
