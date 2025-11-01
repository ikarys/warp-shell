# Installation Guide - New Machine Setup

## 🚀 Quick Install (One-liner)

```bash
git clone https://github.com/ikarys/warp-shell.git ~/warp-shell
cd ~/warp-shell
./bootstrap.sh
```

Choose your installation mode:
- **Quick**: Essential tools only (~5 min)
- **Full**: Everything (~20 min)
- **Custom**: Pick what you want

---

## 📋 Step-by-Step Install

### 1. Prerequisites

**WSL Ubuntu 22.04/24.04** with:
- Git
- Sudo access
- Internet connection

### 2. Clone the Repository

```bash
cd ~
git clone https://github.com/ikarys/warp-shell.git
cd warp-shell
```

### 3. Run Bootstrap

**Interactive mode** (recommended):
```bash
./bootstrap.sh
```

**Quick mode** (essentials only):
```bash
./bootstrap.sh --quick
```

**Full mode** (everything):
```bash
./bootstrap.sh --full
```

### 4. Restart Terminal

```bash
# Close and reopen your terminal
# OR
source ~/.zshrc
```

---

## ⚠️ GitHub Rate Limit (IMPORTANT!)

If you see this error during installation:
```
Error: you are rate-limited by GitHub
```

**Solution:** Create a GitHub token (takes 2 min):

1. Visit https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Name: `warp-shell-bootstrap`
4. **NO scopes needed** (leave all unchecked)
5. Click "Generate token"
6. Copy the token (starts with `ghp_`)
7. Export it:
   ```bash
   export GITHUB_TOKEN=ghp_your_token_here
   export TENV_GITHUB_TOKEN=ghp_your_token_here
   ```
8. Re-run the installation

**Why?** GitHub limits anonymous API requests to 60/hour. With a token: 5,000/hour.

See [docs/GITHUB_TOKEN.md](docs/GITHUB_TOKEN.md) for details.

---

## 🎯 What Gets Installed

### Quick Mode
- ✅ Base packages (eza, bat, rg, fd, fzf, zoxide)
- ✅ Rust toolchain + cargo tools
- ✅ Shell (zsh, starship, zellij)

### Full Mode (includes Quick +)
- ✅ Python (pyenv, poetry, pipx, black, ruff)
- ✅ Node.js (nvm, pnpm, typescript, biome)
- ✅ Docker (docker, compose, lazydocker)
- ✅ IaC (terraform, kubectl, helm, k9s)
- ✅ Utils (yq, jq, glow, httpie, xh)
- ✅ Atuin (advanced shell history)
- ✅ AI tools (Ollama + models)
- ✅ Git tools (commitizen, pre-commit)
- ✅ Fonts & themes

### Custom Mode
Pick individual components:
```bash
just python      # Python toolchain
just nodejs      # Node.js toolchain
just docker      # Docker
just iac         # IaC tools
just atuin       # Atuin
just ai          # AI/Ollama
just utils       # Utilities
```

---

## 🔧 Post-Installation

### 1. Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### 2. (Optional) Setup Atuin Sync
```bash
# Create account
atuin register

# OR login if you have an account
atuin login
```

### 3. Test Your Setup
```bash
# Check installed tools
just --list
just info

# Test CLI tools
ll                    # eza
bat README.md         # bat with syntax
rg "pattern"          # ripgrep
fd "file"             # fd find

# Test Git tools
lazygit               # Git TUI
```

---

## 📦 Installing on Multiple Machines

### First Machine
```bash
cd ~/warp-shell
./bootstrap.sh --full

# Make your customizations
# Edit dotfiles, add aliases, etc.

# Commit your changes
git add .
git commit -m "feat: personalize config"
git push
```

### Other Machines
```bash
# Clone YOUR fork
git clone https://github.com/YOUR_USERNAME/warp-shell.git ~/warp-shell
cd ~/warp-shell

# Install with your customizations
./bootstrap.sh --full
```

All your configs and tools will be instantly available! 🎉

---

## 🐛 Troubleshooting

### Rate Limit Errors
→ Create GitHub token (see above)

### Command not found after install
→ Restart your terminal or `source ~/.zshrc`

### Permission denied
→ Some tools need `sudo`. Make sure you have sudo access.

### Docker group error
→ After Docker install: `newgrp docker` or logout/login

### Python/Node tools not found
→ Restart terminal to load pyenv/nvm paths

---

## 📚 Further Customization

### Dotfiles
Edit these files and commit:
- `dotfiles/.zshrc` - Shell config
- `dotfiles/aliases.zsh` - Your aliases
- `dotfiles/starship.toml` - Prompt config

### Justfile Commands
Add your own commands to `Justfile`

### AI Agents
Create custom agents in `agents/` directory

### Templates
Add your templates to `templates/` directory

---

## 🆘 Getting Help

- **Documentation**: [README.md](README.md)
- **Migration Guide**: [MIGRATION.md](MIGRATION.md)
- **GitHub Token**: [docs/GITHUB_TOKEN.md](docs/GITHUB_TOKEN.md)
- **Issues**: https://github.com/ikarys/warp-shell/issues

---

**Happy coding! 🚀**
