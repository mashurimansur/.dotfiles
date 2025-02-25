#!/bin/bash

# Define MongoDB credentials
MONGO_USER="newuser"
MONGO_PASSWORD="newpassword"
MONGO_DATABASE="newdatabase"
MONGO_PORT="27017"
MONGO_VERSION="8.0"  # Change this to the required version

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install required packages
echo "Installing dependencies..."
sudo apt-get install -y gnupg curl

# Import MongoDB GPG Key
echo "Adding MongoDB GPG key..."
curl -fsSL https://pgp.mongodb.com/server-${MONGO_VERSION}.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg

# Add MongoDB repository
echo "Adding MongoDB repository..."
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/${MONGO_VERSION} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list

# Update package list and install MongoDB
echo "Installing MongoDB..."
sudo apt-get update -y
sudo apt-get install -y mongodb-org

# Ensure MongoDB directories exist
echo "Ensuring necessary directories exist..."
sudo mkdir -p /var/lib/mongodb
sudo mkdir -p /var/log/mongodb
sudo chown -R mongodb:mongodb /var/lib/mongodb
sudo chown -R mongodb:mongodb /var/log/mongodb

# Start and enable MongoDB service
echo "Starting MongoDB service..."
sudo systemctl start mongod
sudo systemctl enable mongod

# Wait for MongoDB to start
echo "Waiting for MongoDB to initialize..."
sleep 10

# Check MongoDB service status
if ! sudo systemctl is-active --quiet mongod; then
    echo "❌ MongoDB failed to start! Checking logs..."
    sudo journalctl -xeu mongod | tail -n 20
    exit 1
fi

# Create MongoDB user and database
echo "Creating MongoDB user and database..."
mongosh --quiet --eval "
  use $MONGO_DATABASE;
  db.createUser({
    user: '$MONGO_USER',
    pwd: '$MONGO_PASSWORD',
    roles: [{ role: 'readWrite', db: '$MONGO_DATABASE' }]
  });
"

echo "✅ MongoDB installation and user setup complete!"
