#!/bin/bash
# Master setup script for WSL Ubuntu 24.04

set -e

echo "📦 Installing base packages..."
bash ./scripts/install_packages.sh

echo "🌀 Installing and configuring zsh..."
bash ./scripts/setup_shell_starship.sh

echo "🎨 Applying visuals (fonts, terminal theme, etc)..."
bash ./scripts/visuals.sh

# echo "⚙️ Syncing dotfiles..."
# bash ./scripts/dotfiles.sh

echo "🧠 Fixing default shell to zsh..."
bash ./scripts/fix_shell.sh

echo "✅ Done. Enjoy your WSL setup!"
