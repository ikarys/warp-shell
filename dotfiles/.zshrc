# Init completion
autoload -U compinit
compinit

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Editor
export EDITOR="nvim"

# Pager
export PAGER="bat"
alias cat="bat"

# Aliases
[[ -f "$HOME/aliases.zsh" ]] && source "$HOME/aliases.zsh"

# Remap common commands
alias ls="eza"
alias ll="eza -alh --git"
alias l="eza -lh"
alias tree="eza -T -alh --git --level=1"
alias update="sudo apt update && sudo apt upgrade -y"
alias grep="rg"

# Python virtualenv fix
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Homebrew (if installed)
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Rust (cargo)
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# FZF config with cyberpunk colors
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# Git delta config
export GIT_PAGER="delta"

# Starship prompt
eval "$(starship init zsh)"
