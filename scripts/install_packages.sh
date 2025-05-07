#!/bin/bash

sudo apt update && sudo apt install -y \
  zsh git curl wget unzip neovim btop \
  build-essential software-properties-common \
  fzf bat ripgrep fd-find eza tldr \
  locales taskwarrior zoxide 

echo "🔁 Updating packages..."
sudo apt upgrade -y

echo "Cleaning up..."
sudo apt autoremove -y

# Fix for fd
ln -s $(which fdfind) ~/.local/bin/fd


LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# Install bat
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
