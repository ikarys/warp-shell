# Warp Shell - Justfile
# Modern terminal environment setup and management

# Default recipe (show help)
default:
    @just --list

# Full installation
install: install-base install-shell install-cli-tools install-dev install-docker install-terminal install-ghostty install-infra install-ai-tools
    @echo "✅ Installation complète terminée!"
    @echo "Reconnecte-toi ou lance 'fish' pour démarrer"

# Install base dependencies
install-base:
    @echo "📦 Installation des dépendances de base..."
    @bash scripts/modules/00-base.sh

# Install shell (Fish + Starship)
install-shell:
    @echo "🐚 Installation du shell (Fish + Starship)..."
    @bash scripts/modules/10-shell.sh

# Install modern CLI tools
install-cli-tools:
    @echo "🔧 Installation des outils CLI modernes..."
    @bash scripts/modules/20-cli-tools.sh

# Install Docker
install-docker:
    @echo "🐳 Installation de Docker..."
    @bash scripts/modules/35-docker.sh

# Install dev tools (mise, lazygit, lazydocker, delta, pre-commit)
install-dev:
    @echo "💻 Installation des outils de développement..."
    @bash scripts/modules/30-dev.sh

# Install and configure Zellij
install-terminal:
    @echo "🖥️  Installation de Zellij..."
    @bash scripts/modules/40-terminal.sh

# Install and configure Ghostty
install-ghostty:
    @echo "👻 Installation de Ghostty..."
    @bash scripts/modules/45-ghostty.sh

# Install infra tools (kubectl, k9s, kubectx, yq)
install-infra:
    @echo "🏗️  Installation des outils infra..."
    @bash scripts/modules/50-infra.sh

# Install AI tools (pi, Claude Code)
install-ai-tools:
    @echo "🤖 Installation des outils IA (pi, Claude Code)..."
    @bash scripts/modules/60-ai-tools.sh

# Install cyberpunk theme
install-theme:
    @echo "🎨 Installation du thème cyberpunk..."
    @bash scripts/install-theme.sh

# Deploy dotfiles manually (without chezmoi)
deploy-dotfiles:
    @echo "🔄 Déploiement des dotfiles..."
    @mkdir -p ~/.config/fish
    @cp dotfiles/config.fish ~/.config/fish/config.fish
    @mkdir -p ~/.config/ghostty/themes
    @cp dotfiles/dot_config/ghostty/config ~/.config/ghostty/config
    @cp themes/cyberpunk/ghostty ~/.config/ghostty/themes/cyberpunk
    @fish dotfiles/tide_config.fish
    @echo "✅ Dotfiles déployés"

# Update all tools
update:
    @echo "🔄 Mise à jour des outils..."
    @mise upgrade
    @npm update -g @mariozechner/pi-coding-agent @anthropic-ai/claude-code
    @echo "✅ Mise à jour terminée"

# === UTILITIES ===

# Clean installation artifacts
clean:
    @echo "🧹 Nettoyage..."
    @rm -rf ~/.cache/pip
    @echo "✅ Nettoyage terminé"

# Check system requirements
check:
    @bash scripts/utils/checks.sh

# Show current configuration
info:
    @echo "=== Warp Shell Configuration ==="
    @echo "Shell: $(basename $SHELL)"
    @command -v fish      >/dev/null && echo "Fish:     $(fish --version)"      || echo "Fish:     not installed"
    @fish -c 'tide --version 2>/dev/null && echo "Tide:     installed" || echo "Tide:     not installed"' 2>/dev/null || echo "Tide:     not installed"
    @command -v zellij    >/dev/null && echo "Zellij:   $(zellij --version)"    || echo "Zellij:   not installed"
    @command -v mise      >/dev/null && echo "mise:     $(mise --version)"      || echo "mise:     not installed"
    @command -v lazygit   >/dev/null && echo "lazygit:  $(lazygit --version)"   || echo "lazygit:  not installed"
    @command -v kubectl   >/dev/null && echo "kubectl:  $(kubectl version --client --short 2>/dev/null)" || echo "kubectl:  not installed"
    @command -v k9s       >/dev/null && echo "k9s:      $(k9s version --short)" || echo "k9s:      not installed"
    @command -v pi        >/dev/null && echo "pi:       installed"               || echo "pi:       not installed"
    @command -v claude    >/dev/null && echo "claude:   installed"               || echo "claude:   not installed"
