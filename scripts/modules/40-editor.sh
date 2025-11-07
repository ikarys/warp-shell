#!/bin/bash
# Module 40 - Neovim + LazyVim

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation de Neovim + LazyVim"

# Install Neovim (latest stable)
if ! command_exists nvim; then
    step "Installation de Neovim..."
    wget -q https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz -O /tmp/nvim.tar.gz
    sudo tar -xzf /tmp/nvim.tar.gz -C /opt
    sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
    rm /tmp/nvim.tar.gz
    success "Neovim installé"
else
    info "Neovim déjà installé"
fi

# Backup existing Neovim config
if [ -d ~/.config/nvim ]; then
    if ask_yes_no "Une config Neovim existe déjà. Backup?" "y"; then
        step "Backup de la config existante..."
        mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d_%H%M%S)
        mv ~/.local/share/nvim ~/.local/share/nvim.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
        mv ~/.local/state/nvim ~/.local/state/nvim.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
        mv ~/.cache/nvim ~/.cache/nvim.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true
        success "Backup effectué"
    else
        warning "Installation annulée pour préserver la config existante"
        exit 0
    fi
fi

# Install LazyVim starter
step "Installation de LazyVim..."
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

success "LazyVim installé"

# Install dependencies for LSP
step "Installation des dépendances LSP..."
sudo apt-get install -y \
    nodejs \
    npm

success "Dépendances LSP installées"

info "Première ouverture de Neovim pour installer les plugins..."
info "Lance 'nvim' et attends que les plugins s'installent"
info "Tu pourras customiser la config dans ~/.config/nvim/lua/config/"

success "Module editor installé avec succès"
