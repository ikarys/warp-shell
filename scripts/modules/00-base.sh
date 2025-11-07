#!/bin/bash
# Module 00 - Base dependencies installation

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation des dépendances de base"

# Update package list
step "Mise à jour de la liste des paquets..."
sudo apt-get update -qq

# Install essential packages
step "Installation des paquets essentiels..."
sudo apt-get install -y \
    build-essential \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    git \
    unzip \
    locales \
    python3 \
    python3-pip \
    python3-venv

success "Paquets essentiels installés"

# Configure locale
step "Configuration des locales..."
sudo locale-gen en_US.UTF-8
sudo locale-gen fr_FR.UTF-8
sudo update-locale LANG=en_US.UTF-8

success "Locales configurées"

# Create warp-shell config directory
step "Création du répertoire de configuration..."
mkdir -p ~/.config/warp-shell

success "Module base installé avec succès"
