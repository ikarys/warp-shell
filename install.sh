#!/bin/bash
# Warp Shell - Main Installation Script
# ======================================

set -e

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source utilities
source "$SCRIPT_DIR/scripts/utils/colors.sh"

# Welcome message
clear
echo -e "${NEON_CYAN}"
cat << "EOF"
╦ ╦┌─┐┬─┐┌─┐  ╔═╗┬ ┬┌─┐┬  ┬  
║║║├─┤├┬┘├─┘  ╚═╗├─┤├┤ │  │  
╚╩╝┴ ┴┴└─┴    ╚═╝┴ ┴└─┘┴─┘┴─┘
Modern Terminal Environment
EOF
echo -e "${NC}\n"

info "Bienvenue dans l'installation de Warp Shell!"
echo ""

# Check system requirements
if ask_yes_no "Vérifier les prérequis système?" "y"; then
    bash "$SCRIPT_DIR/scripts/utils/checks.sh"
fi

echo ""
info "Installation modulaire disponible avec: just install-<module>"
info "Pour plus d'options: just --list"
echo ""

# Ask installation type
echo "Type d'installation:"
echo "  1) Complète (recommandé)"
echo "  2) Base (shell + CLI tools)"
echo "  3) Custom (choix des modules)"
echo ""
echo -n "Choix [1-3]: "
read -r install_type

case "$install_type" in
    1)
        header "Installation complète"
        if command -v just >/dev/null 2>&1; then
            just install
        else
            warning "Just non installé, installation manuelle des modules..."
            bash "$SCRIPT_DIR/scripts/modules/00-base.sh"
            bash "$SCRIPT_DIR/scripts/modules/10-shell.sh"
            bash "$SCRIPT_DIR/scripts/modules/20-cli-tools.sh"
            bash "$SCRIPT_DIR/scripts/modules/30-dev.sh"
            bash "$SCRIPT_DIR/scripts/modules/40-editor.sh"
            bash "$SCRIPT_DIR/scripts/modules/50-terminal.sh"
            
            if ask_yes_no "Installer les agents IA?" "y"; then
                bash "$SCRIPT_DIR/scripts/modules/60-ai.sh" prompt
            fi
            
            if ask_yes_no "Installer le thème cyberpunk?" "y"; then
                bash "$SCRIPT_DIR/scripts/install-theme.sh"
            fi
        fi
        ;;
    2)
        header "Installation de base"
        bash "$SCRIPT_DIR/scripts/modules/00-base.sh"
        bash "$SCRIPT_DIR/scripts/modules/10-shell.sh"
        bash "$SCRIPT_DIR/scripts/modules/20-cli-tools.sh"
        ;;
    3)
        header "Installation custom"
        
        modules=(
            "00-base.sh:Dépendances de base"
            "10-shell.sh:Shell (Zsh + Starship)"
            "20-cli-tools.sh:Outils CLI modernes"
            "30-dev.sh:Outils de développement"
            "40-editor.sh:Neovim + LazyVim"
            "50-terminal.sh:Zellij"
            "60-ai.sh:Agents IA (Ollama)"
        )
        
        for module in "${modules[@]}"; do
            IFS=':' read -r file desc <<< "$module"
            if ask_yes_no "Installer: $desc" "y"; then
                bash "$SCRIPT_DIR/scripts/modules/$file" prompt
            fi
        done
        
        if ask_yes_no "Installer le thème cyberpunk?" "y"; then
            bash "$SCRIPT_DIR/scripts/install-theme.sh"
        fi
        ;;
    *)
        error "Choix invalide"
        exit 1
        ;;
esac

# Final message
echo ""
header "Installation terminée! 🎉"
echo ""
success "Warp Shell est maintenant installé!"
echo ""
info "Prochaines étapes:"
echo "  1. Redémarre ton shell ou: source ~/.zshrc"
echo "  2. Configure les dotfiles: just sync-dotfiles"
echo "  3. Installe la font JetBrains Mono Nerd Font"
echo "  4. Lance Neovim pour installer les plugins: nvim"
echo "  5. Explore les commandes: just --list"
echo ""
info "Documentation: https://github.com/ikarys/warp-shell"
echo ""
