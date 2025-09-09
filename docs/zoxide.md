# 🧭 zoxide - Smart `cd`

`cd` intelligent qui apprend de vos habitudes et permet de naviguer rapidement.

## 🚀 Usage de base

```bash
z projects    # Va au dossier "projects" le plus probable
z doc         # Va dans "Documents" 
zi            # Mode interactif avec fzf
```

## ⚡ Commandes

```bash
z <query>     # Navigation intelligente
zi            # Mode interactif
z -            # Retour au dossier précédent
zoxide add .  # Ajouter dossier courant manuellement
zoxide query  # Voir la base de données
```

## 🎯 Comment ça marche

Zoxide mémorise vos dossiers les plus visités :
- Plus vous allez dans un dossier, plus il est prioritaire
- Recherche floue dans les noms de dossiers
- Pas besoin du chemin complet

## 💡 Exemples

```bash
# Au lieu de cd ~/projects/web/myapp
z myapp

# Au lieu de cd ~/Documents/work
z work

# Navigation interactive
zi    # Ouvre fzf pour choisir
```

## 🧠 Tips

- Utilisez `z` quelques jours pour qu'il apprenne
- `zi` si vous hésitez entre plusieurs dossiers
- Fonctionne avec des parties de noms de dossiers