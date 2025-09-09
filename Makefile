# Makefile – Bootstrap environnement WSL Cyberpunk

.PHONY: all bootstrap shell packages packages-dev visuals fix-shell clean help

all: bootstrap

# 🚀 Installation complète
bootstrap:
	@echo "🔥 Starting WSL Cyberpunk Environment Setup..."
	bash bootstrap.sh

# 📦 Installation packages de base + outils Rust
packages:
	@echo "📦 Installing base packages..."
	bash scripts/install_packages.sh

# 🛠️ Packages développement (Python, pip, etc)
packages-dev:
	@echo "🛠️ Installing dev packages..."
	bash scripts/install_packages_dev.sh

# 🌀 Configuration shell (zsh + starship + zellij)
shell:
	@echo "🌀 Setting up shell..."
	bash scripts/setup_shell_starship.sh

# 🎨 Polices + thèmes cyberpunk
visuals:
	@echo "🎨 Applying cyberpunk visuals..."
	bash scripts/visuals.sh

# 🧠 Shell par défaut
fix-shell:
	@echo "🧠 Setting zsh as default shell..."
	bash scripts/fix_shell.sh

# 🧹 Nettoyage complet
clean:
	@echo "🧹 Cleaning up old configs..."
	rm -rf ~/.oh-my-zsh ~/.p10k.zsh ~/.config/starship.toml ~/.zshrc ~/.fzf.zsh

# 📚 Aide
help:
	@echo "🚀 WSL Cyberpunk Environment Setup"
	@echo ""
	@echo "Commands:"
	@echo "  make bootstrap    - Installation complète"
	@echo "  make packages     - Packages de base + Rust tools"
	@echo "  make packages-dev - Packages développement"
	@echo "  make shell        - Configuration zsh + starship"
	@echo "  make visuals      - Polices + thèmes cyberpunk"
	@echo "  make fix-shell    - Définir zsh par défaut"
	@echo "  make clean        - Nettoyer anciennes configs"
	@echo "  make help         - Afficher cette aide"
