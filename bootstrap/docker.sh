#!/bin/bash
# Docker and container tools

set -e

echo "🐳 Setting up Docker..."

# Install Docker
if ! command -v docker &>/dev/null; then
  echo "📦 Installing Docker..."

  # Add Docker's official GPG key
  sudo apt update
  sudo apt install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  # Add Docker repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # Install Docker Engine
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Add user to docker group
  sudo usermod -aG docker $USER

  echo "⚠️  You need to log out and back in for docker group membership to take effect"
else
  echo "✓ Docker already installed"
fi

# Install docker-compose standalone (v2)
if ! command -v docker-compose &>/dev/null; then
  echo "📦 Installing docker-compose..."
  DOCKER_COMPOSE_VERSION=$(curl -s "https://api.github.com/repos/docker/compose/releases/latest" | jq -r '.tag_name')
  sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
else
  echo "✓ docker-compose already installed"
fi

# Install lazydocker (TUI for docker)
if ! command -v lazydocker &>/dev/null; then
  echo "📦 Installing lazydocker..."
  LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
  curl -Lo /tmp/lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
  tar xf /tmp/lazydocker.tar.gz -C /tmp
  sudo install /tmp/lazydocker /usr/local/bin/
  rm /tmp/lazydocker.tar.gz /tmp/lazydocker
else
  echo "✓ lazydocker already installed"
fi

echo "✅ Docker setup complete"
