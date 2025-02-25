#!/bin/bash

# Validate inputs
if [[ -z "$1" || -z "$2" ]]; then
    echo "❌ Usage: $0 <OS> <PKG_MANAGER>"
    exit 1
fi

# Detect OS
OS=$1
PKG_MANAGER=$2

# Install Zsh
echo "🔹 Installing Zsh..."
if [[ "$OS" == "Linux" ]]; then
    $PKG_MANAGER update -y
    $PKG_MANAGER install -y zsh
elif [[ "$OS" == "Darwin" ]]; then
    $PKG_MANAGER install zsh
fi

# Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔹 Setting Zsh as default shell..."
    chsh -s $(which zsh)
fi

# Install Oh My Zsh (if not already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🔹 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh already installed!"
fi

# Define custom Zsh directory
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install Powerlevel10k Theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "🔹 Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "✅ Powerlevel10k already installed!"
fi

# Install plugins
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

# zsh-autosuggestions
if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "🔹 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
else
    echo "✅ zsh-autosuggestions already installed!"
fi

# zsh-syntax-highlighting
if [ ! -d "$PLUGINS_DIR/zsh-syntax-highlighting" ]; then
    echo "🔹 Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$PLUGINS_DIR/zsh-syntax-highlighting"
else
    echo "✅ zsh-syntax-highlighting already installed!"
fi

echo "✅ Zsh, Oh My Zsh, Powerlevel10k, and plugins installed successfully!"
