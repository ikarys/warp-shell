# ~/.config/fish/config.fish
# Warp Shell - Fish Configuration

# ============================================
# PATH
# ============================================

fish_add_path ~/.local/bin
fish_add_path ~/bin
fish_add_path ~/.cargo/bin

# ============================================
# EDITOR
# ============================================

set -gx EDITOR code
set -gx VISUAL code

# ============================================
# MODERN CLI TOOLS
# ============================================

# fzf (requires >= 0.48.0 for --fish flag)
if command -q fzf
    if fzf --fish 2>/dev/null | source
    else
        echo "⚠️  fzf trop ancien pour Fish (< 0.48.0) — relance : just install-cli-tools"
    end
end

# zoxide (smart cd)
if command -q zoxide
    zoxide init fish | source
end

# mise (version manager)
if command -q mise
    mise activate fish | source
end

# ============================================
# ALIASES - Fichiers & Navigation
# ============================================

# Raccourcis eza (sans écraser ls/tree natifs)
alias ll='eza -alh --git'
alias l='eza -lh'
alias lt='eza --tree'

# ============================================
# ALIASES - Git
# ============================================

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias glg='git log --oneline --graph --decorate'
alias lg='lazygit'

# ============================================
# ALIASES - Docker
# ============================================

alias d='docker'
alias dc='docker compose'
alias ld='lazydocker'

# ============================================
# ALIASES - Kubernetes / Infra
# ============================================

alias k='kubectl'
alias kx='kubectx'
alias kns='kubens'

# ============================================
# ALIASES - Zellij
# ============================================

alias zj='zellij'
alias zj-dev='zellij --layout dev'
alias zj-ops='zellij --layout ops'

# ============================================
# ALIASES - Utilitaires
# ============================================

alias c='clear'
alias update='sudo apt update && sudo apt upgrade -y'
alias reload='source ~/.config/fish/config.fish'

# ============================================
# FUNCTIONS
# ============================================

# Créer un dossier et s'y déplacer
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

# Extraire n'importe quelle archive
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' : format non reconnu"
        end
    else
        echo "'$argv[1]' n'est pas un fichier valide"
    end
end

# ============================================
# LOCAL OVERRIDES (non versionné)
# ============================================

if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
