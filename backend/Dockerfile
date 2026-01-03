# Use Node.js Alpine image
FROM node:18-alpine

# Install required system packages
# - curl: for health checks
# - postgresql-client: for psql (migrations)
RUN apk add --no-cache \
    curl \
    postgresql-client

# Set working directory
WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining source code
COPY . .

# Expose backend port
EXPOSE 5000

# Start the backend server
CMD ["npm", "start"]
