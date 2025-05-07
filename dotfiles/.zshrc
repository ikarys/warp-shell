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

# FZF config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship prompt
eval "$(starship init zsh)"
