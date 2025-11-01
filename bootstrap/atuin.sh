#!/bin/bash
# Atuin - magical shell history

set -e

echo "🔮 Installing Atuin (advanced shell history)..."

if ! command -v atuin &>/dev/null; then
  echo "📦 Installing atuin..."
  curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | bash

  # Add atuin to zshrc if not present
  if ! grep -q 'atuin init' ~/.zshrc; then
    echo 'eval "$(atuin init zsh)"' >> ~/.zshrc
  fi
else
  echo "✓ Atuin already installed"
fi

# Create atuin config directory
mkdir -p ~/.config/atuin

# Create atuin config
if [ ! -f ~/.config/atuin/config.toml ]; then
  cat > ~/.config/atuin/config.toml << 'EOF'
## Atuin configuration

# Sync configuration
auto_sync = true
sync_frequency = "5m"
sync_address = "https://api.atuin.sh"

# Search configuration
search_mode = "fuzzy"
filter_mode = "global"
filter_mode_shell_up_key_binding = "directory"
style = "compact"
inline_height = 20
show_preview = true

# Stats - use `atuin stats` command to view statistics
# [stats]
# common_subcommands = true

# Key bindings
keymap_mode = "vim-normal"

# Update check
update_check = true

# History settings
history_filter = [
  "^secret",
  "^password",
  "^token",
  "^export AWS",
]

# Enter key behavior
enter_accept = true
EOF
  echo "✓ Atuin config created"
fi

echo "✅ Atuin setup complete"
echo "💡 Run 'atuin register' or 'atuin login' to sync across machines"
