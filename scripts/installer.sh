#!/bin/bash

echo "🔹 Starting installation..."

# Detect OS
OS="$(uname -s)"

# Update & install essential packages
echo "🔹 Updating system and installing essential packages..."
if [[ "$OS" == "Linux" ]]; then
    echo "✅ Linux detected"
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y curl wget git unzip build-essential stow
elif [[ "$OS" == "Darwin" ]]; then
    echo "✅ macOS detected"
    if ! command -v brew &>/dev/null; then
        echo "🔹 Homebrew not found. Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo "✅ Homebrew installed successfully!"
    else
        echo "✅ Homebrew is already installed!"
    fi
    brew update
    brew install curl wget git unzip stow
else
    echo "❌ Unsupported OS: $OS"
    exit 1
fi

# Run individual installation scripts
bash scripts/install_zsh.sh "$OS"

# Remove old Zsh configuration and ap   ply new one
echo "🔹 Checking and removing old configuration files..."
[ -f "$HOME/.zshrc" ] && rm "$HOME/.zshrc" && echo "✅ Removed: ~/.zshrc"
[ -f "$HOME/.p10k.zsh" ] && rm "$HOME/.p10k.zsh" && echo "✅ Removed: ~/.p10k.zsh"
echo "✅ Old Zsh configuration files cleaned up!"

stow zsh && stow gitconfig

bash scripts/install_go.sh "$OS"

# Setup Node.js
bash scripts/install_nvm.sh "$OS"
bash scripts/install_node.sh

# # Check if running on WSL or native Linux/macOS
# if [[ "$OS" == "Linux" && -f /proc/sys/kernel/osrelease ]]; then
#     if grep -qi microsoft /proc/sys/kernel/osrelease; then
#         echo "🖥 Running on WSL"
#     else
#         echo "🖥 Running on native Ubuntu"
#         bash applications/install_vscode.sh
#     fi
# elif [[ "$OS" == "Darwin" ]]; then
#     echo "🖥 Running on macOS"
#     bash applications/install_vscode.sh
# fi

echo "✅ Installation complete!"

# Auto-switch to Zsh
exec zsh
