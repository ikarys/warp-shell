#!/bin/bash
# Visual setup: fonts and terminal themes

set -e

echo "🎨 Setting up fonts and terminal themes..."

# Install fonts directory
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Download and install Nerd Fonts
echo "📦 Installing Nerd Fonts..."

fonts=(
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip"
)

for font_url in "${fonts[@]}"; do
  filename=$(basename "$font_url")
  if [ ! -f "$filename" ]; then
    echo "Downloading $filename..."
    curl -fLo "$filename" "$font_url"
    unzip -o "$filename" "*.ttf" -d ./ 2>/dev/null || true
    rm "$filename"
  fi
done

# Refresh font cache
fc-cache -f -v

cd - > /dev/null

echo ""
echo "✅ Fonts installed successfully"
echo ""
echo "🎨 TERMINAL THEME RECOMMENDATIONS:"
echo ""
echo "🌃 TOKYO NIGHT - Paste this in Windows Terminal settings.json:"
echo '
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
'
echo ""
echo "💡 Set font to 'JetBrainsMono Nerd Font' in Windows Terminal settings"
