#!/bin/bash
# Module 10 - Shell (Zsh + Starship)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installing shell"

# Install Zsh
if ! command_exists zsh; then
    step "Installing Zsh..."
    sudo apt-get install -y zsh
    success "Zsh installed"
else
    info "Zsh already installed"
fi

# Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    step "Setting Zsh as default shell..."
    chsh -s "$(which zsh)"
    success "Zsh set as default shell"
    warning "You need to log out and log back in for this to take effect"
else
    info "Zsh is already the default shell"
fi

# Install Starship
if ! command_exists starship; then
    step "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    success "Starship installed"
else
    info "Starship already installed"
fi

# Create Starship config directory
mkdir -p ~/.config

# Install chezmoi
if ! command_exists chezmoi; then
    step "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    success "chezmoi installed"
else
    info "chezmoi already installed"
fi

success "Module shell installed successfully"