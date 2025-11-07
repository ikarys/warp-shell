#!/bin/bash
# Utils - Colors and output formatting

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Cyberpunk themed colors
NEON_CYAN='\033[38;5;51m'
NEON_MAGENTA='\033[38;5;201m'
NEON_YELLOW='\033[38;5;226m'

# Output functions
success() {
    echo -e "${GREEN}✓${NC} $1"
}

error() {
    echo -e "${RED}✗${NC} $1" >&2
}

warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

header() {
    echo -e "\n${NEON_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${NEON_MAGENTA}  $1${NC}"
    echo -e "${NEON_CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

step() {
    echo -e "${CYAN}▶${NC} $1"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ask yes/no question
ask_yes_no() {
    local question="$1"
    local default="${2:-y}"
    
    if [ "$default" = "y" ]; then
        prompt="[Y/n]"
    else
        prompt="[y/N]"
    fi
    
    echo -e -n "${CYAN}?${NC} $question $prompt: "
    read -r answer
    
    answer="${answer:-$default}"
    case "$answer" in
        [Yy]*) return 0 ;;
        *) return 1 ;;
    esac
}

# Export functions for use in other scripts
export -f success error warning info header step command_exists ask_yes_no
