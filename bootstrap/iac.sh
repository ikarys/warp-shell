#!/bin/bash
# Infrastructure as Code tools: terraform, opentofu, terragrunt, k8s tools

set -e

echo "🏗️  Setting up IaC and Kubernetes tools..."

# Install tfenv (Terraform version manager)
if [ ! -d "$HOME/.tfenv" ]; then
  echo "📦 Installing tfenv..."
  git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv

  if ! grep -q 'tfenv' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"
EOF
  fi

  export PATH="$HOME/.tfenv/bin:$PATH"
else
  echo "✓ tfenv already installed"
fi

# Install latest Terraform via tfenv
if command -v tfenv &>/dev/null; then
  echo "📦 Installing Terraform..."
  tfenv install latest
  tfenv use latest
fi

# Install tenv (OpenTofu + Terraform + Terragrunt version manager - all-in-one)
if ! command -v tenv &>/dev/null; then
  echo "📦 Installing tenv (OpenTofu/Terraform/Terragrunt manager)..."
  TENV_VERSION=$(curl -s "https://api.github.com/repos/tofuutils/tenv/releases/latest" | jq -r '.tag_name' | sed 's/^v//')
  curl -fsSL "https://github.com/tofuutils/tenv/releases/download/v${TENV_VERSION}/tenv_v${TENV_VERSION}_Linux_x86_64.tar.gz" | tar -xz -C /tmp
  sudo install /tmp/tenv /usr/local/bin/
  rm -f /tmp/tenv /tmp/LICENSE /tmp/README.md
else
  echo "✓ tenv already installed"
fi

# Install OpenTofu via tenv (skip if rate-limited)
if command -v tenv &>/dev/null; then
  echo "📦 Installing OpenTofu..."
  if tenv tofu install latest 2>&1 | grep -q "rate-limited"; then
    echo "⚠️  GitHub rate limit reached. Skipping OpenTofu."
    echo "💡 Set TENV_GITHUB_TOKEN env var to increase rate limit"
  else
    tenv tofu use latest 2>/dev/null || true
  fi
fi

# Install Terragrunt via tenv (skip if rate-limited)
if command -v tenv &>/dev/null; then
  echo "📦 Installing Terragrunt..."
  if tenv terragrunt install latest 2>&1 | grep -q "rate-limited"; then
    echo "⚠️  GitHub rate limit reached. Skipping Terragrunt."
    echo "💡 Set TENV_GITHUB_TOKEN env var to increase rate limit"
  else
    tenv terragrunt use latest 2>/dev/null || true
  fi
fi

# Install kubectl
if ! command -v kubectl &>/dev/null; then
  echo "📦 Installing kubectl..."
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
else
  echo "✓ kubectl already installed"
fi

# Install helm
if ! command -v helm &>/dev/null; then
  echo "📦 Installing Helm..."
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
  echo "✓ Helm already installed"
fi

# Install k9s (Kubernetes TUI)
if ! command -v k9s &>/dev/null; then
  echo "📦 Installing k9s..."
  K9S_VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r '.tag_name')
  curl -sL "https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz" | tar -xz -C /tmp
  sudo install /tmp/k9s /usr/local/bin/
  rm /tmp/k9s
else
  echo "✓ k9s already installed"
fi

# Install kubectx and kubens
if ! command -v kubectx &>/dev/null; then
  echo "📦 Installing kubectx and kubens..."
  sudo apt install -y kubectx
else
  echo "✓ kubectx already installed"
fi

# Install kustomize
if ! command -v kustomize &>/dev/null; then
  echo "📦 Installing kustomize..."
  curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
  sudo mv kustomize /usr/local/bin/
else
  echo "✓ kustomize already installed"
fi

echo "✅ IaC and K8s tools setup complete"
