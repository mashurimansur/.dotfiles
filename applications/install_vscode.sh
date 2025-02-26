#!/bin/bash

# Validate inputs
if [[ -z "$1" ]]; then
    echo "❌ Usage: $0 <OS> "
    exit 1
fi

# Detect OS
OS=$1

# Install VS Code based on OS
if [[ "$OS" == "Darwin" ]]; then
    echo "🔹 Installing VS Code on macOS..."
    # Install VS Code using Homebrew
    brew install --cask visual-studio-code

elif [[ "$OS" == "Linux" ]]; then
    echo "🔹 Installing VS Code on Linux..."
    
    sudo apt update
    sudo apt install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null
    echo "deb [signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt update
    sudo apt install -y code
else
    echo "❌ Unsupported OS: $OS"
    exit 1
fi

echo "✅ VS Code installed!"
