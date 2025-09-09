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

# Modern CLI replacements (FAST & EFFICIENT)
alias ls="eza --icons"
alias ll="eza -alh --git --icons"
alias l="eza -lh --icons"
alias la="eza -la --icons"
alias tree="eza -T -alh --git --icons --level=2"
alias grep="rg"
alias find="fd"
alias du="dust"
alias df="duf"
alias ps="procs"
alias top="btop"
alias cat="bat --style=numbers,changes,header"

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
alias hacker="hollywood"
alias neo="cmatrix"

# Directories shortcuts
alias projects="cd ~/projects"
alias downloads="cd ~/Downloads"
alias docs="cd ~/Documents"

# Python virtualenv fix
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Better history search with fzf
alias h="history | fzf"
