#!/bin/bash

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "$1"
}

# Function to check if a service is running
is_running() {
    systemctl is-active --quiet "$1"
}

# Function to install MySQL
install_mysql() {
    if is_installed "mysql-server"; then
        echo "✅ MySQL is already installed. Skipping installation."
    else
        echo "Installing MySQL..."
        bash database/install_mysql.sh
        echo "✅ MySQL installation complete!"
    fi
}

# Function to install PostgreSQL
install_postgresql() {
     if is_installed "postgresql"; then
        echo "✅ PostgreSQL is already installed. Skipping installation."
    else
        echo "Installing PostgreSQL..."
        bash database/install_postgres.sh
        echo "✅ PostgreSQL installation complete!"
    fi
}

# Function to install MongoDB
install_mongodb() {
    if is_installed "mongodb-org"; then
        echo "✅ MongoDB is already installed. Skipping installation."
    else
        echo "Installing MongoDB..."
        bash database/install_mongodb.sh
        echo "✅ MongoDB installation complete!"
    fi
}

# Function to install Redis
install_redis() {
    if is_installed "redis-server"; then
        echo "✅ Redis is already installed. Skipping installation."
    else
        echo "Installing Redis..."
        bash database/install_redis.sh
        echo "✅ Redis installation complete!"
    fi
}

# Function to display menu
show_menu() {
    echo "======================================================="
    echo "          📦 DATABASE INSTALLATION SCRIPT             "
    echo "======================================================="
    echo "  🔹 This script allows you to install databases:      "
    echo "  🔹 If a database is already installed, it will skip "
    echo "  🔹 Choose an option from the menu below:            "
    echo "-------------------------------------------------------"
    echo "  [1] 🚀 Install MySQL                                 "
    echo "  [2] 🐘 Install PostgreSQL                            "
    echo "  [3] 🍃 Install MongoDB                               "
    echo "  [4] 🔴 Install Redis                                 "
    echo "  [5] 🔄 Install ALL databases                        "
    echo "  [6] ❌ Exit                                         "
    echo "-------------------------------------------------------"
    echo -n "👉 Choose an option: "
}


# Main script execution
while true; do
    show_menu
    read -r choice
    case $choice in
        1) install_mysql ;;
        2) install_postgresql ;;
        3) install_mongodb ;;
        4) install_redis ;;
        5)
            install_mysql
            install_postgresql
            install_mongodb
            install_redis
            ;;
        6) echo "Exiting script. Bye! 👋"; exit 0 ;;
        *) echo "Invalid option. Please try again!" ;;
    esac
done
