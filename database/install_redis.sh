#!/bin/bash

# Define Redis version (optional, for custom builds)
REDIS_PORT="6379"

# Prompt user for Redis password
read -sp "Enter Redis password (leave empty to skip setting password): " REDIS_PASSWORD
echo ""  # New line after input

# Function to set Redis password
set_redis_password() {
    local conf_file="/etc/redis/redis.conf"

    if [[ -z "$REDIS_PASSWORD" ]]; then
        echo "⚠️ No password entered. Skipping Redis password configuration."
        return
    fi

    echo "🔐 Setting Redis password..."
    
    # Ensure the requirepass directive is set
    sudo sed -i "s/^# requirepass .*/requirepass $REDIS_PASSWORD/" "$conf_file"
    sudo sed -i "s/^requirepass .*/requirepass $REDIS_PASSWORD/" "$conf_file"
    
    echo "✅ Redis password has been set successfully!"
}

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

# Set Redis password (if provided)
set_redis_password

# Restart Redis to apply changes
echo "Restarting Redis service..."
sudo systemctl restart redis

# Print completion message
echo "✅ Redis installation complete!"
echo "📢 Remote access enabled on port $REDIS_PORT. Ensure firewall rules allow external connections."

if [[ -n "$REDIS_PASSWORD" ]]; then
    echo "🔑 Redis password set (change in /etc/redis/redis.conf if needed)."
else
    echo "⚠️ No password set for Redis. Consider setting one for security."
fi