# 🎨 Thèmes Cyberpunk

Configuration des thèmes terminal et couleurs pour ambiance hacker.

## 🌃 Tokyo Night (Recommandé)

Thème sombre inspiré de la nuit de Tokyo avec néons.

### Windows Terminal
Copiez ce JSON dans Windows Terminal settings :

```json
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
```

## 🧛 Dracula Pro

Alternative sombre avec violets et roses.

```json
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
```

## 🎯 Configuration

1. Windows Terminal : `Ctrl+,` → "Ouvrir le fichier JSON"
2. Ajouter le thème dans `schemes: []`
3. Appliquer au profil WSL Ubuntu dans `profiles`

## 🎨 Starship Cyberpunk

Le prompt utilise des couleurs Matrix :
- **Vert néon** (`#00ff41`) : Succès, utilisateur
- **Cyan** (`#00ffff`) : Répertoires, hostname  
- **Rose** (`#ff6b9d`) : Git branches, mémoire
- **Jaune** (`#ffff00`) : Git status, packages
- **Rouge** (`#ff0040`) : Erreurs, root
- **Violet** (`#c792ea`) : Temps, commits

## 💡 Tips

- Utilisez police Nerd Font pour icônes
- Activez transparence terminal (20-30%)
- Mode plein écran pour immersion max
- Combinez avec `matrix` pour pauses stylées