#!/bin/bash

echo "🔹 Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Load NVM in shell
NVM_CONFIG=(
    'export NVM_DIR="$HOME/.nvm"'
    '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
    '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
)

# Loop untuk menambahkan hanya jika belum ada
for VAR in "${NVM_CONFIG[@]}"; do
    if ! grep -qxF "$VAR" ~/.zshrc; then
        echo "$VAR" >> ~/.zshrc
        echo "✅ Added: $VAR"
    else
        echo "⚠️ Already exists: $VAR"
    fi
done

echo "✅ NVM installed!"
