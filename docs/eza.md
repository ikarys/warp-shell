# 📂 eza - Modern `ls` replacement

Remplacement moderne de `ls` avec icônes, couleurs et intégration Git.

## 🚀 Usage de base

```bash
ls          # Liste avec icônes
ll          # Liste détaillée avec Git status
la          # Tous les fichiers (cachés inclus)
tree        # Vue arbre (2 niveaux)
```

## ⚡ Commandes utiles

```bash
eza --tree --level=3           # Arbre 3 niveaux
eza -la --git --icons          # Tout afficher avec Git
eza -lh --sort=size            # Tri par taille
eza -lh --sort=modified        # Tri par date
eza --group-directories-first  # Dossiers en premier
```

## 🎨 Options courantes

- `--icons` : Icônes pour types de fichiers
- `--git` : Statut Git des fichiers
- `--tree` : Vue arborescente
- `--level=N` : Profondeur arbre
- `--sort=` : Tri (size, modified, name, type)
- `--reverse` : Ordre inverse

## 💡 Exemples pratiques

```bash
# Voir les gros fichiers
eza -lh --sort=size --reverse

# Fichiers modifiés récemment
eza -lh --sort=modified --reverse

# Vue projet avec Git
eza --tree --git --icons --level=2
```