#!/bin/bash
set -e

# 1. Installer zsh si absent
if ! command -v zsh >/dev/null; then
  echo "📦 Installing zsh..."
  sudo apt install -y zsh
fi

cp ./dotfiles/aliases.zsh ~/
cp ./dotfiles/.zshrc ~/

# 2. Installer Starship
if ! command -v starship >/dev/null; then
  echo "🚀 Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# 3. Ajouter à .zshrc si pas déjà fait
if ! grep -q 'starship init zsh' ~/.zshrc; then
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

# 4. Créer config Starship
mkdir -p ~/.config
echo "🎨 Copie du fichier starship.toml..."
cp "$(dirname "$0")/../dotfiles/starship.toml" ~/.config/starship.toml


# 5. Installer zellij
if ! command -v zellij >/dev/null; then
  echo "🧱 Installing Zellij..."
  mkdir -p ~/.local/bin
  curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C ~/.local/bin/
  chmod +x ~/.local/bin/zellij
fi

echo "✅ Starship & Zellij setup complete."
