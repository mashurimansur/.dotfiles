#!/bin/bash

# Define MongoDB credentials
MONGO_USER="newuser"
MONGO_PASSWORD="newpassword"
MONGO_DATABASE="newdatabase"
MONGO_PORT="27017"
MONGO_VERSION="8.0"  # Set to the required version

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install required packagesssss
echo "Installing dependencies..."
sudo apt-get install -y gnupg curl

# Import MongoDB GPG Key
echo "Adding MongoDB GPG key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-${MONGO_VERSION}.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg \
  --dearmor

# Add MongoDB repository
echo "Adding MongoDB repository..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/${MONGO_VERSION} multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list

# Update package list and install MongoDB
echo "Installing MongoDB..."
sudo apt-get update -y
sudo apt-get install -y mongodb-org

# Start and enable MongoDB service
echo "Starting MongoDB service..."
sudo systemctl start mongod
sudo systemctl enable mongod

# Wait for MongoDB to start
sleep 5

# Create MongoDB user and database
echo "Creating MongoDB user and database..."
mongosh --eval "
  use $MONGO_DATABASE;
  db.createUser({
    user: '$MONGO_USER',
    pwd: '$MONGO_PASSWORD',
    roles: [{ role: 'readWrite', db: '$MONGO_DATABASE' }]
  });
"

echo "MongoDB installation and user setup complete!"