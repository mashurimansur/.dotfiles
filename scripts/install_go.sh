#!/bin/bash


# Validate inputs
if [[ -z "$1" ]]; then
    echo "❌ Usage: $0 <OS>"
    exit 1
fi

# Detect OS
OS=$1

echo "✅ OS detected: $OS"
echo "🔹 Fetching the latest Go version..."

# Get latest Go version
GO_LATEST_VERSION=$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9]+\.[0-9]+\.[0-9]+' | head -n 1 | sed 's/^go//')

if ! command -v go &>/dev/null; then
    echo "🔹 Installing Go $GO_LATEST_VERSION..."

    if [[ "$OS" == "Linux" ]]; then
        INSTALL_DIR="/usr/local"
        wget https://go.dev/dl/go$GO_LATEST_VERSION.linux-amd64.tar.gz
        sudo tar -C $INSTALL_DIR -xzf go$GO_LATEST_VERSION.linux-amd64.tar.gz
        rm $GO_LATEST_VERSION.linux-amd64.tar.gz 
    elif [[ "$OS" == "Darwin" ]]; then
        brew install go@$GO_LATEST_VERSION
    fi
else
    echo "✅ Go is already installed!"
fi

# Set Go Environment Variables
CONFIG_FILE="$HOME/.zshrc"
echo "🔹 Configuring Go environment in $CONFIG_FILE..."

GO_VARS=(
    'export GOPATH=$HOME/go'
    'export GOROOT=/usr/local/go'
    'export GOBIN=$GOPATH/bin'
    'export PATH=$PATH:$GOROOT/bin:$GOBIN:$GOPATH/bin'
)

for VAR in "${GO_VARS[@]}"; do
    if ! grep -qxF "$VAR" "$CONFIG_FILE"; then
        echo "$VAR" >> "$CONFIG_FILE"
        echo "✅ Added: $VAR"
    else
        echo "⚠️ Already exists: $VAR"
    fi
done

# Apply changes
source "$CONFIG_FILE"

echo "✅ Go installation and environment setup completed!"
