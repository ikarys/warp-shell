#!/bin/bash
# Install Cyberpunk Theme

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils/colors.sh"

header "Installation du thème Cyberpunk"

# Copy theme files
step "Copie des fichiers de thème..."

# Starship theme
if [ -f "$SCRIPT_DIR/../themes/cyberpunk/starship.toml" ]; then
    cp "$SCRIPT_DIR/../themes/cyberpunk/starship.toml" ~/.config/starship.toml
    success "Thème Starship installé"
else
    warning "Fichier starship.toml non trouvé"
fi

# Zellij theme
if [ -f "$SCRIPT_DIR/../themes/cyberpunk/zellij-theme.kdl" ]; then
    mkdir -p ~/.config/zellij/themes
    cp "$SCRIPT_DIR/../themes/cyberpunk/zellij-theme.kdl" ~/.config/zellij/themes/cyberpunk.kdl
    success "Thème Zellij installé"
else
    warning "Fichier zellij-theme.kdl non trouvé"
fi

# Neovim colorscheme
if [ -d ~/.config/nvim ]; then
    step "Configuration du colorscheme Neovim..."
    # LazyVim will handle the colorscheme via lua config
    info "Configure le colorscheme dans ~/.config/nvim/lua/config/options.lua"
    info "Ajoute: vim.g.lazyvim_colorscheme = 'tokyonight-storm'"
fi

success "Thème Cyberpunk installé"

echo ""
info "Pour une expérience optimale, installe la font:"
echo "  • JetBrains Mono Nerd Font"
echo "  • Download: https://www.nerdfonts.com/font-downloads"
echo ""
info "Configure ta font dans les paramètres de ton terminal"
