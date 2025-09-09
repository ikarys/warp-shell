#!/bin/bash

sudo apt update && sudo apt install -y \
  zsh git curl wget unzip neovim btop \
  build-essential software-properties-common \
  fzf bat ripgrep fd-find eza tldr \
  locales taskwarrior zoxide cmatrix 

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

# Install Rust-based tools for speed & cyberpunk aesthetics
echo "⚡ Installing fast Rust tools..."
~/.cargo/bin/cargo install du-dust procs tealdeer tokei onefetch macchina hyperfine

# Install duf (disk usage) from GitHub releases
echo "📊 Installing duf (disk usage)..."
DUF_VERSION="0.8.1"
curl -sL "https://github.com/muesli/duf/releases/download/v${DUF_VERSION}/duf_${DUF_VERSION}_linux_amd64.tar.gz" | tar -xz -C /tmp
sudo mv /tmp/duf /usr/local/bin/

# Install delta (better git diff)
~/.cargo/bin/cargo install git-delta

# Install pipes.sh for cyberpunk vibes
curl -sL https://raw.githubusercontent.com/pipeseroni/pipes.sh/master/pipes.sh -o ~/.local/bin/pipes.sh
chmod +x ~/.local/bin/pipes.sh

# Install hollywood hacker simulator
sudo apt install -y hollywood
