#!/bin/bash
# Module 10 - Shell (Fish + Tide)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation du shell (Fish + Tide)"

# Install Fish
if ! command_exists fish; then
    step "Installation de Fish..."
    # Try default apt repos first (Ubuntu 24.04+ ships fish natively)
    if apt-cache show fish >/dev/null 2>&1; then
        sudo apt-get install -y fish
        success "Fish installé (dépôts Ubuntu)"
    else
        # Fallback: PPA for older Ubuntu versions (22.04, 24.04)
        UBUNTU_CODENAME=$(. /etc/os-release && echo "$UBUNTU_CODENAME")
        PPA_URL="https://ppa.launchpadcontent.net/fish-shell/release-4/ubuntu"
        if curl -sf "${PPA_URL}/${UBUNTU_CODENAME}/Release" >/dev/null 2>&1; then
            sudo apt-get install -y software-properties-common
            sudo add-apt-repository -y ppa:fish-shell/release-4
            sudo apt-get update -qq
            sudo apt-get install -y fish
            success "Fish installé (PPA fish-shell 4.x)"
        else
            warning "PPA fish-shell non disponible pour $UBUNTU_CODENAME"
            warning "Tentative via snap..."
            sudo snap install fish
            success "Fish installé (snap)"
        fi
    fi
else
    info "Fish déjà installé"
fi

# Set Fish as default shell
FISH_PATH="$(which fish)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"
if [ "$CURRENT_SHELL" != "$FISH_PATH" ]; then
    step "Fish comme shell par défaut..."
    grep -qxF "$FISH_PATH" /etc/shells || echo "$FISH_PATH" | sudo tee -a /etc/shells
    sudo usermod -s "$FISH_PATH" "$USER"
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
