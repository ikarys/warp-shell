#!/bin/bash

set -e

echo "🎨 Configuration visuelle (fonts & instructions terminal)"

# 1. Télécharge la police MesloLGS NF (compatible Powerlevel10k)
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# CYBERPUNK FONTS - JetBrains Mono Nerd Font + Cascadia Code PL
fonts=(
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
  "https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip"
)

echo "⚡ Downloading cyberpunk fonts..."
for font_url in "${fonts[@]}"; do
  filename=$(basename "$font_url")
  curl -fLo "$filename" "$font_url"
  unzip -o "$filename" "*.ttf" -d ./ 2>/dev/null || true
  rm "$filename"
done

# Backup: Meslo si les autres échouent
meslo_fonts=(
  "MesloLGS%20NF%20Regular.ttf"
  "MesloLGS%20NF%20Bold.ttf"
  "MesloLGS%20NF%20Italic.ttf"
  "MesloLGS%20NF%20Bold%20Italic.ttf"
)

for font in "${meslo_fonts[@]}"; do
  localname=$(echo "$font" | sed 's/%20/ /g')
  curl -fLo "$localname" "https://github.com/romkatv/powerlevel10k-media/raw/master/$font"
done


# Rafraîchit les polices
fc-cache -f -v

cd -

echo
echo "✅ Polices cyberpunk installées : JetBrains Mono NF, Cascadia Code PL, MesloLGS NF"
echo "🎯 Dans Windows Terminal : Paramètres > WSL Ubuntu > Police : 'JetBrainsMono Nerd Font'"
echo

# 2. Thèmes cyberpunk pour Windows Terminal
echo "🎨 THÈMES CYBERPUNK RECOMMANDÉS:"
echo
echo "🌃 TOKYO NIGHT - Colle ce JSON dans Windows Terminal:"
cat << 'EOF'
{
  "name": "Tokyo Night",
  "background": "#1A1B26",
  "foreground": "#C0CAF5", 
  "black": "#15161E",
  "red": "#F7768E",
  "green": "#9ECE6A",
  "yellow": "#E0AF68",
  "blue": "#7AA2F7",
  "purple": "#BB9AF7",
  "cyan": "#7DCFFF",
  "white": "#A9B1D6",
  "brightBlack": "#414868",
  "brightRed": "#F7768E",
  "brightGreen": "#9ECE6A",
  "brightYellow": "#E0AF68",
  "brightBlue": "#7AA2F7",
  "brightPurple": "#BB9AF7",
  "brightCyan": "#7DCFFF",
  "brightWhite": "#C0CAF5"
}
EOF
echo
echo "🧛 DRACULA PRO - Alternative:"
cat << 'EOF'
{
  "name": "Dracula Pro",
  "background": "#22212C",
  "foreground": "#F8F8F2",
  "black": "#22212C",
  "red": "#FF6E6E", 
  "green": "#69FF94",
  "yellow": "#FFFFA5",
  "blue": "#D6ACFF",
  "purple": "#FF92DF",
  "cyan": "#A4FFFF",
  "white": "#F8F8F2",
  "brightBlack": "#7970A9",
  "brightRed": "#FF6E6E",
  "brightGreen": "#69FF94", 
  "brightYellow": "#FFFFA5",
  "brightBlue": "#D6ACFF",
  "brightPurple": "#FF92DF",
  "brightCyan": "#A4FFFF",
  "brightWhite": "#F8F8F2"
}
EOF
echo
