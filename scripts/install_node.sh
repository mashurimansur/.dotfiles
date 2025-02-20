#!/bin/bash

echo "🔹 Installing Node.js..."
# source ~/.bashrc
source ~/.zshrc

nvm install --lts
nvm use --lts

echo "✅ Node.js installed!"
