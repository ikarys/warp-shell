#!/bin/bash
# Utility tools: yq, jq, base64 tools, markdown tools

set -e

echo "🛠️  Installing utility tools..."

# Install jq (JSON processor)
if ! command -v jq &>/dev/null; then
  echo "📦 Installing jq..."
  sudo apt install -y jq
else
  echo "✓ jq already installed"
fi

# Install yq (YAML processor)
if ! command -v yq &>/dev/null; then
  echo "📦 Installing yq..."
  if command -v jq &>/dev/null; then
    YQ_VERSION=$(curl -s "https://api.github.com/repos/mikefarah/yq/releases/latest" | jq -r '.tag_name')
  else
    YQ_VERSION="v4.44.3"  # Fallback version
  fi
  if [ -n "$YQ_VERSION" ]; then
    sudo wget -qO /usr/local/bin/yq "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64"
    sudo chmod +x /usr/local/bin/yq
  else
    echo "⚠️  Could not determine yq version (GitHub rate limit?)"
  fi
else
  echo "✓ yq already installed"
fi

# Install glow (markdown renderer)
if ! command -v glow &>/dev/null; then
  echo "📦 Installing glow..."
  if command -v jq &>/dev/null; then
    GLOW_VERSION=$(curl -s "https://api.github.com/repos/charmbracelet/glow/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
  else
    GLOW_VERSION="2.1.1"  # Fallback version
  fi
  if [ -n "$GLOW_VERSION" ] && [ "$GLOW_VERSION" != "null" ]; then
    if curl -sL "https://github.com/charmbracelet/glow/releases/download/v${GLOW_VERSION}/glow_${GLOW_VERSION}_Linux_x86_64.tar.gz" | tar -xz -C /tmp 2>/dev/null; then
      if [ -f /tmp/glow ]; then
        sudo install /tmp/glow /usr/local/bin/
        rm -f /tmp/glow /tmp/LICENSE /tmp/README.md
      else
        echo "⚠️  glow download failed - skipping"
      fi
    else
      echo "⚠️  Could not download glow (rate limit or network error) - skipping"
    fi
  else
    echo "⚠️  Could not determine glow version - skipping"
    echo "💡 Set GITHUB_TOKEN to increase rate limit"
  fi
else
  echo "✓ glow already installed"
fi

# Install mdcat (markdown cat)
if ! command -v mdcat &>/dev/null; then
  echo "📦 Installing mdcat..."
  cargo install mdcat
else
  echo "✓ mdcat already installed"
fi

# Install fx (interactive JSON viewer)
if ! command -v fx &>/dev/null && command -v npm &>/dev/null; then
  echo "📦 Installing fx..."
  npm install -g fx
else
  echo "✓ fx already installed or npm not available"
fi

# Install httpie (better curl)
if ! command -v http &>/dev/null; then
  echo "📦 Installing httpie..."
  sudo apt install -y httpie
else
  echo "✓ httpie already installed"
fi

# Install xh (faster httpie in Rust)
if ! command -v xh &>/dev/null; then
  echo "📦 Installing xh..."
  cargo install xh
else
  echo "✓ xh already installed"
fi

echo "✅ Utils setup complete"
