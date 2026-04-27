#!/bin/bash
# Utils - Post-install health check

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

PASS=0
FAIL=0
WARN=0

check_ok()  { success "$1"; ((PASS++)); }
check_fail(){ error   "$1"; ((FAIL++)); }
check_warn(){ warning "$1"; ((WARN++)); }

check_cmd() {
    local name="$1"
    local cmd="${2:-$1}"
    local version_flag="${3:---version}"
    if command -v "$cmd" >/dev/null 2>&1; then
        local ver
        ver=$("$cmd" $version_flag 2>&1 | head -1 | tr -d '\n')
        check_ok "$name: $ver"
    else
        check_fail "$name: non installé"
    fi
}

# ============================================
header "🐚 Shell"
# ============================================

check_cmd "fish" fish "--version"

if command -v fish >/dev/null 2>&1; then
    if fish -c "functions tide" >/dev/null 2>&1; then
        check_ok "tide: installé"
    else
        check_fail "tide: non installé (lance just install-shell)"
    fi

    if fish -c "functions fisher" >/dev/null 2>&1; then
        check_ok "fisher: installé"
    else
        check_warn "fisher: non installé"
    fi
fi

if [ -f ~/.config/fish/config.fish ]; then
    check_ok "config.fish: présent"
else
    check_fail "config.fish: absent (lance just deploy-dotfiles)"
fi

# ============================================
header "🔧 CLI Tools"
# ============================================

check_cmd "ripgrep (rg)"  rg  "--version"
check_cmd "bat"           bat "--version"
check_cmd "eza"           eza "--version"
check_cmd "fzf"           fzf "--version"
check_cmd "zoxide"        zoxide "--version"
check_cmd "btop"          btop "--version"
check_cmd "jq"            jq  "--version"

# fd (Ubuntu package = fdfind)
if command -v fd >/dev/null 2>&1; then
    check_ok "fd: $(fd --version 2>&1 | head -1)"
elif command -v fdfind >/dev/null 2>&1; then
    check_warn "fd: disponible via fdfind (symlink manquant ?)"
else
    check_fail "fd: non installé"
fi

# fzf version >= 0.48.0
if command -v fzf >/dev/null 2>&1; then
    FZF_VER=$(fzf --version | grep -oP '^[0-9.]+')
    if [ "$(printf '%s\n' "0.48.0" "$FZF_VER" | sort -V | head -1)" = "0.48.0" ]; then
        check_ok "fzf >= 0.48.0 (fish compatible)"
    else
        check_warn "fzf $FZF_VER < 0.48.0 — lance: just install-cli-tools"
    fi
fi

# ============================================
header "💻 Dev Tools"
# ============================================

check_cmd "mise"       mise    "--version"
check_cmd "lazygit"    lazygit "--version"
check_cmd "lazydocker" lazydocker "--version"
check_cmd "delta"      delta   "--version"
check_cmd "pre-commit" pre-commit "--version"
check_cmd "git"        git     "--version"

# git delta config
if git config --global core.pager 2>/dev/null | grep -q delta; then
    check_ok "git: configuré avec delta"
else
    check_warn "git: delta non configuré comme pager (lance just install-dev)"
fi

# ============================================
header "🐳 Docker"
# ============================================

check_cmd "docker" docker "--version"

if command -v docker >/dev/null 2>&1; then
    if docker info >/dev/null 2>&1; then
        check_ok "docker daemon: actif"
    else
        check_warn "docker daemon: inactif (sudo service docker start)"
    fi

    if docker compose version >/dev/null 2>&1; then
        check_ok "docker compose: $(docker compose version --short 2>/dev/null)"
    else
        check_fail "docker compose: plugin manquant"
    fi
fi

# ============================================
header "🖥️  Terminal"
# ============================================

check_cmd "zellij" zellij "--version"

if [ -d ~/.config/zellij ]; then
    check_ok "zellij config: présente"
else
    check_warn "zellij config: absente (~/.config/zellij)"
fi

# ============================================
header "🏗️  Infra"
# ============================================

check_cmd "kubectl"  kubectl "version --client"
check_cmd "kubectx"  kubectx "--version"
check_cmd "kubens"   kubens  "--version"
check_cmd "k9s"      k9s     "version --short"
check_cmd "yq"       yq      "--version"

# ============================================
header "🤖 AI Tools"
# ============================================

check_cmd "pi"     pi     "--version"
check_cmd "claude" claude "--version"

# node requis pour pi + claude
check_cmd "node" node "--version"
check_cmd "npm"  npm  "--version"

# ============================================
header "📊 Résultat"
# ============================================

echo ""
echo -e "  ${GREEN}✅ OK     : $PASS${NC}"
[ $WARN -gt 0 ] && echo -e "  ${YELLOW}⚠️  Warning : $WARN${NC}"
[ $FAIL -gt 0 ] && echo -e "  ${RED}❌ Manquant: $FAIL${NC}"
echo ""

if [ $FAIL -eq 0 ]; then
    success "Tout est installé 🎉"
else
    error "$FAIL outil(s) manquant(s) — voir ci-dessus"
    exit 1
fi
