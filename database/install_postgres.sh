#!/bin/bash

# Define PostgreSQL credentials
PG_VERSION="15"  # Change this to the required version
PG_USER="newuser"
PG_PASSWORD="newpassword"
PG_DATABASE="newdatabase"

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install PostgreSQL
echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

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
echo "✅ PostgreSQL installation complete!"
echo "🔑 User: $PG_USER | Database: $PG_DATABASE"
echo "📢 Remote access enabled (if applicable). Make sure to allow port 5432 in firewall."
