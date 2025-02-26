#!/bin/bash

install_neovim() {
    bash applications/install_nvim.sh "Linux"
}

install_vscode() {
    echo "Installing VS Code"
}

install_all_apps() {
    install_neovim
    install_vscode
}

# Function to display menu
show_menu() {
    RED='\033[1;31m'     # Bold Red
    BLUE='\033[1;34m'    # Bold Blue
    GREEN='\033[1;32m'   # Bold Green
    YELLOW='\033[1;33m'  # Bold Yellow
    RESET='\033[0m'      # Reset color

    echo -e "${YELLOW}==========================================================="
    echo -e "           🚀 APPS INSTALLATION SCRIPT                     "
    echo -e "===========================================================${RESET}"
    echo -e "${BLUE}  📌 This script helps you install essential applications."
    echo -e "  ⚡ If an application is already installed, it will be skipped."
    echo -e "  📂 Choose an option from the menu below:               "
    echo -e "-----------------------------------------------------------${RESET}"
    echo -e "  [1] 🟢 Install Neovim                                   "
    echo -e "  [2] 🔵 Install VS Code                                  "
    echo -e "  [3] ⚡ Install All Apps                                 "
    echo -e "  [4] 🔙 Back to Main Menu                               "
    echo -e "${YELLOW}-----------------------------------------------------------${RESET}"
    echo -ne "👉 Please enter your choice: "
}

# Main script execution
while true; do
    show_menu
    read -r choice
    case $choice in
        1) install_neovim ;;
        2) install_vscode ;;
        3) install_all_apps ;;
        4) echo "Back to Main Menu 👋"; exit 0 ;;
        *) echo "Invalid option. Please try again!" ;;
    esac
done