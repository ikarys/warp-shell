#!/bin/bash
# Module 50 - Infra tools (Terraform, Kubernetes, YAML)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation des outils Infra"

# kubectl
if ! command_exists kubectl; then
    step "Installation de kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    rm kubectl
    success "kubectl installé"
else
    info "kubectl déjà installé"
fi

# kubectx + kubens
if ! command_exists kubectx; then
    step "Installation de kubectx + kubens..."
    KUBECTX_VERSION="0.9.5"  # check ahmetb/kubectx for latest — 0.11.0+ available
    wget -q "https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubectx_v${KUBECTX_VERSION}_linux_x86_64.tar.gz" -O /tmp/kubectx.tar.gz
    tar -xzf /tmp/kubectx.tar.gz -C /tmp
    sudo install /tmp/kubectx /usr/local/bin/kubectx
    rm /tmp/kubectx.tar.gz /tmp/kubectx

    wget -q "https://github.com/ahmetb/kubectx/releases/download/v${KUBECTX_VERSION}/kubens_v${KUBECTX_VERSION}_linux_x86_64.tar.gz" -O /tmp/kubens.tar.gz
    tar -xzf /tmp/kubens.tar.gz -C /tmp
    sudo install /tmp/kubens /usr/local/bin/kubens
    rm /tmp/kubens.tar.gz /tmp/kubens
    success "kubectx + kubens installés"
else
    info "kubectx déjà installé"
fi

# k9s (TUI Kubernetes)
if ! command_exists k9s; then
    step "Installation de k9s..."
    K9S_VERSION=$(curl -s "https://api.github.com/repos/derailed/k9s/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    wget -q "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" -O /tmp/k9s.tar.gz
    tar -xzf /tmp/k9s.tar.gz -C /tmp
    sudo install /tmp/k9s /usr/local/bin/k9s
    rm /tmp/k9s.tar.gz /tmp/k9s
    success "k9s installé"
else
    info "k9s déjà installé"
fi

# yq (YAML processor)
if ! command_exists yq; then
    step "Installation de yq..."
    YQ_VERSION=$(curl -s "https://api.github.com/repos/mikefarah/yq/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    wget -q "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64" -O /tmp/yq
    sudo install /tmp/yq /usr/local/bin/yq
    rm /tmp/yq
    success "yq installé"
else
    info "yq déjà installé"
fi

success "Module infra installé avec succès"
info "Terraform/Terragrunt : installe-les via mise (mise use -g terraform@latest)"
