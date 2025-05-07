# Git
alias gs="git status"
alias gl="git pull origin"
alias gp="git push origin"
alias gd="git diff"
alias ga="git add ."
alias gc='git commit -m'

# Remap common commands
alias ls="eza"
alias ll="eza -alh --git"
alias l="eza -lh"
alias tree="eza -T -alh --git --level=1"
alias update="sudo apt update && sudo apt upgrade -y"
alias grep="rg"
alias c="clear"
alias top="btop"

# Autres
alias vim="nvim"
alias v="nvim"
alias zj="zellij"

# Python virtualenv fix
export VIRTUAL_ENV_DISABLE_PROMPT=1
