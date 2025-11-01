#!/bin/bash
# Node.js development environment: nvm, node, pnpm

set -e

echo "📗 Setting up Node.js development environment..."

# Install nvm
if [ ! -d "$HOME/.nvm" ]; then
  echo "📦 Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  # Add nvm to shell config if not present
  if ! grep -q 'NVM_DIR' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
  fi
else
  echo "✓ nvm already installed"
fi

# Load nvm for this session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest LTS Node.js
if command -v nvm &>/dev/null; then
  echo "📦 Installing Node.js LTS..."
  nvm install --lts
  nvm use --lts
  nvm alias default 'lts/*'
fi

# Install pnpm (fast package manager)
if ! command -v pnpm &>/dev/null; then
  echo "📦 Installing pnpm..."
  curl -fsSL https://get.pnpm.io/install.sh | sh -

  # Add pnpm to PATH
  if ! grep -q 'PNPM_HOME' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
EOF
  fi
else
  echo "✓ pnpm already installed"
fi

# Install common global npm packages
if command -v npm &>/dev/null; then
  echo "📦 Installing global npm packages..."
  npm install -g \
    yarn \
    typescript \
    tsx \
    @biomejs/biome \
    prettier
fi

echo "✅ Node.js environment setup complete"
