# 🚀 Warp Shell

Environnement terminal moderne, modulaire et optimisé pour la productivité.
Conçu pour WSL (Ubuntu 22.04/24.04) mais fonctionne sur tout Linux.

## ✨ Ce que ça installe

### 🐚 Shell
- **Fish** — autosuggestions, syntax highlighting et completions natifs, zéro plugin requis
- **Tide** — prompt Fish-natif, asynchrone, configurable via `tide configure`

### 🔧 Outils CLI modernes
| Classique | Remplacement |
|---|---|
| `grep` | `ripgrep` |
| `cat` | `bat` (syntax highlighting) |
| `ls` | `eza` (git awareness) |
| `find` | `fd` |
| `cd` | `zoxide` (navigation intelligente) |
| `top` | `btop` |
| recherche interactive | `fzf` |
| `jq` | `jq` + `yq` (JSON + YAML) |

### 💻 Dev Tools
- **mise** — gestionnaire de versions multi-langages (Python, Node, Rust, Terraform...)
- **lazygit** — TUI Git
- **lazydocker** — TUI Docker
- **delta** — git diff amélioré
- **pre-commit** — hooks Git

### 🏗️ Infra / Ops
- **kubectl** + **kubectx** + **kubens** — Kubernetes
- **k9s** — TUI Kubernetes
- **yq** — processeur YAML (comme jq pour YAML)
- Terraform/Terragrunt via **mise**

### 🖥️ Terminal
- **Zellij** — multiplexeur terminal avec layouts pré-configurés

### 🤖 AI Tools
- **pi** (`@mariozechner/pi-coding-agent`) — coding agent terminal
- **Claude Code** (`@anthropic-ai/claude-code`) — Claude dans le terminal

### 🎨 Thème Cyberpunk
Palette néon (cyan `#00ffff` / magenta `#ff00ff` / jaune `#ffff00`) coordonnée entre Starship et Zellij.

---

## 📦 Installation

### Prérequis
- Ubuntu 22.04 ou 24.04 (WSL recommandé)
- Connexion internet
- Droits sudo

### Installation complète
```bash
git clone https://github.com/ikarys/warp-shell.git
cd warp-shell
just install
```

### Installation modulaire
```bash
just install-shell        # Fish + Starship
just install-cli-tools    # ripgrep, bat, eza, fzf, zoxide, btop...
just install-dev          # mise, lazygit, lazydocker, delta, pre-commit
just install-terminal     # Zellij
just install-infra        # kubectl, k9s, kubectx, yq
just install-ai-tools     # pi, Claude Code
just install-theme        # Thème cyberpunk
```

### Déployer les dotfiles seuls
```bash
just deploy-dotfiles
```

---

## 🎯 Quick Start

### Zellij Layouts
```bash
zj-dev    # layout dev
zj-ops    # layout ops
```

### Langages avec mise
```bash
mise use -g python@latest
mise use -g node@lts
mise use -g terraform@latest
```

### Kubernetes
```bash
k9s             # TUI Kubernetes
kx              # changer de contexte (kubectx)
kns             # changer de namespace (kubens)
```

---

## 🛠️ Commandes Justfile

```bash
just --list           # Toutes les commandes
just install          # Installation complète
just deploy-dotfiles  # Déployer config.fish + starship.toml
just update           # Mise à jour des outils
just check            # Vérification système
just info             # État de l'installation
```

---

## 📁 Structure

```
warp-shell/
├── Justfile
├── install.sh
├── scripts/
│   ├── modules/
│   │   ├── 00-base.sh        # Dépendances de base
│   │   ├── 10-shell.sh       # Fish + Starship
│   │   ├── 20-cli-tools.sh   # Outils CLI modernes
│   │   ├── 30-dev.sh         # Dev tools
│   │   ├── 40-terminal.sh    # Zellij
│   │   ├── 50-infra.sh       # kubectl, k9s, yq
│   │   └── 60-ai-tools.sh    # pi, Claude Code
│   └── utils/
│       ├── colors.sh
│       └── checks.sh
├── dotfiles/
│   ├── config.fish           # Config Fish principale
│   └── dot_config/
│       ├── starship.toml     # Prompt cyberpunk
│       └── zellij/           # Layouts et thème
└── themes/cyberpunk/
```

---

## 🎨 Customisation

### Ajout d'alias locaux (non versionnés)
```bash
echo 'alias myalias="command"' >> ~/.config/fish/local.fish
```

Fish charge automatiquement `~/.config/fish/local.fish` s'il existe.

---

## 📝 License

MIT — Fais-en ce que tu veux.
