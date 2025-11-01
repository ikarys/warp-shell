#!/bin/bash
# Warp Shell - Modern Development Environment Bootstrap
# WSL Ubuntu optimized setup

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}"
cat << "EOF"
 ╦ ╦╔═╗╦═╗╔═╗  ╔═╗╦ ╦╔═╗╦  ╦
 ║║║╠═╣╠╦╝╠═╝  ╚═╗╠═╣║╣ ║  ║
 ╚╩╝╩ ╩╩╚═╩    ╚═╝╩ ╩╚═╝╩═╝╩═╝
 Modern Dev Environment Bootstrap
EOF
echo -e "${NC}"

# Interactive mode
if [ "$1" != "-y" ] && [ "$1" != "--quick" ] && [ "$1" != "--full" ]; then
  echo -e "${YELLOW}Choose installation mode:${NC}"
  echo "1) Quick (base + shell + rust) - ~5 min"
  echo "2) Full (everything) - ~20 min"
  echo "3) Custom (pick components)"
  read -p "Choice [1-3]: " choice
else
  if [ "$1" == "--quick" ]; then
    choice=1
  elif [ "$1" == "--full" ]; then
    choice=2
  fi
fi

case $choice in
  1)
    echo -e "${GREEN}🚀 Quick installation...${NC}"
    bash bootstrap/base.sh
    bash bootstrap/rust.sh
    bash bootstrap/shell.sh
    ;;
  2)
    echo -e "${GREEN}🚀 Full installation...${NC}"
    bash bootstrap/base.sh
    bash bootstrap/rust.sh
    bash bootstrap/shell.sh
    bash bootstrap/python.sh
    bash bootstrap/nodejs.sh
    bash bootstrap/docker.sh
    bash bootstrap/iac.sh
    bash bootstrap/utils.sh
    bash bootstrap/atuin.sh
    bash bootstrap/ai.sh
    bash bootstrap/git-tools.sh
    bash bootstrap/visuals.sh
    ;;
  3)
    echo -e "${YELLOW}Select components to install:${NC}"
    components=("base" "rust" "shell" "python" "nodejs" "docker" "iac" "utils" "atuin" "ai" "git-tools" "visuals")
    for comp in "${components[@]}"; do
      read -p "Install $comp? [y/N] " install
      if [[ $install =~ ^[Yy]$ ]]; then
        bash "bootstrap/${comp}.sh"
      fi
    done
    ;;
esac

echo ""
echo -e "${GREEN}✅ Installation complete!${NC}"
echo ""
echo -e "${YELLOW}📝 Next steps:${NC}"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Check available commands: just --list"
echo "3. Configure git: git config --global user.name 'Your Name'"
echo "4.                git config --global user.email 'your@email.com'"
echo ""
echo -e "${BLUE}💡 Useful commands:${NC}"
echo "  just bootstrap-all  - Install all components"
echo "  just info          - Show system info"
echo "  just update        - Update all tools"
echo ""
echo "🎉 Happy coding!"
