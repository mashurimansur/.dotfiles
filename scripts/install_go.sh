#!/bin/bash

GO_VERSION="1.23.4" # Sesuaikan versi
INSTALL_DIR="/usr/local"

echo "🔹 Installing Go $GO_VERSION..."
wget https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz
sudo tar -C $INSTALL_DIR -xzf go$GO_VERSION.linux-amd64.tar.gz
rm go$GO_VERSION.linux-amd64.tar.gz

# Set PATH
# echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
#!/bin/bash

echo "🔹 Configuring Go environment in ~/.zshrc..."
# Definisikan variabel yang akan dicek
GO_VARS=(
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
