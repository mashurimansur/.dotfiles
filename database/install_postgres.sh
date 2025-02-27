#!/bin/bash

# Prompt user for PostgreSQL credentials with defaults
read -p "Enter PostgreSQL username [default: newuser]: " PG_USER
PG_USER=${PG_USER:-newuser}

read -p "Enter password for PostgreSQL user [default: newpassword]: " PG_PASSWORD
PG_PASSWORD=${PG_PASSWORD:-newpassword}

read -p "Enter database name to create [default: newdatabase]: " PG_DATABASE
PG_DATABASE=${PG_DATABASE:-newdatabase}

# PostgreSQL 17: Released on September 26, 2024.
# PostgreSQL 16: Released on September 14, 2023.
# PostgreSQL 15: Released on October 13, 2022.
# PostgreSQL 14: Released on September 30, 2021.
# PostgreSQL 13: Released on September 24, 2020.
# PostgreSQL 12: Released on October 3, 2019.
read -p "Enter PostgreSQL version to install [default: 16]: " PG_VERSION
PG_VERSION=${PG_VERSION:-16}

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install required packages
echo "Installing dependencies..."
sudo apt install -y wget gnupg2 software-properties-common

# Add PostgreSQL APT repository
echo "Adding PostgreSQL APT repository..."
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list

# Import PostgreSQL GPG key
echo "Importing PostgreSQL GPG key..."
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update package list again
echo "Updating package list..."
sudo apt update -y

# Install the selected PostgreSQL version
echo "Installing PostgreSQL $PG_VERSION..."
sudo apt install -y "postgresql-$PG_VERSION" "postgresql-client-$PG_VERSION" postgresql-contrib

# Start and enable PostgreSQL service
echo "Starting PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Create a new PostgreSQL user and database
echo "Creating PostgreSQL user and database..."
sudo -u postgres psql -c "CREATE USER $PG_USER WITH PASSWORD '$PG_PASSWORD';"
sudo -u postgres psql -c "CREATE DATABASE $PG_DATABASE OWNER $PG_USER;"
sudo -u postgres psql -c "ALTER ROLE $PG_USER SET client_encoding TO 'utf8';"
sudo -u postgres psql -c "ALTER ROLE $PG_USER SET default_transaction_isolation TO 'read committed';"
sudo -u postgres psql -c "ALTER ROLE $PG_USER SET timezone TO 'UTC';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $PG_DATABASE TO $PG_USER;"

# Enable remote access (optional)
echo "Configuring PostgreSQL for remote access..."
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$PG_VERSION/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /etc/postgresql/$PG_VERSION/main/pg_hba.conf

# Restart PostgreSQL to apply changes
echo "Restarting PostgreSQL service..."
sudo systemctl restart postgresql

# Print completion message
echo "✅ PostgreSQL $PG_VERSION installation complete!"
echo "🔑 User: $PG_USER | Database: $PG_DATABASE"
echo "📢 Remote access enabled. Ensure port 5432 is allowed in your firewall settings."
