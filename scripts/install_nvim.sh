#!/bin/bash

# Validate inputs
if [[ -z "$1" ]]; then
    echo "❌ Usage: $0 <PKG_MANAGER>"
    exit 1
fi

# Detect OS
PKG_MANAGER=$1

# Install Neovim
echo "🔹 Installing Neovim..."
if ! command -v nvim &> /dev/null; then
    if [[ "$PKG_MANAGER" == "brew" ]]; then
        brew install neovim
    else
        sudo apt update && sudo apt install -y neovim
    fi
    echo "✅ Neovim installed!"
else
    echo "✅ Neovim is already installed!"
fi

# Setup Neovim config directory
echo "🔹 Configuring Neovim..."
mkdir -p ~/.config/nvim
# Uncomment and modify the line below to copy a custom config
# cp -r .config/nvim ~/.config/

echo "✅ Neovim setup complete!"
