# Migration Guide - Warp Shell v2.0

## 🎯 What Changed

This is a major upgrade from a simple dotfiles repo to a **full-featured development environment**.

### Architecture Changes

**Before:**
```
warp-shell/
├── scripts/           # Monolithic install scripts
├── dotfiles/          # Basic configs
├── Makefile          # Simple build commands
└── README.md
```

**After:**
```
warp-shell/
├── bootstrap/         # Modular install scripts (12 components)
├── dotfiles/          # Enhanced configs
├── devcontainers/     # VS Code devcontainer templates (4 stacks)
├── agents/            # AI agent scripts (3 agents)
├── templates/         # Document templates
├── justfiles/         # (reserved for future modules)
├── Justfile          # Advanced command runner
└── README.md         # Complete documentation
```

## 📦 New Features

### Development Toolchains
- ✅ **Python**: pyenv, poetry, pipx, black, ruff, pytest, ipython
- ✅ **Node.js**: nvm, pnpm, yarn, typescript, tsx, biome, prettier
- ✅ **Rust**: Enhanced with more cargo tools
- ✅ **Docker**: docker, docker-compose, lazydocker
- ✅ **IaC**: terraform (tfenv), opentofu, terragrunt (tenv), kubectl, helm, k9s, kustomize
- ✅ **Git Tools**: commitizen, pre-commit, enhanced git config

### Productivity Tools
- ✅ **Atuin**: Advanced shell history with sync
- ✅ **Ollama**: Local AI with dolphin-mistral & mistral models
- ✅ **Utils**: yq, jq, glow, mdcat, fx, httpie, xh

### AI Agents
- ✅ Translator (French ↔ English)
- ✅ Jira ticket generator
- ✅ Documentation generator

### Devcontainers
- ✅ Python (3.12 + Poetry + tools)
- ✅ Node.js (20 LTS + pnpm)
- ✅ Rust (latest + analyzer)
- ✅ Fullstack (Python + Node + Docker + PostgreSQL + Redis)

### Templates
- ✅ Jira ticket template
- ✅ ADR (Architecture Decision Record) template
- ✅ Pre-commit hooks config

## 🔧 Breaking Changes

### Aliases Modified
**Removed problematic aliases that break scripts:**
- ❌ `alias grep="rg"` → Use `rg` directly
- ❌ `alias find="fd"` → Use `fd` directly
- ❌ `alias cat="bat"` → Use `bat` directly
- ✅ Kept safe aliases: `ls`, `ll`, `la`, `tree` → `eza`

**Reason:** These aliases caused issues with scripts expecting standard GNU tools.

### Installation Method
**Before:**
```bash
make bootstrap
```

**After:**
```bash
./bootstrap.sh              # Interactive
./bootstrap.sh --quick     # Quick install
./bootstrap.sh --full      # Full install

# OR with Just
just bootstrap-all
just bootstrap-quick
```

### Configuration Loading
**Before:**
- `.zshrc` contained duplicated aliases
- No central command runner

**After:**
- `.zshrc` sources `aliases.zsh` (single source of truth)
- `Justfile` provides centralized commands
- Modular bootstrap scripts

## 🚀 Migration Steps for Existing Users

### 1. Backup Current Setup
```bash
cp ~/.zshrc ~/.zshrc.backup
cp ~/aliases.zsh ~/aliases.zsh.backup
```

### 2. Pull Latest Changes
```bash
cd ~/warp-shell
git pull origin main
```

### 3. Choose Installation Mode

**Option A: Quick (recommended for testing)**
```bash
./bootstrap.sh --quick
```

**Option B: Full (all features)**
```bash
./bootstrap.sh --full
```

**Option C: Custom (pick components)**
```bash
just python      # Install Python toolchain
just nodejs      # Install Node.js toolchain
just ai          # Install Ollama + agents
# etc...
```

### 4. Review Alias Changes
Check your scripts for usage of:
- `grep` → Replace with `rg` if using ripgrep features
- `find` → Replace with `fd` if needed
- `cat` → Use `bat` explicitly if you want syntax highlighting

### 5. Restart Terminal
```bash
source ~/.zshrc
# OR restart your terminal
```

## 🆕 New Commands (Just)

```bash
# Show all commands
just --list

# Development
just py-new myproject
just py-test
just node-dev

# Docker
just docker-up
just docker-logs

# Infrastructure
just tf-plan
just k9s

# AI Agents
just translate "Bonjour"
just jira-ticket "Add feature X"
just gen-doc "./file.py"

# Maintenance
just update
just info
```

## 📝 What to Test

After migration, verify:
1. ✅ Shell loads without errors: `source ~/.zshrc`
2. ✅ Aliases work: `ll`, `ls`, `la`
3. ✅ Git tools: `git status`, `lazygit`
4. ✅ Modern tools: `rg`, `fd`, `bat`, `eza`
5. ✅ Just commands: `just --list`
6. ✅ Python (if installed): `python --version`, `poetry --version`
7. ✅ Node (if installed): `node --version`, `pnpm --version`
8. ✅ Docker (if installed): `docker --version`, `lazydocker`
9. ✅ AI (if installed): `ollama list`
10. ✅ Atuin (if installed): `atuin search`

## ❓ FAQ

### Q: Can I keep my old setup?
**A:** Yes! The old `scripts/` directory is still there. New bootstrap scripts are in `bootstrap/`.

### Q: Do I need to install everything?
**A:** No! Use custom mode or individual `just` commands to pick only what you need.

### Q: Will this break my existing projects?
**A:** No. The alias changes only affect new shell sessions. Existing scripts are unaffected.

### Q: Can I roll back?
**A:** Yes! Restore your backup:
```bash
cp ~/.zshrc.backup ~/.zshrc
cp ~/aliases.zsh.backup ~/aliases.zsh
source ~/.zshrc
```

### Q: Where are the old scripts?
**A:** Still in `scripts/` directory. Not deleted, just not used by new `bootstrap.sh`.

## 🐛 Troubleshooting

### Aliases not working
```bash
source ~/aliases.zsh
```

### Just command not found
```bash
cargo install just
```

### Python tools not found
```bash
source ~/.zshrc  # Reload pyenv/poetry paths
```

### Ollama models not loading
```bash
ollama serve &  # Start Ollama service
ollama pull dolphin-mistral
```

## 📚 Resources

- [Main README](README.md) - Full documentation
- [Justfile](Justfile) - All available commands
- [Bootstrap Scripts](bootstrap/) - Individual component installers
- [AI Agents](agents/) - Agent scripts
- [Templates](templates/) - Document templates

---

**Need help?** Open an issue on GitHub!
