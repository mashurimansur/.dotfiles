#!/bin/bash

# Validate input
if [[ -z "$1" ]]; then
    echo "❌ Usage: $0 <OS>"
    exit 1
fi

# Detect OS
OS=$1

# Install Neovim if not installed
if ! command -v nvim &> /dev/null; then
    echo "🔹 Installing Neovim..."
    
    if [[ "$OS" == "Darwin" ]]; then
        echo "🔹 Installing Neovim on macOS..."
        
        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            echo "🔹 Homebrew not found! Installing..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        brew install neovim

    elif [[ "$OS" == "Linux" ]]; then
        echo "🔹 Installing Neovim on Linux..."
        sudo apt update && sudo apt install -y neovim

    else
        echo "❌ Unsupported OS: $OS"
        exit 1
    fi

    echo "✅ Neovim installed!"
else
    echo "✅ Neovim is already installed!"
fi

# Setup Neovim config directory
echo "🔹 Configuring Neovim..."
# Check if Neovim config directory exists
if [ -d "$HOME/.config/nvim" ]; then
    echo "✅ Neovim config directory already exists!"
else
    echo "🔹 Creating Neovim config directory..."
    mkdir -p "$HOME/.config/nvim"
    echo "✅ Neovim config directory created!"
fi

# Uncomment and modify the line below to copy a custom config
# cp -r .config/nvim ~/.config/

echo "✅ Neovim setup complete!"
