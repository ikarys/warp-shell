# Git (with delta for better diffs)
alias gs="git status"
alias gl="git pull origin"
alias gp="git push origin"
alias gd="git diff"
alias ga="git add ."
alias gc='git commit -m'
alias glog="git log --oneline --graph --decorate --all"
alias lazygit="lazygit"
alias lg="lazygit"

# Modern CLI tools - use native commands (no aliases that break scripts)
# ls/ll/la aliases are ok (common pattern)
alias ls="eza --icons"
alias ll="eza -alh --git --icons"
alias l="eza -lh --icons"
alias la="eza -la --icons"
alias tree="eza -T -alh --git --icons --level=2"

# Don't alias grep/find/cat - use rg/fd/bat directly
# This prevents breaking scripts that expect standard grep/find syntax

# System & productivity 
alias update="sudo apt update && sudo apt upgrade -y"
alias c="clear"
alias reload="source ~/.zshrc"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Development tools
alias vim="nvim"
alias v="nvim"
alias zj="zellij"
alias bench="hyperfine"
alias info="macchina"
alias count="tokei"
alias gitinfo="onefetch"
alias help="tldr"

# CYBERPUNK VIBES 🚀
alias matrix="cmatrix -s -C cyan"
alias pipes="pipes.sh -t 2 -R"
alias neo="cmatrix"
# alias hacker="hollywood"  # Disabled - problematic on some systems

# Directories shortcuts
alias projects="cd ~/projects"
alias downloads="cd ~/Downloads"
alias docs="cd ~/Documents"

# Python virtualenv fix
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Better history search with fzf
alias h="history | fzf"
