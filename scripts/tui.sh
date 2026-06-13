#!/usr/bin/env bash
# Warp Shell TUI — Interactive module selector powered by gum

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils/colors.sh"

# ── Bootstrap gum ─────────────────────────────────────────────────────────────
if ! command_exists gum; then
    step "Installing gum (TUI engine)..."
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key \
        | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
        | sudo tee /etc/apt/sources.list.d/charm.list >/dev/null
    sudo apt-get update -qq && sudo apt-get install -y gum
    success "gum $(gum --version 2>/dev/null | head -1) ready"
fi

# ── Module registry (install order is preserved) ───────────────────────────────
MODULE_KEYS=(base shell cli dev docker terminal ghostty infra ai)

declare -A MODULE_LABELS=(
    [base]="Base dependencies"
    [shell]="Fish + Tide"
    [cli]="Modern CLI tools"
    [dev]="Dev tools"
    [docker]="Docker"
    [terminal]="Zellij"
    [ghostty]="Ghostty terminal"
    [infra]="Infra / Ops"
    [ai]="AI tools"
)

declare -A MODULE_DESCS=(
    [base]="curl, wget, build-essential, apt keys"
    [shell]="Fish v4, Tide async prompt"
    [cli]="ripgrep, bat, eza, fd, fzf, zoxide, btop, jq"
    [dev]="mise, lazygit, lazydocker, delta, pre-commit"
    [docker]="Docker CE + compose plugin"
    [terminal]="terminal multiplexer + cyberpunk layouts"
    [ghostty]="GPU-accelerated terminal + cyberpunk theme"
    [infra]="kubectl, k9s, kubectx, kubens, yq"
    [ai]="Claude Code, pi coding agent"
)

declare -A MODULE_SCRIPTS=(
    [base]="$SCRIPT_DIR/modules/00-base.sh"
    [shell]="$SCRIPT_DIR/modules/10-shell.sh"
    [cli]="$SCRIPT_DIR/modules/20-cli-tools.sh"
    [dev]="$SCRIPT_DIR/modules/30-dev.sh"
    [docker]="$SCRIPT_DIR/modules/35-docker.sh"
    [terminal]="$SCRIPT_DIR/modules/40-terminal.sh"
    [ghostty]="$SCRIPT_DIR/modules/45-ghostty.sh"
    [infra]="$SCRIPT_DIR/modules/50-infra.sh"
    [ai]="$SCRIPT_DIR/modules/60-ai-tools.sh"
)

# ── Banner ─────────────────────────────────────────────────────────────────────
clear
gum style \
    --border double \
    --border-foreground 51 \
    --foreground 201 \
    --bold \
    --align center \
    --width 52 \
    --padding "1 4" \
    "⚡  WARP SHELL  ⚡" \
    "   Module Installer"
echo ""

# ── Build display list ─────────────────────────────────────────────────────────
DISPLAY_LIST=()
for key in "${MODULE_KEYS[@]}"; do
    DISPLAY_LIST+=("$(printf '[%-8s]  %-20s  %s' "$key" "${MODULE_LABELS[$key]}" "${MODULE_DESCS[$key]}")")
done

# ── Multi-select ───────────────────────────────────────────────────────────────
gum style --foreground 51 "Select modules to install  (↑↓ move · x toggle · enter confirm):"
echo ""

SELECTED=$(gum choose --no-limit \
    --height 12 \
    --cursor.foreground 201 \
    --selected.foreground 226 \
    --selected-prefix "◉ " \
    --unselected-prefix "○ " \
    "${DISPLAY_LIST[@]}") || true

if [ -z "$SELECTED" ]; then
    warning "Nothing selected. Exiting."
    exit 0
fi

# ── Resolve to ordered list ────────────────────────────────────────────────────
# Iterate MODULE_KEYS to preserve install order regardless of selection order
TO_RUN=()
for key in "${MODULE_KEYS[@]}"; do
    if echo "$SELECTED" | grep -q "\[$key"; then
        TO_RUN+=("$key")
    fi
done

# ── Confirm ────────────────────────────────────────────────────────────────────
echo ""
gum style --foreground 51 --bold "Modules to install:"
for key in "${TO_RUN[@]}"; do
    echo "  ◉  $(gum style --foreground 226 "${MODULE_LABELS[$key]}")  — ${MODULE_DESCS[$key]}"
done
echo ""

gum confirm "Proceed with installation?" || { info "Cancelled."; exit 0; }

# ── Run modules ────────────────────────────────────────────────────────────────
echo ""
FAILED=()

for key in "${TO_RUN[@]}"; do
    script="${MODULE_SCRIPTS[$key]}"
    label="${MODULE_LABELS[$key]}"

    echo ""
    gum style --foreground 51 --bold "▶  $label"
    echo -e "${NEON_CYAN}──────────────────────────────────────────────────${NC}"

    if bash "$script"; then
        gum style --foreground 82 "✓  $label complete"
    else
        gum style --foreground 196 "✗  $label failed"
        FAILED+=("$label")
    fi
done

# ── Summary ────────────────────────────────────────────────────────────────────
echo ""
TOTAL=${#TO_RUN[@]}
PASS=$(( TOTAL - ${#FAILED[@]} ))

if [ ${#FAILED[@]} -eq 0 ]; then
    gum style \
        --border rounded \
        --border-foreground 82 \
        --foreground 82 \
        --bold \
        --align center \
        --width 50 \
        --padding "1 4" \
        "✓  All $TOTAL modules installed!" \
        "" \
        "Restart your shell:" \
        "exec fish"
else
    gum style \
        --border rounded \
        --border-foreground 196 \
        --foreground 196 \
        --align center \
        --width 50 \
        --padding "1 4" \
        "$PASS / $TOTAL modules succeeded" \
        "Failed: ${FAILED[*]}" \
        "" \
        "Run: just check"
fi
