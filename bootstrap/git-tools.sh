#!/bin/bash
# Git tools: commitizen, pre-commit, git configs

set -e

echo "🔧 Setting up Git tools..."

# Install commitizen via pipx
if ! command -v cz &>/dev/null; then
  echo "📦 Installing commitizen..."
  pipx install commitizen
else
  echo "✓ commitizen already installed"
fi

# Install pre-commit
if ! command -v pre-commit &>/dev/null; then
  echo "📦 Installing pre-commit..."
  pipx install pre-commit
else
  echo "✓ pre-commit already installed"
fi

# Configure global gitignore
if [ ! -f ~/.gitignore_global ]; then
  echo "📝 Creating global gitignore..."
  cat > ~/.gitignore_global << 'EOF'
# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Python
__pycache__/
*.py[cod]
*$py.class
.pytest_cache/
.venv/
venv/
*.egg-info/
.mypy_cache/

# Node
node_modules/
.npm/
.yarn/

# Build artifacts
dist/
build/
*.log

# Environment
.env
.env.local
.env.*.local

# Misc
.cache/
.tmp/
EOF

  git config --global core.excludesfile ~/.gitignore_global
  echo "✓ Global gitignore configured"
fi

# Set up useful git aliases
echo "📝 Setting up git aliases..."
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Configure delta as pager if installed
if command -v delta &>/dev/null; then
  echo "📝 Configuring git delta..."
  git config --global core.pager delta
  git config --global interactive.diffFilter 'delta --color-only'
  git config --global delta.navigate true
  git config --global delta.side-by-side true
  git config --global delta.line-numbers true
fi

echo "✅ Git tools setup complete"
