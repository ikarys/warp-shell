# 🔍 fzf - Fuzzy Finder

Outil de recherche floue ultra-rapide pour fichiers, historique, processus, etc.

## 🚀 Usage de base

```bash
fzf           # Recherche de fichiers
h             # Recherche dans l'historique (alias)
Ctrl+R        # Recherche historique (intégré)
Ctrl+T        # Recherche fichiers (intégré)
Alt+C         # Recherche dossiers (intégré)
```

## ⚡ Avec d'autres commandes

```bash
vim $(fzf)              # Ouvrir fichier sélectionné
kill -9 $(ps aux | fzf) # Tuer processus sélectionné
git checkout $(git branch | fzf)  # Changer de branche
```

## 🎨 Options de recherche

Dans fzf :
- `'` : Recherche exacte ("'wild" pour "wild" exact)
- `^` : Début de ligne ("^music" pour commencer par music)
- `$` : Fin de ligne ("mp3$" pour finir par mp3)
- `!` : Exclusion ("!fire" pour exclure fire)

## 💡 Raccourcis dans fzf

- `Enter` : Sélectionner
- `Tab` : Sélection multiple
- `Shift+Tab` : Désélectionner
- `Ctrl+A` : Tout sélectionner
- `Ctrl+D` : Tout désélectionner
- `Ctrl+K/J` : Monter/descendre

## 🎯 Intégrations

```bash
# Avec ripgrep
rg "pattern" | fzf

# Avec Git
git log --oneline | fzf

# Avec find
find . -type f | fzf
```