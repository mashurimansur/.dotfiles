#!/bin/bash

echo "🔹 Installing Zsh..."
sudo apt install -y zsh

# Set Zsh sebagai shell default
chsh -s $(which zsh)

# Install Oh My Zsh
echo "🔹 Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Powerlevel10k Theme
echo "🔹 Installing Powerlevel10k Theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# install plugin zsh-autosuggestions
echo "🔹 Installing Plugins zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Copy konfigurasi default
rm ~/.zshrc
rm ~/.p10k.zsh
stow ~/.dotfiles/zsh
# cp ~/.dotfiles/.zshrc ~/.zshrc

echo "✅ Zsh and Oh My Zsh installed!"
