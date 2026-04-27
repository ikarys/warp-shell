#!/bin/bash
# Module 35 - Docker

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/colors.sh"

header "Installation de Docker"

if command_exists docker; then
    info "Docker déjà installé ($(docker --version))"
    exit 0
fi

step "Suppression des anciens paquets Docker éventuels..."
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y $pkg 2>/dev/null || true
done

step "Ajout du dépôt officiel Docker..."
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -qq

step "Installation de Docker Engine + Compose plugin..."
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

success "Docker installé"

# Ajouter l'utilisateur au groupe docker (évite sudo)
if ! groups "$USER" | grep -q docker; then
    step "Ajout de $USER au groupe docker..."
    sudo usermod -aG docker "$USER"
    warning "Déconnecte-toi et reconnecte-toi pour utiliser Docker sans sudo"
fi

# Activer et démarrer Docker (hors WSL2 systemd)
if systemctl is-active --quiet docker 2>/dev/null; then
    info "Service Docker déjà actif"
elif command_exists systemctl; then
    step "Activation du service Docker..."
    sudo systemctl enable docker
    sudo systemctl start docker
    success "Service Docker démarré"
else
    warning "Systemd non disponible (WSL1 ?) — démarre Docker manuellement : sudo service docker start"
fi

success "Module Docker installé avec succès"
