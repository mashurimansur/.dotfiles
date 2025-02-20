#!/bin/bash

echo "🔹 Installing Zsh..."
sudo apt install -y zsh

# Set Zsh sebagai shell default
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔹 Setting Zsh as default shell..."
    chsh -s $(which zsh)
fi

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🔹 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh already installed!"
fi

# Install Powerlevel10k Theme
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "🔹 Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "✅ Powerlevel10k already installed!"
fi

# install plugin zsh-autosuggestions
PLUGINS_DIR="$ZSH_CUSTOM/plugins"

if [ ! -d "$PLUGINS_DIR/zsh-autosuggestions" ]; then
    echo "🔹 Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGINS_DIR/zsh-autosuggestions"
fi

echo "✅ Zsh and Oh My Zsh installed!"
