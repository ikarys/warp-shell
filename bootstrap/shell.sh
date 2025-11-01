#!/bin/bash
# Shell configuration: zsh, starship, zellij

set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🌀 Setting up modern shell environment..."

# Install zsh
if ! command -v zsh &>/dev/null; then
  echo "📦 Installing zsh..."
  sudo apt install -y zsh
else
  echo "✓ zsh already installed"
fi

# Install Starship
if ! command -v starship &>/dev/null; then
  echo "🚀 Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "✓ Starship already installed"
fi

# Install Zellij
if ! command -v zellij &>/dev/null; then
  echo "🧱 Installing Zellij..."
  mkdir -p ~/.local/bin
  curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C ~/.local/bin/
  chmod +x ~/.local/bin/zellij
else
  echo "✓ Zellij already installed"
fi

# Copy dotfiles
echo "📝 Copying dotfiles..."
cp "${REPO_ROOT}/dotfiles/.zshrc" ~/
cp "${REPO_ROOT}/dotfiles/aliases.zsh" ~/

# Starship config
mkdir -p ~/.config
cp "${REPO_ROOT}/dotfiles/starship.toml" ~/.config/starship.toml

# Ensure starship init in .zshrc
if ! grep -q 'starship init zsh' ~/.zshrc; then
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# Set zsh as default shell
ZSH_PATH="$(which zsh)"
if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "🔁 Setting zsh as default shell..."

  # Try chsh (often fails in WSL)
  if command -v chsh &>/dev/null; then
    chsh -s "$ZSH_PATH" "$USER" 2>/dev/null || echo "⚠️  chsh failed, using .bashrc fallback"
  fi

  # Fallback: auto-launch zsh from .bashrc
  if ! grep -q 'exec zsh' ~/.bashrc; then
    echo "⚙️  Adding zsh auto-launch to ~/.bashrc"
    cat >> ~/.bashrc << 'EOF'

# Auto-launch zsh if installed
if [ -t 1 ] && command -v zsh >/dev/null && [ "$SHELL" != "$(which zsh)" ]; then
  exec zsh
fi
EOF
  fi
else
  echo "✅ Shell already set to zsh"
fi

echo "✅ Shell setup complete"
