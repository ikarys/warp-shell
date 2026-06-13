# AGENTS.md — Warp Shell

## What this repo does

**Warp Shell** is a modern terminal environment bootstrap for Linux (Ubuntu 22.04/24.04) and WSL.
It automates the installation and configuration of a complete stack: shell, CLI tools, dev tools, Docker, Kubernetes, terminal multiplexer, and AI tools.

There is no application to run — this is an **idempotent installation tool** driven by `just`.

---

## Architecture

```
warp-shell/
├── Justfile                   # Task runner (just install, just check, etc.)
├── install.sh                 # Interactive installer — rarely used directly
├── scripts/
│   ├── modules/               # One bash script = one tool group
│   │   ├── 00-base.sh         # apt essentials + broken PPA cleanup
│   │   ├── 10-shell.sh        # Fish + Tide (native Fish prompt)
│   │   ├── 20-cli-tools.sh    # rg, fd, fzf, bat, eza, zoxide, btop, jq, yq
│   │   ├── 30-dev.sh          # mise, lazygit, lazydocker, delta, pre-commit
│   │   ├── 35-docker.sh       # Docker CE via official repo
│   │   ├── 40-terminal.sh     # Zellij
│   │   ├── 50-infra.sh        # kubectl, kubectx, kubens, k9s, yq
│   │   └── 60-ai-tools.sh     # pi (@mariozechner/pi-coding-agent), Claude Code
│   └── utils/
│       ├── colors.sh          # Output functions + cyberpunk palette
│       └── checks.sh          # Post-install health check (just check)
├── dotfiles/
│   ├── config.fish            # Main Fish config (aliases, PATH, integrations)
│   └── dot_config/
│       └── zellij/            # Zellij config (cyberpunk theme, keybindings)
└── themes/cyberpunk/          # Neon cyan/magenta/yellow palette for Starship + Zellij
```

---

## Code conventions

### Bash modules
- **Always source** `scripts/utils/colors.sh` at the top of each module
- **Idempotent**: check `command_exists` before installing (`if ! command_exists foo; then`)
- **Output order**: `header` → `step` → `success`/`warning`/`error`
- Binaries installed via `sudo install /tmp/foo /usr/local/bin/foo` then `/tmp` cleanup
- Versions fetched from the GitHub releases API when possible:
  ```bash
  VERSION=$(curl -s ".../releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  ```

### Available utility functions (`colors.sh`)
```bash
header "Section title"      # Cyan/magenta cyberpunk banner
step "Action in progress..."  # ▶ action
success "Done"              # ✓ green
warning "Warning"           # ⚠ yellow
error "Error"               # ✗ red (stderr)
info "Info"                 # ℹ blue
command_exists foo          # returns 0 if installed
ask_yes_no "Question?" "y"  # interactive Y/n prompt
```

---

## Known constraints

| Constraint | Detail |
|---|---|
| **Broken Fish PPA** | The `fish-shell/release-3` PPA is unavailable on Ubuntu 26.04+. `00-base.sh` purges it automatically if unreachable. Always try `apt-cache show fish` first. |
| **fzf ≥ 0.48.0** | Required for the `--fish` flag. `20-cli-tools.sh` downloads the binary from GitHub if the apt version is too old. `config.fish` shows a warning if the version is too old. |
| **Node.js required for AI tools** | `60-ai-tools.sh` installs Node via `mise` if absent before calling `npm install -g`. |
| **WSL / wl-copy** | `config.zellij` uses `wl-copy` for clipboard. Only works with a Wayland or XWayland server. |

---

## Useful commands

```bash
just install           # Full install (all modules in order)
just install-<module>  # Single module: shell, cli-tools, dev, docker, terminal, infra, ai-tools, theme
just deploy-dotfiles   # Copy config.fish → ~/.config/fish/config.fish
just check             # Health check for all tools (scripts/utils/checks.sh)
just info              # Show installed versions
just update            # mise upgrade + npm update -g (pi + claude)
```

---

## Adding a new module

1. Create `scripts/modules/NN-name.sh` following this pattern:
   ```bash
   #!/bin/bash
   set -e
   SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
   source "$SCRIPT_DIR/../utils/colors.sh"
   header "Title"
   if ! command_exists foo; then
       step "Installing foo..."
       # ...
       success "foo installed"
   else
       info "foo already installed"
   fi
   ```
2. Add a recipe to `Justfile`:
   ```makefile
   install-name:
       @echo "... Installing foo..."
       @bash scripts/modules/NN-name.sh
   ```
3. Add it to the `install:` recipe dependencies (in order).
4. Add a corresponding `check_cmd` in `scripts/utils/checks.sh`.

---

## Dotfiles

- `dotfiles/config.fish` → deployed to `~/.config/fish/config.fish` via `just deploy-dotfiles`
- Local unversioned aliases: `~/.config/fish/local.fish` (auto-loaded by config.fish)
- Zellij theme: `themes/cyberpunk/zellij-theme.kdl` + `themes/cyberpunk/starship.toml`

---

## Installed stack summary

| Category | Tools |
|---|---|
| Shell | Fish + Tide |
| Modern CLI | rg, bat, eza, fzf, fd, zoxide, btop, jq, yq |
| Dev | mise, lazygit, lazydocker, delta, pre-commit, git |
| Docker | Docker CE + Compose plugin |
| Terminal | Zellij |
| Infra | kubectl, kubectx, kubens, k9s |
| AI | pi, Claude Code |
| Theme | Cyberpunk (cyan `#00ffff` / magenta `#ff00ff` / yellow `#ffff00`) |
