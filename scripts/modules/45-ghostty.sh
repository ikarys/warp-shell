#!/bin/bash
# Module 45 - Ghostty terminal emulator

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation de Ghostty"

# Ask before installing (it's a GUI app, user may prefer another terminal)
if ! ask_yes_no "Installer Ghostty (terminal moderne avec GPU acceleration)?" "y"; then
    info "Ghostty ignoré"
    exit 0
fi

# Install Ghostty
if ! command_exists ghostty; then
    step "Installation de Ghostty..."
    if apt-cache show ghostty >/dev/null 2>&1; then
        sudo apt-get install -y ghostty
        success "Ghostty installé (apt)"
    elif snap list ghostty >/dev/null 2>&1; then
        sudo snap install ghostty --classic
        success "Ghostty installé (snap)"
    else
        error "Ghostty non disponible via apt ou snap sur cette distribution"
        info "Installation manuelle : https://ghostty.org/download"
        exit 1
    fi
else
    info "Ghostty déjà installé ($(ghostty --version 2>/dev/null || echo 'version inconnue'))"
fi

# Deploy config
step "Déploiement de la configuration Ghostty..."
mkdir -p ~/.config/ghostty/themes
cp "$SCRIPT_DIR/../../dotfiles/dot_config/ghostty/config" ~/.config/ghostty/config
success "Config Ghostty déployée"

# Deploy cyberpunk theme
step "Installation du thème Cyberpunk..."
cp "$SCRIPT_DIR/../../themes/cyberpunk/ghostty" ~/.config/ghostty/themes/cyberpunk
success "Thème Cyberpunk installé"

success "Module Ghostty installé avec succès"
info "Lance 'ghostty' pour démarrer"
warning "Installe JetBrains Mono Nerd Font pour les icônes : https://www.nerdfonts.com/font-downloads"
