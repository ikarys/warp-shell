#!/bin/bash

set -e

echo "🎨 Configuration visuelle (fonts & instructions terminal)"

# 1. Télécharge la police MesloLGS NF (compatible Powerlevel10k)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Meslo Nerd Font (4 styles)
fonts=(
  "MesloLGS%20NF%20Regular.ttf"
  "MesloLGS%20NF%20Bold.ttf"
  "MesloLGS%20NF%20Italic.ttf"
  "MesloLGS%20NF%20Bold%20Italic.ttf"
)

# Remplace %20 par espace lors du stockage local
for font in "${fonts[@]}"; do
  localname=$(echo "$font" | sed 's/%20/ /g')
  curl -fLo "$localname" "https://github.com/romkatv/powerlevel10k-media/raw/master/$font"
done


# Rafraîchit les polices
fc-cache -f -v

cd -

echo
echo "✅ Police MesloLGS NF installée localement."
echo "📌 Ouvre Windows Terminal > Paramètres > WSL Ubuntu > Police : 'MesloLGS NF'"
echo

# 2. (Optionnel) Générer un profil WSL futuriste
echo "Tu peux aussi personnaliser les couleurs du terminal avec Dracula, One Dark, etc."
echo "Ou coller ce JSON dans ton fichier de profil Windows Terminal (Ctrl+, puis 'Ouvrir le fichier JSON')"
