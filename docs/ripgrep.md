# ⚡ ripgrep (rg) - Ultra-fast search

Recherche ultra-rapide dans fichiers avec support regex et Git.

## 🚀 Usage de base

```bash
grep "pattern" .     # Recherche dans dossier courant (alias)
rg "pattern"         # Recherche basique
rg -i "pattern"      # Insensible à la casse
rg -v "pattern"      # Inverser (lignes sans pattern)
```

## 🎯 Options utiles

```bash
rg -A 3 -B 3 "pattern"    # 3 lignes avant/après
rg -C 5 "pattern"         # 5 lignes contexte
rg -l "pattern"           # Seulement noms fichiers
rg -c "pattern"           # Compter occurrences
rg --type js "pattern"    # Seulement fichiers JS
```

## 🔍 Types de fichiers

```bash
rg --type-list           # Voir tous les types
rg --type py "class"     # Seulement Python
rg --type js "function"  # Seulement JavaScript
rg --type rust "fn"      # Seulement Rust
```

## 💡 Patterns avancés

```bash
rg "TODO|FIXME"          # OR logique
rg "function\s+\w+"      # Regex
rg -w "word"             # Mot entier seulement
rg "^import"             # Début de ligne
rg "\.js$"               # Fin de ligne
```

## 🚀 Performance tips

```bash
rg --no-ignore          # Ignorer .gitignore
rg --hidden             # Inclure fichiers cachés
rg -j 1                 # Un seul thread (moins RAM)
rg --mmap               # Memory mapping (plus rapide)
```

## 🎨 Output personnalisé

```bash
rg --color always "pattern"     # Forcer couleurs
rg --no-line-number "pattern"   # Sans numéros lignes
rg --no-filename "pattern"      # Sans noms fichiers
```