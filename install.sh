#!/bin/bash

echo "🔹 Starting installation..."

# Update & install essential packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git unzip build-essential
sudo apt install stow -y

# Jalankan skrip individual
bash scripts/install_zsh.sh

# Set Zsh sebagai shell default jika belum
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🔹 Setting Zsh as default shell..."
    chsh -s $(which zsh)
fi

# Remove old Zsh configuration and apply new one
echo "🔹 Checking and removing old configuration files..."
[ -f "$HOME/.zshrc" ] && rm "$HOME/.zshrc" && echo "✅ Removed: ~/.zshrc"
[ -f "$HOME/.p10k.zsh" ] && rm "$HOME/.p10k.zsh" && echo "✅ Removed: ~/.p10k.zsh"

stow zsh
stow gitconfig
stow nvim

bash scripts/install_go.sh
bash scripts/install_nvm.sh
bash scripts/install_nvim.sh
bash scripts/install_node.sh

echo "✅ Installation complete!"

# Auto-switch to Zsh
exec zsh