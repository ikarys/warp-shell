# 🚀 Warp Shell - Modern Development Environment

A complete, modular, and portable development environment for WSL Ubuntu. Bootstrap your entire dev stack with toolchains, IaC tools, AI agents, and modern CLI utilities - all version-controlled and reproducible across machines.

**Not just another dotfiles repo** - This is a full-featured development workstation setup with:
- 🐍 Python (pyenv, poetry, pipx)
- 📗 Node.js (nvm, pnpm)
- 🦀 Rust (cargo tools)
- 🐳 Docker & devcontainers
- ☸️ IaC tools (terraform, opentofu, k8s)
- 🤖 Local AI agents (Ollama)
- 🔮 Advanced shell history (atuin)
- 🎨 Modern CLI tools

---

## ✨ Features

### 🛠️ Development Toolchains
- **Python**: pyenv, poetry, pipx, black, ruff, pytest
- **Node.js**: nvm, pnpm, typescript, biome, prettier
- **Rust**: rustup, cargo, clippy, rustfmt
- **Go**: (optional) go, gopls

### 🐳 Containers & Infrastructure
- **Docker**: docker, docker-compose, lazydocker
- **Kubernetes**: kubectl, helm, k9s, kubectx, kustomize
- **IaC**: terraform (tfenv), opentofu, terragrunt (tenv)
- **Devcontainers**: Ready-to-use templates for Python, Node, Rust, Fullstack

### 🤖 AI & Productivity
- **Ollama**: Local LLM for AI agents
- **AI Agents**: Translator, Jira ticket generator, doc generator
- **Atuin**: Magical shell history sync & search
- **Commitizen**: Conventional commits
- **Pre-commit**: Git hooks automation

### ⚡ Modern CLI Tools
- `eza` (ls replacement) - File listing with icons
- `bat` (cat replacement) - Syntax highlighting
- `rg` (ripgrep) - Ultra-fast grep
- `fd` (find replacement) - Intuitive file finder
- `zoxide` - Smart cd with frecency
- `fzf` - Fuzzy finder
- `btop` - System monitor
- `lazygit` - Git TUI
- `delta` - Better git diffs
- `yq/jq` - YAML/JSON processors
- `glow` - Markdown renderer

### 🎨 Shell & Terminal
- **Zsh** with Starship prompt
- **Zellij** terminal multiplexer
- **Nerd Fonts** (JetBrains Mono, Fira Code)
- **Tokyo Night** theme

---

## 🚀 Quick Start

> **📖 Full installation guide:** See [INSTALL.md](INSTALL.md) for complete instructions

### One-line install
```bash
git clone https://github.com/ikarys/warp-shell.git ~/warp-shell
cd ~/warp-shell
./bootstrap.sh --quick
```

### Interactive install
```bash
./bootstrap.sh
# Choose: Quick / Full / Custom
```

### Using Just (recommended)
```bash
# Install Just first (included in base setup)
cargo install just

# Then use commands:
just bootstrap-all      # Full installation
just bootstrap-quick    # Quick setup (base + shell + rust)
just --list            # Show all available commands
```

---

## 📁 Project Structure

```
warp-shell/
├── bootstrap/              # Modular installation scripts
│   ├── base.sh            # Base packages & CLI tools
│   ├── shell.sh           # Zsh, Starship, Zellij
│   ├── rust.sh            # Rust toolchain
│   ├── python.sh          # Python (pyenv, poetry)
│   ├── nodejs.sh          # Node.js (nvm, pnpm)
│   ├── docker.sh          # Docker & lazydocker
│   ├── iac.sh             # Terraform, K8s tools
│   ├── utils.sh           # yq, jq, glow, httpie
│   ├── atuin.sh           # Advanced history
│   ├── ai.sh              # Ollama & AI models
│   ├── git-tools.sh       # Commitizen, pre-commit
│   └── visuals.sh         # Fonts & themes
│
├── dotfiles/              # Configuration files
│   ├── .zshrc             # Zsh configuration
│   ├── aliases.zsh        # Shell aliases
│   ├── starship.toml      # Starship prompt config
│   └── atuin/             # Atuin config
│
├── devcontainers/         # VS Code devcontainer templates
│   ├── python/
│   ├── nodejs/
│   ├── rust/
│   └── fullstack/
│
├── agents/                # AI agent scripts
│   ├── translator.sh      # Multi-language translator
│   ├── jira-ticket.sh     # Jira ticket generator
│   └── doc-generator.sh   # Code documentation generator
│
├── templates/             # Document templates
│   ├── jira-ticket.md
│   ├── adr-template.md
│   └── pre-commit-config.yaml
│
├── Justfile              # Command runner (replaces Makefile)
└── bootstrap.sh          # Main installation script
```

---

## 📦 Installation Options

### Full Installation (~20 min)
Installs everything: toolchains, docker, IaC, AI agents, utils
```bash
./bootstrap.sh --full
# OR
just bootstrap-all
```

### Quick Installation (~5 min)
Base packages + shell + rust tools
```bash
./bootstrap.sh --quick
# OR
just bootstrap-quick
```

### Component Installation
Install specific components:
```bash
just python      # Python toolchain
just nodejs      # Node.js toolchain
just docker      # Docker & tools
just iac         # Infrastructure tools
just ai          # AI/Ollama setup
just atuin       # Advanced history
just utils       # Utilities (jq, yq, etc)
just git-tools   # Git tools
just visuals     # Fonts & themes
```

---

## 🎯 Usage Examples

### Justfile Commands
```bash
# Development
just py-new myproject      # Create new Poetry project
just py-test              # Run Python tests
just node-dev             # Start Node dev server

# Docker
just docker-up            # Start containers
just docker-logs          # View logs

# Infrastructure
just tf-plan              # Terraform plan
just tg-apply             # Terragrunt apply
just k9s                  # Launch k9s

# AI Agents
just translate "Hello"    # Translate text
just jira-ticket "feat"   # Generate Jira ticket
just gen-doc "./file.py"  # Generate docs

# Maintenance
just update               # Update all packages
just info                 # Show system info
```

### AI Agents
```bash
# Translate text (auto-detects language)
./agents/translator.sh "Bonjour le monde"

# Generate Jira ticket
./agents/jira-ticket.sh "Add user authentication"

# Generate documentation
./agents/doc-generator.sh ./src/main.py
```

---

## 🔧 Customization

### Aliases
Edit `dotfiles/aliases.zsh` - optimized to NOT break scripts:
- ✅ `ls`, `ll`, `la` → `eza` (safe)
- ❌ No `grep` → `rg` (use `rg` directly)
- ❌ No `find` → `fd` (use `fd` directly)

### Starship Prompt
Edit `dotfiles/starship.toml` to customize your prompt

### Devcontainers
Copy templates from `devcontainers/` to your projects:
```bash
cp -r devcontainers/python/.devcontainer.json myproject/
```

---

## 🤖 AI Agents Setup

After installation, configure Ollama:
```bash
# Models are auto-installed, but you can add more:
ollama pull codellama      # Code-focused model
ollama pull llama2         # General purpose
ollama list                # View installed models
```

Create custom agents in `agents/` using the templates.

---

## 🐳 Devcontainer Templates

Ready-to-use devcontainer configurations:

1. **Python**: Python 3.12, Poetry, Black, Ruff
2. **Node.js**: Node 20 LTS, pnpm, TypeScript, Biome
3. **Rust**: Latest Rust, rust-analyzer, clippy
4. **Fullstack**: Python + Node + Docker + PostgreSQL + Redis

Copy to your project:
```bash
cp devcontainers/python/.devcontainer.json .devcontainer/
```

---

## 🔄 Multi-Machine Setup

Clone on any new machine:
```bash
git clone https://github.com/ikarys/warp-shell.git ~/warp-shell
cd ~/warp-shell
./bootstrap.sh --full
```

All your tools, configs, and aliases are instantly available!

---

## ⚠️ GitHub Rate Limit

**If you see rate limit errors:**
```
Error: you are rate-limited by GitHub
```

**Solution:** Create a free GitHub token (takes 2 min):
1. Visit https://github.com/settings/tokens
2. Generate new token (classic) - **no scopes needed**
3. Export it:
   ```bash
   export GITHUB_TOKEN=ghp_your_token_here
   export TENV_GITHUB_TOKEN=ghp_your_token_here
   ```

See [docs/GITHUB_TOKEN.md](docs/GITHUB_TOKEN.md) for detailed instructions.

**Without token:** 60 API requests/hour
**With token:** 5,000 API requests/hour

---

## 📝 Next Steps After Installation

1. **Restart terminal** or `source ~/.zshrc`
2. **Configure Git**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```
3. **Setup Atuin sync** (optional):
   ```bash
   atuin register
   # OR
   atuin login
   ```
4. **Test AI agents**:
   ```bash
   ollama run dolphin-mistral "Hello!"
   ```

---

## 🛠️ Maintenance

### Update Everything
```bash
just update
```

### Clean Old Configs
```bash
just clean
```

---

## 📚 Documentation

- [Justfile Commands](Justfile) - All available commands
- [AI Agents](agents/) - Agent scripts
- [Templates](templates/) - Document templates
- [Devcontainers](devcontainers/) - Container configs

---

## 🤝 Contributing

Feel free to open issues or PRs to improve this setup!

---

## 📄 License

MIT License - Use freely!

---

## 🙏 Credits

Built with amazing open-source tools:
- [Starship](https://starship.rs)
- [Zellij](https://zellij.dev)
- [Ollama](https://ollama.ai)
- [Atuin](https://atuin.sh)
- And many more!

---

**Happy coding! 🚀**
