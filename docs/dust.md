# 💾 dust - Disk Usage Visualizer

Analyseur d'espace disque moderne avec visualisation intuitive.

## 🚀 Usage de base

```bash
du         # Usage dossier courant (alias)
dust       # Commande directe
dust /path # Analyser dossier spécifique
```

## 📊 Options d'affichage

```bash
dust -d 3        # Profondeur 3 niveaux
dust -r          # Reverse (plus petit d'abord)
dust -n 10       # Top 10 seulement
dust -p          # Pourcentages
dust -b          # Tailles en bytes
```

## 🎯 Filtres utiles

```bash
dust -X .git           # Exclure dossier .git
dust -I "*.log"        # Ignorer fichiers .log
dust -t 1G             # Seulement >1GB
dust -z 100M           # Seulement >100MB
```

## 📈 Types de sortie

```bash
dust -c          # Couleurs forcées
dust --no-colors # Sans couleurs
dust -T          # Format tree
dust -j          # Output JSON
```

## 💡 Exemples pratiques

```bash
# Gros dossiers dans home
dust ~ -d 2 -n 20

# Fichiers >500MB
dust -z 500M

# Exclure node_modules
dust -X node_modules

# Analyse rapide projet
dust . -d 2 -p
```

## 🚀 Avantages vs `du`

- Visualisation colorée
- Barres de progression
- Tri intelligent
- Filtres puissants
- Plus rapide
- Format lisible automatique

## 🎨 Interprétation

- **Barres** : Proportion visuelle
- **Couleurs** : Taille relative
- **%** : Pourcentage du total
- **Tree** : Hiérarchie dossiers