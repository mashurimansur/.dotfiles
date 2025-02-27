#!/bin/bash

# Detect OS
OS="$(uname -s)"

basic_install() {
    bash scripts/installer.sh
}

install_databases() {
    bash database/installer.sh
}

install_apps() {
    bash applications/installer.sh "$OS"
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
    echo -e "          ${YELLOW}📦 SYSTEM INSTALLATION MENU${RESET}"
    echo -e "${BLUE}=======================================================${RESET}"
    echo -e "  ${GREEN}🔹 Select an option to install different components:${RESET}"
    echo -e "  ${GREEN}🔹 Each option installs a specific type of software.${RESET}"
    echo -e "  ${GREEN}🔹 Follow the prompts to complete installation.${RESET}"
    echo -e "${BLUE}-------------------------------------------------------${RESET}"
    echo -e "  [${CYAN}1${RESET}] 🚀 ${YELLOW}Basic Install${RESET} - Installs essential system utilities"
    echo -e "  [${CYAN}2${RESET}] 🐘 ${MAGENTA}Install Database${RESET} - Installs MySQL, PostgreSQL, and MongoDB"
    echo -e "  [${CYAN}3${RESET}] 🍃 ${GREEN}Install Apps${RESET} - Installs commonly used applications"
    echo -e "  [${CYAN}0${RESET}] ❌ ${WHITE}Exit${RESET} - Exit the script"
    echo -e "${BLUE}-------------------------------------------------------${RESET}"
    echo -ne "👉 ${YELLOW}Choose an option:${RESET} "
}


# Main script execution
while true; do
    show_menu
    read -r choice
    case $choice in
        1) basic_install ;;
        2) install_databases ;;
        3) install_apps ;;
        0) echo "Exit. Bye! 👋"; exit 0 ;;
        *) echo "Invalid option. Please try again!" ;;
    esac
done