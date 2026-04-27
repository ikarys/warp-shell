#!/bin/bash
# Module 20 - Modern CLI tools

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation des outils CLI modernes"

# Install from apt
step "Installation via apt..."
sudo apt-get install -y \
    ripgrep \
    fd-find \
    jq

success "Outils apt installés"

# fzf (binary depuis GitHub releases pour garantir >= 0.48.0)
if ! command_exists fzf; then
    step "Installation de fzf..."
    FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    wget -q "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz" -O /tmp/fzf.tar.gz
    tar -xzf /tmp/fzf.tar.gz -C /tmp
    sudo install /tmp/fzf /usr/local/bin/fzf
    rm /tmp/fzf.tar.gz /tmp/fzf
    success "fzf ${FZF_VERSION} installé"
else
    # Mettre à jour si version < 0.48.0
    FZF_CURRENT=$(fzf --version | grep -Po '^[0-9.]+')
    if [ "$(printf '%s\n' "0.48.0" "$FZF_CURRENT" | sort -V | head -1)" = "$FZF_CURRENT" ] && [ "$FZF_CURRENT" != "0.48.0" ]; then
        warning "fzf ${FZF_CURRENT} trop ancien (< 0.48.0), mise à jour..."
        FZF_VERSION=$(curl -s "https://api.github.com/repos/junegunn/fzf/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        wget -q "https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VERSION}-linux_amd64.tar.gz" -O /tmp/fzf.tar.gz
        tar -xzf /tmp/fzf.tar.gz -C /tmp
        sudo install /tmp/fzf /usr/local/bin/fzf
        rm /tmp/fzf.tar.gz /tmp/fzf
        success "fzf mis à jour vers ${FZF_VERSION}"
    else
        info "fzf ${FZF_CURRENT} déjà à jour"
    fi
fi

# bat
if ! command_exists bat; then
    step "Installation de bat..."
    BAT_VERSION="0.24.0"
    wget -q "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" -O /tmp/bat.deb
    sudo dpkg -i /tmp/bat.deb
    rm /tmp/bat.deb
    success "bat installé"
else
    info "bat déjà installé"
fi

# eza
if ! command_exists eza; then
    step "Installation de eza..."
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt-get update -qq
    sudo apt-get install -y eza
    success "eza installé"
else
    info "eza déjà installé"
fi

# zoxide
if ! command_exists zoxide; then
    step "Installation de zoxide..."
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
    success "zoxide installé"
else
    info "zoxide déjà installé"
fi

# btop
if ! command_exists btop; then
    step "Installation de btop..."
    BTOP_VERSION="1.3.2"
    wget -q "https://github.com/aristocratos/btop/releases/download/v${BTOP_VERSION}/btop-x86_64-linux-musl.tbz" -O /tmp/btop.tbz
    tar -xjf /tmp/btop.tbz -C /tmp
    sudo /tmp/btop/install.sh
    rm -rf /tmp/btop.tbz /tmp/btop
    success "btop installé"
else
    info "btop déjà installé"
fi

# Symlink fd (Ubuntu uses fd-find)
if [ ! -e ~/.local/bin/fd ] && command_exists fdfind; then
    mkdir -p ~/.local/bin
    ln -s "$(which fdfind)" ~/.local/bin/fd
    success "Symlink fd créé"
fi

success "Module CLI tools installé avec succès"
