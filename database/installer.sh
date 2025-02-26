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
    # Define colors
    BLUE="\e[1;34m"
    GREEN="\e[1;32m"
    YELLOW="\e[1;33m"
    MAGENTA="\e[1;35m"
    CYAN="\e[1;36m"
    RED="\e[1;31m"
    WHITE="\e[1;37m"
    RESET="\e[0m"  # Reset color

    echo -e "${BLUE}=======================================================${RESET}"
    echo -e "          ${YELLOW}📦 DATABASE INSTALLATION SCRIPT${RESET}"
    echo -e "${BLUE}=======================================================${RESET}"
    echo -e "  ${GREEN}🔹 This script allows you to install databases:${RESET}"
    echo -e "  ${GREEN}🔹 If a database is already installed, it will be skipped.${RESET}"
    echo -e "  ${GREEN}🔹 Choose an option from the menu below:${RESET}"
    echo -e "${BLUE}-------------------------------------------------------${RESET}"
    echo -e "  [${CYAN}1${RESET}] 🚀 ${YELLOW}Install MySQL${RESET}"
    echo -e "  [${CYAN}2${RESET}] 🐘 ${MAGENTA}Install PostgreSQL${RESET}"
    echo -e "  [${CYAN}3${RESET}] 🍃 ${GREEN}Install MongoDB${RESET}"
    echo -e "  [${CYAN}4${RESET}] 🔴 ${RED}Install Redis${RESET}"
    echo -e "  [${CYAN}5${RESET}] 🔄 ${CYAN}Install ALL databases${RESET}"
    echo -e "  [${CYAN}6${RESET}] ❌ ${WHITE}Back To Main Menu${RESET}"
    echo -e "${BLUE}-------------------------------------------------------${RESET}"
    echo -ne "👉 ${YELLOW}Choose an option:${RESET} "
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
        6) echo "Back to Main Menu. Bye! 👋"; exit 0 ;;
        *) echo "Invalid option. Please try again!" ;;
    esac
done
