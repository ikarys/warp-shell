# 🦇 bat - Cat with Wings

`cat` avec coloration syntaxique, numérotation et intégration Git.

## 🚀 Usage de base

```bash
cat file.js        # Affiche avec syntaxe (alias)
bat file.py        # Commande directe
bat *.md           # Plusieurs fichiers
```

## 🎨 Options styling

```bash
bat --style=numbers file.txt         # Numéros lignes seulement
bat --style=changes file.txt         # Git changes seulement
bat --style=header file.txt          # Header seulement
bat --style=plain file.txt           # Sans style (comme cat)
```

## 📄 Pagination

```bash
bat large_file.log     # Auto-pagination
bat -p file.txt        # Pas de pagination
bat --pager=never      # Force pas de pagination
```

## 🔍 Avec d'autres outils

```bash
curl -s api.json | bat -l json    # Colorer JSON depuis API
tail -f log.txt | bat --paging=never -l log  # Suivi logs coloré
git show HEAD:file.js | bat -l js  # Fichier version précédente
```

## 🎯 Langages supportés

```bash
bat --list-languages   # Voir tous les langages
bat -l javascript      # Force type JavaScript
bat -l python         # Force type Python
bat -l json           # Force type JSON
```

## 💡 Tips productivité

```bash
# Range de lignes
bat file.py -r 10:20

# Highlighter lignes spécifiques
bat file.js -H 15:18

# Thème personnalisé
bat --theme="Monokai Extended"
```

## 🎨 Thèmes disponibles

```bash
bat --list-themes      # Voir thèmes disponibles
```

Thèmes populaires :
- Dracula
- Monokai Extended
- Nord
- Solarized