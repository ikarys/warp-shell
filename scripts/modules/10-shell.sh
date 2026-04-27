#!/bin/bash
# Module 10 - Shell (Fish + Tide)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation du shell (Fish + Tide)"

# Install Fish
if ! command_exists fish; then
    step "Installation de Fish..."
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository -y ppa:fish-shell/release-3
    sudo apt-get update -qq
    sudo apt-get install -y fish
    success "Fish installé"
else
    info "Fish déjà installé"
fi

# Set Fish as default shell
if [ "$SHELL" != "$(which fish)" ]; then
    step "Fish comme shell par défaut..."
    command -v fish | sudo tee -a /etc/shells
    chsh -s "$(which fish)"
    success "Fish défini comme shell par défaut"
    warning "Redémarre ta session pour que ça prenne effet"
else
    info "Fish est déjà le shell par défaut"
fi

# Install Fisher + Tide (runs inside Fish)
step "Installation de Fisher + Tide..."
fish -c "
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
    fisher install IlanCosman/tide@v6
"
success "Fisher + Tide installés"

# Deploy Fish config
step "Déploiement de la config Fish..."
mkdir -p ~/.config/fish
cp "$SCRIPT_DIR/../../dotfiles/config.fish" ~/.config/fish/config.fish
success "config.fish déployé"

success "Module shell installé avec succès"
info "Lance 'tide configure' pour personnaliser ton prompt"
