#!/bin/bash
# Module 30 - Development tools

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation des outils de développement"

# Install mise (replaces asdf, nvm, pyenv, rustup, etc.)
if ! command_exists mise; then
    step "Installation de mise..."
    curl https://mise.run | sh
    
    # Add mise to PATH temporarily
    export PATH="$HOME/.local/bin:$PATH"
    
    success "mise installé"
else
    info "mise déjà installé"
fi

# Install lazygit
if ! command_exists lazygit; then
    step "Installation de lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf /tmp/lazygit.tar.gz -C /tmp
    sudo install /tmp/lazygit /usr/local/bin
    rm /tmp/lazygit.tar.gz /tmp/lazygit
    success "lazygit installé"
else
    info "lazygit déjà installé"
fi

# Install lazydocker
if ! command_exists lazydocker; then
    step "Installation de lazydocker..."
    curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    success "lazydocker installé"
else
    info "lazydocker déjà installé"
fi

# Install delta (better git diff)
if ! command_exists delta; then
    step "Installation de delta..."
    DELTA_VERSION="0.17.0"
    wget -q "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -O /tmp/delta.deb
    sudo dpkg -i /tmp/delta.deb
    rm /tmp/delta.deb
    success "delta installé"
else
    info "delta déjà installé"
fi

# Install pre-commit
if ! command_exists pre-commit; then
    step "Installation de pre-commit..."
    python3 -m pip install --user pre-commit
    success "pre-commit installé"
else
    info "pre-commit déjà installé"
fi

# Install commitizen
if ! command_exists cz; then
    step "Installation de commitizen..."
    python3 -m pip install --user commitizen
    success "commitizen installé"
else
    info "commitizen déjà installé"
fi

# Configure git to use delta
if command_exists delta && command_exists git; then
    step "Configuration de git avec delta..."
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate true
    git config --global delta.light false
    git config --global delta.side-by-side true
    git config --global merge.conflictstyle diff3
    git config --global diff.colorMoved default
    success "Git configuré avec delta"
fi

success "Module dev tools installé avec succès"
info "Pour installer Python/Node/Rust, utilise: mise use -g python@latest node@lts rust@latest"
