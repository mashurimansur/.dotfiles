#!/bin/bash

echo "🔹 Starting installation..."

# Update & install essential packages
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git unzip build-essential
sudo apt install stow -y

# Jalankan skrip individual
bash scripts/install_zsh.sh
bash scripts/install_go.sh
bash scripts/install_nvm.sh
bash scripts/install_nvim.sh
bash scripts/install_node.sh

stow gitconfig
stow nvim

echo "✅ Installation complete!"
