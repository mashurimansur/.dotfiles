#!/bin/bash

# Function to install MySQL
install_mysql() {
    echo "Installing MySQL..."
    bash database/install_mysql.sh
    echo "✅ MySQL installation complete!"
}

# Function to install PostgreSQL
install_postgresql() {
    echo "Installing PostgreSQL..."
    bash database/install_postgres.sh
    echo "✅ PostgreSQL installation complete!"
}

# Function to install MongoDB
install_mongodb() {
    echo "Installing MongoDB..."
    bash database/install_mongodb.sh
    echo "✅ MongoDB installation complete!"
}

# Function to install Redis
install_redis() {
    echo "Installing Redis..."
    bash database/install_redis.sh
    echo "✅ Redis installation complete!"
}

# Function to display menu
show_menu() {
    echo "📦 Database Installation Script"
    echo "1) Install MySQL"
    echo "2) Install PostgreSQL"
    echo "3) Install MongoDB"
    echo "4) Install Redis"
    echo "5) Install ALL databases"
    echo "6) Exit"
    echo -n "Choose an option: "
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
