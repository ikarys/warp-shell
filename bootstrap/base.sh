#!/bin/bash
# Base packages and CLI tools installation

set -e

echo "📦 Installing base packages..."

sudo apt update && sudo apt install -y \
  curl wget unzip git build-essential \
  software-properties-common locales \
  fzf bat ripgrep fd-find eza zoxide \
  neovim btop tldr taskwarrior cmatrix

echo "🔁 Updating packages..."
sudo apt upgrade -y

echo "🧹 Cleaning up..."
sudo apt autoremove -y

# Fix symlinks for tools with weird names
mkdir -p ~/.local/bin

# fd-find -> fd
if ! command -v fd &>/dev/null; then
  ln -sf $(which fdfind) ~/.local/bin/fd
fi

# batcat -> bat
if ! command -v bat &>/dev/null; then
  ln -sf /usr/bin/batcat ~/.local/bin/bat
fi

# Install lazygit
if ! command -v lazygit &>/dev/null; then
  echo "📦 Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
  curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
  sudo install /tmp/lazygit -D -t /usr/local/bin/
  rm /tmp/lazygit.tar.gz /tmp/lazygit
fi

# Install duf (disk usage)
if ! command -v duf &>/dev/null; then
  echo "📊 Installing duf..."
  DUF_VERSION=$(curl -s "https://api.github.com/repos/muesli/duf/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
  curl -sL "https://github.com/muesli/duf/releases/download/v${DUF_VERSION}/duf_${DUF_VERSION}_linux_amd64.tar.gz" | tar -xz -C /tmp
  sudo mv /tmp/duf /usr/local/bin/
else
  echo "✓ duf already installed"
fi

# Install pipes.sh for fun
if [ ! -f ~/.local/bin/pipes.sh ]; then
  echo "🎨 Installing pipes.sh..."
  curl -sL https://raw.githubusercontent.com/pipeseroni/pipes.sh/master/pipes.sh -o ~/.local/bin/pipes.sh
  chmod +x ~/.local/bin/pipes.sh
fi

echo "✅ Base packages installed"
