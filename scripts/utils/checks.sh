#!/bin/bash
# Utils - System checks

set -e

# Source colors
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/colors.sh"

header "Vérification du système"

# Check if running in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    success "Environnement WSL détecté"
    IS_WSL=true
else
    warning "Non-WSL détecté - certaines fonctionnalités peuvent différer"
    IS_WSL=false
fi

# Check Ubuntu version
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        success "Ubuntu $VERSION_ID détecté"
        if [[ "$VERSION_ID" == "22.04" ]] || [[ "$VERSION_ID" == "24.04" ]]; then
            success "Version Ubuntu supportée"
        else
            warning "Version Ubuntu non testée (recommandé: 22.04 ou 24.04)"
        fi
    else
        warning "Distribution non-Ubuntu détectée: $ID"
    fi
else
    error "Impossible de déterminer la distribution"
    exit 1
fi

# Check internet connectivity
step "Vérification de la connexion internet..."
if ping -c 1 github.com &> /dev/null; then
    success "Connexion internet OK"
else
    error "Pas de connexion internet"
    exit 1
fi

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    error "Ne pas lancer ce script en tant que root"
    exit 1
else
    success "Utilisateur non-root (OK)"
fi

# Check if sudo is available
if command -v sudo >/dev/null 2>&1; then
    success "sudo disponible"
else
    error "sudo n'est pas installé"
    exit 1
fi

# Check available disk space (minimum 2GB)
available_space=$(df -BG / | awk 'NR==2 {print $4}' | sed 's/G//')
if [ "$available_space" -lt 2 ]; then
    warning "Espace disque faible: ${available_space}GB (recommandé: 2GB+)"
else
    success "Espace disque suffisant: ${available_space}GB"
fi

echo ""
info "Tous les prérequis sont satisfaits ✓"
echo ""
