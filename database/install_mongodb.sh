#!/bin/bash

# Define MongoDB credentials
MONGO_USER="newuser"
MONGO_PASSWORD="newpassword"
MONGO_DATABASE="newdatabase"
MONGO_PORT="27017"
MONGO_VERSION="7.0"  # Change this to the required version

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install required packages
echo "Installing dependencies..."
sudo apt install -y wget gnupg

# Import MongoDB GPG Key
echo "Adding MongoDB GPG key..."
wget -qO - https://pgp.mongodb.com/server-${MONGO_VERSION}.asc | sudo tee /usr/share/keyrings/mongodb-server-key.gpg > /dev/null

# Add MongoDB repository
echo "Adding MongoDB repository..."
echo "deb [signed-by=/usr/share/keyrings/mongodb-server-key.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/${MONGO_VERSION} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list

# Update package list and install MongoDB
echo "Installing MongoDB..."
sudo apt update -y
sudo apt install -y mongodb-org

# Start and enable MongoDB service
echo "Starting MongoDB service..."
sudo systemctl start mongod
sudo systemctl enable mongod

# Wait for MongoDB to start
sleep 5

# Create MongoDB user and database
echo "Creating MongoDB user and database..."
mongosh --eval "
use $MONG
