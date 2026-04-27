#!/bin/bash
# Module 60 - AI Tools (pi, Claude Code)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation des outils IA"

# Ensure Node.js is available (via mise)
if ! command_exists node; then
    warning "Node.js non trouvé. Installation via mise..."
    export PATH="$HOME/.local/bin:$PATH"
    mise use -g node@lts
    eval "$(mise activate bash)"
fi

# pi (pi.dev coding agent)
if ! command_exists pi; then
    step "Installation de pi..."
    npm install -g @mariozechner/pi-coding-agent
    success "pi installé"
else
    info "pi déjà installé ($(pi --version 2>/dev/null || echo 'version inconnue'))"
fi

# Claude Code
if ! command_exists claude; then
    step "Installation de Claude Code..."
    npm install -g @anthropic-ai/claude-code
    success "Claude Code installé"
else
    info "Claude Code déjà installé"
fi

success "Module AI tools installé avec succès"
info "Configure tes clés API :"
info "  Claude : export ANTHROPIC_API_KEY='sk-...'"
info "  pi     : pi config (ou voir ~/.pi/)"
