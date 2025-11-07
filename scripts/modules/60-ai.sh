#!/bin/bash
# Module 60 - Ollama and AI agents

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installing Ollama and AI agents"

# Install Ollama
if ! command_exists ollama; then
    step "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh
    success "Ollama installed"
else
    info "Ollama already installed"
fi

# Start Ollama service
step "Starting Ollama service..."
if pgrep -x ollama > /dev/null; then
    info "Ollama service already running"
else
    ollama serve > /dev/null 2>&1 &
    sleep 2
    success "Ollama service started"
fi

# Configure machine type and models
MACHINE_TYPE="${1:-prompt}"
CONFIG_DIR="$HOME/.config/warp-shell"
CONFIG_FILE="$CONFIG_DIR/machine.conf"

mkdir -p "$CONFIG_DIR"

if [ "$MACHINE_TYPE" = "prompt" ]; then
    echo ""
    echo "Machine type configuration:"
    echo "1) Laptop (light models - 3B/7B, ~6GB total)"
    echo "2) Desktop (optimized models - 7B, ~4GB total)"
    echo ""
    echo -n "Choice [1/2]: "
    read -r choice
    
    case "$choice" in
        1)
            MACHINE_TYPE="laptop"
            ;;
        2)
            MACHINE_TYPE="desktop"
            ;;
        *)
            error "Invalid choice"
            exit 1
            ;;
    esac
fi

# Write machine config
cat > "$CONFIG_FILE" <<EOF
# Warp Shell - Machine Configuration
MACHINE_TYPE=$MACHINE_TYPE
EOF

if [ "$MACHINE_TYPE" = "laptop" ]; then
    cat >> "$CONFIG_FILE" <<EOF
AI_MODEL_DEFAULT=llama3.2:3b
AI_MODEL_CODE=codellama:7b
AI_MODEL_TRANSLATE=llama3.2:3b
EOF
    success "Laptop configuration saved"
    
    # Pull models
    step "Downloading models (3B/7B, ~6GB)..."
    info "This may take a few minutes..."
    ollama pull llama3.2:3b
    ollama pull codellama:7b
    
elif [ "$MACHINE_TYPE" = "desktop" ]; then
    cat >> "$CONFIG_FILE" <<EOF
AI_MODEL_DEFAULT=codellama:7b
AI_MODEL_CODE=codellama:7b
AI_MODEL_TRANSLATE=llama3.2:3b
EOF
    success "Desktop configuration saved"
    
    # Pull models
    step "Downloading models (3B/7B, ~6GB)..."
    info "This may take a few minutes..."
    ollama pull llama3.2:3b
    ollama pull codellama:7b
fi

success "Models downloaded"

success "AI module installed successfully"
info "Machine config: $CONFIG_FILE"
info "Ollama models: ollama list"