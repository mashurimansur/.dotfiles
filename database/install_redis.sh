#!/bin/bash

# Define Redis version (optional, for custom builds)
REDIS_PORT="6379"

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Redis
echo "Installing Redis..."
sudo apt install -y redis-server

# Start and enable Redis service
echo "Starting Redis service..."
sudo systemctl start redis
sudo systemctl enable redis

# Configure Redis to allow remote connections (optional)
echo "Configuring Redis for remote access..."
sudo sed -i "s/^bind 127.0.0.1 -::1/bind 0.0.0.0/" /etc/redis/redis.conf
sudo sed -i "s/^# requirepass foobared/requirepass your_redis_password/" /etc/redis/redis.conf

# Restart Redis to apply changes
echo "Restarting Redis service..."
sudo systemctl restart redis

# Print completion message
echo "✅ Redis installation complete!"
echo "📢 Remote access enabled on port $REDIS_PORT. Ensure firewall rules allow external connections."
echo "🔑 Redis password set (change in /etc/redis/redis.conf)"
echo "👍 After set redis password restart redis before use (sudo systemctl enable redis)"
