#!/bin/bash
# Module 50 - Zellij terminal multiplexer

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation de Zellij"

# Install Zellij
if ! command_exists zellij; then
    step "Installation de Zellij..."
    cargo install --locked zellij 2>/dev/null || {
        # If cargo not available, download binary
        ZELLIJ_VERSION="0.44.3"
        wget -q "https://github.com/zellij-org/zellij/releases/download/v${ZELLIJ_VERSION}/zellij-x86_64-unknown-linux-musl.tar.gz" -O /tmp/zellij.tar.gz
        tar -xzf /tmp/zellij.tar.gz -C /tmp
        sudo install /tmp/zellij /usr/local/bin
        rm /tmp/zellij.tar.gz /tmp/zellij
    }
    success "Zellij installé"
else
    info "Zellij déjà installé"
fi

# Create Zellij config directory
mkdir -p ~/.config/zellij/layouts

success "Module terminal installé avec succès"
info "Les layouts Zellij seront configurés via chezmoi dotfiles"
