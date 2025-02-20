#!/bin/bash


echo "🔹 Fetching the latest Go version..."
GO_LATEST_VERSION=$(curl -s https://go.dev/dl/ | grep -oP 'go[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
INSTALL_DIR="/usr/local"

if ! command -v go &> /dev/null; then
    echo "🔹 Installing Go $GO_VERSION..."
    wget https://go.dev/dl/$GO_LATEST_VERSION.linux-amd64.tar.gz
    sudo tar -C $INSTALL_DIR -xzf $GO_LATEST_VERSION.linux-amd64.tar.gz
    rm $GO_LATEST_VERSION.linux-amd64.tar.gz 
else
    echo "✅ Go already installed!"
fi

# Set PATH
# echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
#!/bin/bash
echo "🔹 Configuring Go environment in ~/.zshrc..."
# Definisikan variabel yang akan dicek
GO_VARS=(
    'export PATH=$PATH:/usr/local/go/bin'
    'export GOPATH=$HOME/go'
    'export GOROOT=/usr/local/go'
    'export GOBIN=$GOPATH/bin'
    'export PATH=$PATH:$GOPATH'
    'export PATH=$PATH:$GOBIN'
)

# Loop untuk menambahkan hanya jika belum ada
for VAR in "${GO_VARS[@]}"; do
    if ! grep -qxF "$VAR" ~/.zshrc; then
        echo "$VAR" >> ~/.zshrc
        echo "✅ Added: $VAR"
    else
        echo "⚠️ Already exists: $VAR"
    fi
done

echo "✅ Go environment setup completed!"

# source ~/.bashrc 
source ~/.zshrc 

echo "✅ Go installed!"
