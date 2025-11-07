# 🚀 Warp Shell

Configuration de terminal moderne, modulaire et optimisée pour la productivité. Conçu pour WSL (Ubuntu 22.04/24.04) mais fonctionne sur tout Linux.

## ✨ Caractéristiques

### 🐚 Shell Moderne
- **Zsh** avec configuration optimisée
- **Starship** prompt cyberpunk thématique
- **Zellij** multiplexeur terminal intuitif avec layouts pré-configurés

### 🔧 Outils CLI Modernes
Remplacements performants des outils classiques:
- `ripgrep` → grep rapide
- `bat` → cat avec syntax highlighting
- `eza` → ls moderne avec git awareness
- `fd` → find simplifié
- `zoxide` → cd intelligent
- `fzf` → fuzzy finder universel
- `delta` → git diff amélioré
- `atuin` → historique shell avancé

### 💻 Dev Tools
- **mise** - Gestionnaire de versions multi-langages (Python, Node, Rust)
- **lazygit** - TUI Git puissant
- **lazydocker** - TUI Docker
- **pre-commit** + **commitizen** - Git workflow moderne
- **Neovim** avec **LazyVim** - IDE moderne dans le terminal

### 🤖 Agents IA
Agents spécialisés utilisant Ollama:
- **Jira Draft** - Rédaction de tickets Jira professionnels
- **Code Review** - Review automatique de code
- **Traduction** - Traduction de texte et fichiers

Modèles optimisés selon ta machine (laptop léger / desktop RTX puissant)

### 🎨 Thème Cyberpunk
Thème coordonné à travers tous les outils avec palette néon:
- Cyan (`#00ffff`)
- Magenta (`#ff00ff`)
- Jaune (`#ffff00`)

## 📦 Installation

### Prérequis
- Ubuntu 22.04 ou 24.04 (WSL recommandé)
- Connexion internet
- Droits sudo

### Installation Rapide
```bash
# Clone le repo
git clone https://github.com/ikarys/warp-shell.git
cd warp-shell

# Installation complète
chmod +x scripts/**/*.sh
just install
```

### Installation Modulaire
```bash
# Seulement le shell et CLI tools
just install-base
just install-shell
just install-cli-tools

# Dev tools
just install-dev
just install-editor

# Terminal multiplexer
just install-terminal

# Agents IA
just install-ai

# Thème
just install-theme
```

## 🎯 Quick Start

### Zellij Layouts
```bash
# Dev layout (neovim + lazygit + terminal)
zellij --layout dev

# Ops layout (btop + lazydocker + logs)
zellij --layout ops

# Review layout (code + review + git)
zellij --layout review

# Ou utilise les alias
zj-dev
zj-ops
```

### Agents IA
```bash
# Draft Jira ticket
just jira-draft "Ajouter authentification OAuth2"
just jira-draft --interactive --lang=en

# Code review
git add .
just review

# Traduction
just translate "Hello world" --to=fr
just translate-file README.md --to=en
```

### Dev Workflow
```bash
# Setup langages avec mise
mise use -g python@latest node@lts rust@latest

# Git avec lazygit
lg

# Docker avec lazydocker
ld

# Edit avec Neovim
nvim myfile.py
```

## 🛠️ Commandes Justfile

```bash
just --list              # Liste toutes les commandes
just install            # Installation complète
just install-<module>   # Installation modulaire
just sync-dotfiles      # Sync config avec chezmoi
just update            # Mise à jour des outils
just clean             # Nettoyage
just check             # Vérification système
just info              # Info configuration
```

## 📁 Structure du Projet

```
warp-shell/
├── Justfile                    # Orchestration
├── scripts/
│   ├── modules/               # Scripts d'installation modulaires
│   └── utils/                 # Utilitaires (colors, checks)
├── dotfiles/                  # Templates dotfiles (chezmoi)
│   ├── dot_zshrc.tmpl
│   └── dot_config/
│       ├── starship.toml
│       ├── zellij/
│       └── nvim/
├── agents/                    # Agents IA
│   ├── core/                 # Classes de base
│   ├── jira_draft.py
│   ├── code_review.py
│   ├── translate.py
│   └── config/prompts/       # Prompts système
├── themes/cyberpunk/          # Thème cyberpunk
└── docs/                      # Documentation
```

## 🎨 Customisation

### Ajouter des Alias
Édite `~/.zshrc.local` (non versionné):
```bash
echo 'alias myalias="command"' >> ~/.zshrc.local
```

### Changer le Thème
Modifie `~/.config/starship.toml` et `~/.config/zellij/themes/cyberpunk.kdl`

### Créer un Agent IA
1. Copie un agent existant dans `agents/`
2. Crée un prompt dans `agents/config/prompts/`
3. Ajoute une commande dans `Justfile`

## 📖 Documentation

- [Installation détaillée](docs/INSTALL.md)
- [Guide Agents IA](docs/AGENTS.md)
- [Raccourcis clavier](docs/KEYBINDINGS.md)

## 🤝 Contribution

Les contributions sont bienvenues! N'hésite pas à ouvrir une issue ou PR.

## 📝 License

MIT License - Fais-en ce que tu veux!

## 🙏 Crédits

Construit avec des outils open source incroyables:
- [Starship](https://starship.rs/)
- [Zellij](https://zellij.dev/)
- [Neovim](https://neovim.io/)
- [LazyVim](https://www.lazyvim.org/)
- [Ollama](https://ollama.com/)
- Et bien d'autres...

---

Fait avec ⚡ par [@ikarys](https://github.com/ikarys)
