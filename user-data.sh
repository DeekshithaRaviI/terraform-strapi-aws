#!/bin/bash
set -euxo pipefail

# ----------------------------------------
# Log everything
# ----------------------------------------
exec > >(tee /var/log/user-data.log) 2>&1

echo "=== Starting Strapi Installation ==="
date

# ----------------------------------------
# Update system
# ----------------------------------------
echo "Updating system packages..."
dnf update -y

# ----------------------------------------
# Install Docker
# ----------------------------------------
echo "Installing Docker..."
dnf install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# ----------------------------------------
# Install Docker Compose v2
# ----------------------------------------
echo "Installing Docker Compose..."
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL "https://github.com/docker/compose/releases/download/v2.25.0/docker-compose-linux-x86_64" \
  -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Verify installations
docker --version
docker compose version

# ----------------------------------------
# Prepare Strapi directory
# ----------------------------------------
echo "Creating Strapi app directory..."
mkdir -p /home/ec2-user/strapi-app
chown -R ec2-user:ec2-user /home/ec2-user/strapi-app
cd /home/ec2-user/strapi-app

# ----------------------------------------
# Create docker-compose.yml
# ----------------------------------------
echo "Creating docker-compose.yml..."
cat > docker-compose.yml <<EOF
version: "3.8"

services:
  strapi:
    image: deekshithalive/strapi-app:latest
    container_name: strapi
    restart: unless-stopped
    environment:
      DATABASE_CLIENT: sqlite
      DATABASE_FILENAME: .tmp/data.db
      APP_KEYS: "${strapi_app_keys}"
      API_TOKEN_SALT: "${strapi_api_token_salt}"
      ADMIN_JWT_SECRET: "${strapi_admin_jwt_secret}"
      TRANSFER_TOKEN_SALT: "${strapi_transfer_token_salt}"
      JWT_SECRET: "${strapi_jwt_secret}"
      NODE_ENV: "${environment}"
      HOST: 0.0.0.0
      PORT: 1337
    ports:
      - "1337:1337"
    volumes:
      - ./app:/srv/app
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:1337 || exit 1"]
      interval: 30s
      timeout: 10s
      retries: 5
      start_period: 60s
EOF

# Fix permissions
chown -R ec2-user:ec2-user /home/ec2-user/strapi-app

# ----------------------------------------
# Start Strapi container
# ----------------------------------------
echo "Starting Strapi container..."
sudo -u ec2-user docker compose up -d

# ----------------------------------------
# Verification
# ----------------------------------------
echo "Waiting for Strapi to initialize..."
sleep 20

echo "Docker containers:"
docker ps -a

echo "Strapi logs:"
docker logs strapi || true

echo "=== Strapi deployment completed successfully ==="
date
