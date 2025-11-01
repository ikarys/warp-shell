#!/bin/bash
# Python development environment: pyenv, poetry, pipx

set -e

echo "🐍 Setting up Python development environment..."

# Install dependencies for building Python
sudo apt update && sudo apt install -y \
  make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
  libffi-dev liblzma-dev python3-pip pipx

# Install pyenv
if [ ! -d "$HOME/.pyenv" ]; then
  echo "📦 Installing pyenv..."
  curl https://pyenv.run | bash

  # Add pyenv to shell config if not present
  if ! grep -q 'pyenv init' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF
  fi
else
  echo "✓ pyenv already installed"
fi

# Load pyenv for this session
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)" 2>/dev/null || true

# Install latest Python via pyenv
PYTHON_VERSION="3.12.0"
if [ -d "$HOME/.pyenv" ]; then
  if ! pyenv versions | grep -q "$PYTHON_VERSION"; then
    echo "🐍 Installing Python $PYTHON_VERSION..."
    pyenv install $PYTHON_VERSION
    pyenv global $PYTHON_VERSION
  else
    echo "✓ Python $PYTHON_VERSION already installed"
  fi
fi

# Ensure pipx path
pipx ensurepath

# Install poetry via pipx
if ! command -v poetry &>/dev/null; then
  echo "📦 Installing Poetry..."
  pipx install poetry
else
  echo "✓ Poetry already installed"
fi

# Install common Python dev tools
echo "📦 Installing Python dev tools..."
PYTHON_TOOLS=(
  "black"          # Code formatter
  "ruff"           # Fast linter
  "ipython"        # Better REPL
  "pytest"         # Testing
)

for tool in "${PYTHON_TOOLS[@]}"; do
  if ! pipx list | grep -q "$tool"; then
    echo "Installing ${tool}..."
    pipx install ${tool}
  else
    echo "✓ ${tool} already installed"
  fi
done

echo "✅ Python environment setup complete"
