# 🎯 lazygit - Terminal Git UI

Interface Git intuitive et rapide en terminal.

## 🚀 Lancement

```bash
lazygit    # Interface complète
lg         # Alias court
```

## ⌨️ Navigation principale

- `Tab` : Changer de panel
- `q` : Quitter
- `?` : Aide
- `Enter` : Sélectionner/Ouvrir
- `Esc` : Retour

## 📁 Panels principaux

### Status (changements)
- `Space` : Stage/unstage fichier
- `a` : Stage tous les fichiers
- `A` : Stage tous (including untracked)
- `c` : Commit
- `C` : Commit avec éditeur

### Files (fichiers)
- `d` : Discard changes
- `e` : Éditer fichier
- `o` : Ouvrir fichier
- `i` : Ignorer fichier (.gitignore)

### Branches
- `Space` : Checkout branche
- `c` : Checkout par nom
- `n` : Nouvelle branche
- `d` : Supprimer branche
- `r` : Rebase branche
- `M` : Merge branche

### Commits
- `Space` : Checkout commit
- `g` : Reset to commit
- `C` : Copy commit (cherry-pick)
- `t` : Tag commit
- `r` : Reword commit

## 🌐 Remote operations

- `p` : Pull
- `P` : Push
- `f` : Fetch

## 💡 Tips productivité

- `+` : Augmenter diff context
- `-` : Diminuer diff context
- `/` : Rechercher
- `m` : Voir diff complet
- `@` : Command log