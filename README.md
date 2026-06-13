# Warp Shell

Modern, modular terminal environment optimised for productivity.
Designed for WSL (Ubuntu 22.04/24.04/26.04) but works on any Linux.

## What it installs

### Shell
- **Fish** — autosuggestions, syntax highlighting and completions built-in, zero plugins required
- **Tide** — native Fish prompt, async, configurable via `tide configure`

### Modern CLI tools

These tools coexist with their native equivalents — they don't replace them, they add to them.

| Native command | Installed tool | Command |
|---|---|---|
| `grep` | `ripgrep` | `rg` |
| `cat` | `bat` | `bat` |
| `ls` | `eza` | `eza` / `ll` / `l` / `lt` |
| `find` | `fd` | `fd` |
| `cd` | `zoxide` | `z` |
| `top` | `btop` | `btop` |
| — | `fzf` | `fzf` |
| — | `jq` + `yq` | `jq` / `yq` |

#### `rg` — ripgrep (grep, but fast and ergonomic)

```bash
grep -r "TODO" src/          # native
rg "TODO" src/               # rg: respects .gitignore, coloured, faster

grep -rn "func " --include="*.go"
rg "func " -t go             # rg: built-in file type filtering

grep -rl "pattern" .         # list matching files
rg -l "pattern"

rg "error" --ignore-case
rg "fn \w+" -t rust          # PCRE2 regex by default
```

#### `bat` — cat with syntax highlighting

```bash
cat main.go                  # native: plain text
bat main.go                  # bat: syntax colours, line numbers, header

bat -n main.go               # line numbers only, no decoration
bat --paging=never main.go   # behaves like cat, no pager
bat *.json                   # multiple files with separators
bat -l yaml config.txt       # force language when extension is misleading
```

#### `eza` — ls with Git awareness and icons

```bash
ls -la                       # native
ll                           # alias → eza -alh --git: size, perms, Git status

ls --tree                    # not native on Linux
lt                           # alias → eza --tree: full directory tree
eza --tree --level=2         # limit depth

eza -l --git-ignore          # respect .gitignore
eza -l --sort=modified       # sort by modification date
```

#### `fd` — find with a human-friendly syntax

```bash
find . -name "*.ts" -type f              # native
fd "\.ts$"                               # fd: ignores node_modules/.git by default

find . -name "*.log" -exec rm {} \;
fd "\.log$" --exec rm                    # fd: more readable

find . -mtime -7 -type f                 # files modified this week
fd --changed-within 7d

fd -e py -x black {}                     # run black on every .py file
```

#### `z` — zoxide (smart cd by frequency)

```bash
cd ~/workspace/warp-shell    # native: full path required
z warp                       # zoxide: jumps to the most frequent match for "warp"

cd -                         # native: previous directory
z -                          # same

zi                           # interactive mode with fzf to pick from known dirs
```

#### `btop` — interactive system monitor

```bash
top                          # native: sparse interface
btop                         # btop: CPU/RAM/network/disk graphs, click-to-sort, built-in kill
```

#### `fzf` — interactive fuzzy finder (no native equivalent)

```bash
# Fuzzy command history search (replaces Ctrl+R)
history | fzf

# Open a file interactively
vim $(fd -t f | fzf)

# Pipe a selection into another command
rg "TODO" -l | fzf | xargs bat
```

#### `jq` / `yq` — JSON and YAML processors

```bash
cat data.json | python3 -m json.tool     # native: basic reformatting
cat data.json | jq '.'                   # jq: reformatted + coloured

jq '.users[].name' data.json            # extract fields
jq 'select(.age > 18)' data.json        # filter

yq '.spec.containers[].image' pod.yaml  # same syntax as jq, for YAML
yq -i '.replicas = 3' deployment.yaml   # in-place edit
```

### Dev Tools
- **mise** — multi-language version manager (Python, Node, Rust, Terraform...)
- **lazygit** — Git TUI
- **lazydocker** — Docker TUI
- **delta** — improved git diff
- **pre-commit** — Git hooks

### Infra / Ops
- **kubectl** + **kubectx** + **kubens** — Kubernetes
- **k9s** — Kubernetes TUI
- **yq** — YAML processor (like jq for YAML)
- Terraform/Terragrunt via **mise**

### Terminal
- **Ghostty** — GPU-accelerated terminal with Fish integration and cyberpunk theme
- **Zellij** — terminal multiplexer with pre-configured layouts

### AI Tools
- **pi** (`@mariozechner/pi-coding-agent`) — terminal coding agent
- **Claude Code** (`@anthropic-ai/claude-code`) — Claude in the terminal

### Cyberpunk Theme
Neon palette (cyan `#00ffff` / magenta `#ff00ff` / yellow `#ffff00`) coordinated across Starship and Zellij.

---

## Installation

### Prerequisites
- Ubuntu 22.04 or 24.04 (WSL recommended)
- Internet connection
- sudo rights

### Full install
```bash
git clone https://github.com/ikarys/warp-shell.git
cd warp-shell
just install
```

### Modular install
```bash
just install-shell        # Fish + Starship
just install-cli-tools    # ripgrep, bat, eza, fzf, zoxide, btop...
just install-dev          # mise, lazygit, lazydocker, delta, pre-commit
just install-terminal     # Zellij
just install-ghostty      # Ghostty + cyberpunk theme
just install-infra        # kubectl, k9s, kubectx, yq
just install-ai-tools     # pi, Claude Code
just install-theme        # Cyberpunk theme
```

### Deploy dotfiles only
```bash
just deploy-dotfiles
```

---

## Quick Start

### Zellij Layouts
```bash
zj-dev    # dev layout
zj-ops    # ops layout
```

### Languages with mise
```bash
mise use -g python@latest
mise use -g node@lts
mise use -g terraform@latest
```

### Kubernetes
```bash
k9s             # Kubernetes TUI
kx              # switch context (kubectx)
kns             # switch namespace (kubens)
```

---

## Justfile commands

```bash
just --list           # All available commands
just install          # Full install
just deploy-dotfiles  # Deploy config.fish + starship.toml
just update           # Update all tools
just check            # System health check
just info             # Current install state
```

---

## Structure

```
warp-shell/
├── Justfile
├── install.sh
├── scripts/
│   ├── modules/
│   │   ├── 00-base.sh        # Base dependencies
│   │   ├── 10-shell.sh       # Fish + Starship
│   │   ├── 20-cli-tools.sh   # Modern CLI tools
│   │   ├── 30-dev.sh         # Dev tools
│   │   ├── 40-terminal.sh    # Zellij
│   │   ├── 50-infra.sh       # kubectl, k9s, yq
│   │   └── 60-ai-tools.sh    # pi, Claude Code
│   └── utils/
│       ├── colors.sh
│       └── checks.sh
├── dotfiles/
│   ├── config.fish           # Main Fish config
│   └── dot_config/
│       ├── starship.toml     # Cyberpunk prompt
│       └── zellij/           # Layouts and theme
└── themes/cyberpunk/
```

---

## Customisation

### Local aliases (unversioned)
```bash
echo 'alias myalias="command"' >> ~/.config/fish/local.fish
```

Fish automatically loads `~/.config/fish/local.fish` if it exists.

---

## License

MIT — do whatever you want with it.
