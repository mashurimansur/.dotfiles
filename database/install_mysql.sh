#!/bin/bash

# Prompt user for MySQL credentials with defaults
read -p "Enter MySQL root password [default: root]: " MYSQL_ROOT_PASSWORD
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-root}

read -p "Enter new MySQL username [default: newuser]: " MYSQL_USER
MYSQL_USER=${MYSQL_USER:-newuser}

read -p "Enter password for new MySQL user [default: newpassword]: " MYSQL_PASSWORD
MYSQL_PASSWORD=${MYSQL_PASSWORD:-newpassword}

read -p "Enter database name to create [default: newdatabase]: " MYSQL_DATABASE
MYSQL_DATABASE=${MYSQL_DATABASE:-newdatabase}

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install MySQL Server
echo "Installing MySQL Server..."
sudo apt install -y mysql-server

# Start and enable MySQL service
echo "Starting MySQL service..."
sudo systemctl start mysql
sudo systemctl enable mysql

# Secure MySQL installation (non-interactive)
echo "Configuring MySQL security settings..."
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "DROP DATABASE IF EXISTS test;"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Create a new MySQL user and database
echo "Creating MySQL user and database..."
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE $MYSQL_DATABASE;"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
sudo mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Enable remote access (optional)
echo "Configuring MySQL for remote access..."
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL to apply changes
echo "Restarting MySQL service..."
sudo systemctl restart mysql

# Print completion message
echo "✅ MySQL installation complete!"
echo "🔑 Root Password: $MYSQL_ROOT_PASSWORD"
echo "🔑 User: $MYSQL_USER | Database: $MYSQL_DATABASE"
echo "📢 Remote access enabled. Ensure firewall rules allow external connections."
