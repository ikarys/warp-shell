# ✨ Polices Cyberpunk

Polices optimisées pour développement avec support icônes et style hacker.

## 🎯 JetBrains Mono Nerd Font (Recommandé)

Police de développement moderne avec icônes intégrés.

### ⚡ Avantages
- Optimisée pour code
- Ligatures de programmation 
- Icônes Nerd Font intégrés
- Excellente lisibilité
- Zero confusion (0 vs O)

### 🔧 Configuration Windows Terminal
```json
{
  "font": {
    "face": "JetBrainsMono Nerd Font",
    "size": 11
  }
}
```

## 🚀 Cascadia Code PL

Police Microsoft avec style cyberpunk.

### ⚡ Features
- Ligatures programmation
- Style futuriste  
- Optimisée terminal
- Support Powerline

### 🔧 Configuration
```json
{
  "font": {
    "face": "Cascadia Code PL",
    "size": 11
  }
}
```

## 🔙 MesloLGS NF (Backup)

Police backup compatible avec la plupart des prompts.

## 📦 Installation automatique

Les polices sont installées par `visuals.sh` :

```bash
# Polices téléchargées dans ~/.local/share/fonts/
JetBrainsMono.zip
CascadiaCode.zip  
MesloLGS NF (4 variantes)
```

## 🎨 Configuration optimale

### Windows Terminal
1. `Ctrl+,` → Profils → Ubuntu
2. Apparence → Police → "JetBrainsMono Nerd Font"
3. Taille : 10-12pt selon préférence
4. Poids : Normal ou Medium

### VS Code Terminal
```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font",
  "terminal.integrated.fontSize": 12
}
```

## 💡 Test des polices

Après installation, testez :
```bash
# Test icônes
ls
tree

# Test ligatures (si supportées)
echo "=> != >= <="

# Test caractères spéciaux
info  # Affiche système avec icônes
```

## 🔧 Troubleshooting

Si les icônes ne s'affichent pas :
1. Vérifiez que la police contient "Nerd Font"
2. Redémarrez le terminal
3. Utilisez MesloLGS NF en backup