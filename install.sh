#!/bin/bash

echo "🔹 Starting installation..."

# Update & install essential packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git unzip build-essential
sudo apt install stow -y

# Jalankan skrip individual
bash scripts/install_zsh.sh

# Remove old Zsh configuration and apply new one
echo "🔹 Checking and removing old configuration files..."
[ -f "$HOME/.zshrc" ] && rm "$HOME/.zshrc" && echo "✅ Removed: ~/.zshrc"
[ -f "$HOME/.p10k.zsh" ] && rm "$HOME/.p10k.zsh" && echo "✅ Removed: ~/.p10k.zsh"

stow zsh
stow gitconfig

bash scripts/install_go.sh

#setup nodejs
bash scripts/install_nvm.sh
bash scripts/install_node.sh

# setup nvim
bash scripts/install_nvim.sh
stow nvim

echo "✅ Installation complete!"

# Auto-switch to Zsh
exec zsh