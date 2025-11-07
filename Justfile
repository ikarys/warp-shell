# Warp Shell - Justfile
# Modern terminal environment setup and management

# Default recipe (show help)
default:
    @just --list

# Full installation
install: install-base install-shell install-cli-tools install-dev install-editor install-terminal install-ai install-theme
    @echo "✅ Installation complète terminée!"
    @echo "Redémarre ton shell ou source ~/.zshrc"

# Install base dependencies
install-base:
    @echo "📦 Installation des dépendances de base..."
    @bash scripts/modules/00-base.sh

# Install shell (Zsh + Starship)
install-shell:
    @echo "🐚 Installation du shell..."
    @bash scripts/modules/10-shell.sh

# Install modern CLI tools
install-cli-tools:
    @echo "🔧 Installation des outils CLI modernes..."
    @bash scripts/modules/20-cli-tools.sh

# Install dev tools (mise, lazygit, lazydocker, etc.)
install-dev:
    @echo "💻 Installation des outils de développement..."
    @bash scripts/modules/30-dev.sh

# Install and configure Neovim with LazyVim
install-editor:
    @echo "📝 Installation de Neovim + LazyVim..."
    @bash scripts/modules/40-editor.sh

# Install and configure Zellij
install-terminal:
    @echo "🖥️  Installation de Zellij..."
    @bash scripts/modules/50-terminal.sh

# Install Ollama and AI agents
install-ai machine="prompt":
    @echo "🤖 Installation d'Ollama et des agents IA..."
    @bash scripts/modules/60-ai.sh {{machine}}

# Install cyberpunk theme
install-theme:
    @echo "🎨 Installation du thème cyberpunk..."
    @bash scripts/install-theme.sh

# Sync dotfiles with chezmoi
sync-dotfiles:
    @echo "🔄 Synchronisation des dotfiles..."
    @chezmoi init --apply --source=./dotfiles

# Update all tools
update:
    @echo "🔄 Mise à jour des outils..."
    @mise upgrade
    @nvim --headless "+Lazy! sync" +qa
    @echo "✅ Mise à jour terminée"

# === AI AGENTS ===

# Draft a Jira ticket
jira-draft text lang="fr":
    @bash agents/jira_draft.sh "{{text}}" --lang={{lang}}

# Interactive Jira ticket draft
jira-interactive lang="fr":
    @bash agents/jira_draft.sh --interactive --lang={{lang}}

# Code review on staged changes
review commit="staged":
    @bash agents/code_review.sh --commit={{commit}}

# Translate text (default: French to English)
translate text to="en" from="fr":
    @bash agents/translate.sh "{{text}}" --to {{to}} --from {{from}}

# Translate file (default: to English)
translate-file file to="en":
    @bash agents/translate.sh --file "{{file}}" --to {{to}}

# === UTILITIES ===

# Clean installation artifacts
clean:
    @echo "🧹 Nettoyage..."
    @rm -rf ~/.local/share/nvim
    @rm -rf ~/.cache/nvim
    @echo "✅ Nettoyage terminé"

# Check system requirements
check:
    @bash scripts/utils/checks.sh

# Show current configuration
info:
    @echo "=== Warp Shell Configuration ==="
    @echo "Shell: $(basename $SHELL)"
    @command -v starship >/dev/null && echo "Starship: $(starship --version | head -1)" || echo "Starship: not installed"
    @command -v nvim >/dev/null && echo "Neovim: $(nvim --version | head -1)" || echo "Neovim: not installed"
    @command -v zellij >/dev/null && echo "Zellij: $(zellij --version)" || echo "Zellij: not installed"
    @command -v ollama >/dev/null && echo "Ollama: $(ollama --version)" || echo "Ollama: not installed"
    @[ -f ~/.config/warp-shell/machine.conf ] && cat ~/.config/warp-shell/machine.conf || echo "Machine config: not set"
