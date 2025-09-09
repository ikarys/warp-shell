# 🧱 zellij - Modern Terminal Multiplexer

Multiplexeur terminal moderne et intuitif, alternative à tmux.

## 🚀 Usage de base

```bash
zj          # Lance zellij (alias)
zellij      # Commande complète
zellij -s mysession    # Session nommée
```

## ⌨️ **Raccourcis principaux**

### 📱 Panneaux (Panes)
- `Ctrl+p` puis `d` : **Split horizontal** (nouveau panneau en bas)
- `Ctrl+p` puis `r` : **Split vertical** (nouveau panneau à droite)
- `Alt+←→↑↓` : **Naviguer** entre panneaux
- `Ctrl+p` puis `x` : **Fermer** panneau courant
- `Ctrl+p` puis `z` : **Zoom** panneau (plein écran toggle)

### 📋 Onglets (Tabs)
- `Ctrl+t` puis `n` : **Nouvel onglet**
- `Alt+←→` : **Naviguer** entre onglets
- `Ctrl+t` puis `r` : **Renommer** onglet
- `Ctrl+t` puis `x` : **Fermer** onglet

### 🎯 Mode Focus
- `Ctrl+p` puis `f` : **Mode focus** (panneau actif seulement)
- `Ctrl+p` puis `w` : **Retour** vue normale

### 📏 Redimensionnement
- `Ctrl+n` : **Mode resize**
  - `←→↑↓` : Redimensionner
  - `Enter` : Confirmer

### 🔍 Recherche & Copy
- `Ctrl+s` : **Mode recherche**
  - `/pattern` : Rechercher
  - `n` : Suivant, `N` : Précédent
- `Ctrl+s` puis `Space` : **Mode copy**
  - `v` : Sélection, `y` : Copier

## 🎛️ **Sessions**

```bash
# Gestion des sessions
zellij list-sessions          # Lister sessions
zellij attach mysession       # Se connecter
zellij kill-session mysession # Supprimer
zellij -s work               # Créer session "work"
```

### 🔌 Détacher/Rattacher
- `Ctrl+o` puis `d` : **Détacher** session
- `zellij attach` : **Rattacher** dernière session

## 💡 **Workflows typiques**

### 🛠️ Développement
```bash
zj                    # Lance zellij
Ctrl+p d              # Split horizontal
# Panneau 1: nvim
# Panneau 2: terminal build/test
Ctrl+t n              # Nouvel onglet pour Git
# lg (lazygit)
```

### 📊 Monitoring
```bash
zj
Ctrl+p r              # Split vertical  
# Panneau 1: btop (système)
# Panneau 2: logs
Ctrl+p d              # Split bas
# Panneau 3: réseau
```

## 🎨 **Personnalisation**

Configuration dans `~/.config/zellij/config.kdl` :

```kdl
keybinds {
    normal {
        bind "Alt n" { NewPane "Down"; }
        bind "Alt m" { NewPane "Right"; }
    }
}
```

## ⚡ **Tips productivité**

- **F1** : Aide interactive complète
- `Ctrl+q` : **Quitter** zellij
- Sessions persistent même si terminal fermé
- Copier-coller entre panneaux avec `Ctrl+s`
- Zoom panneau avec `Ctrl+p z` pour focus
- Nommer tes sessions : `zj -s projet1`

## 🚀 **Avantages vs tmux**

- Interface plus intuitive
- Pas de fichier config complexe requis
- Raccourcis plus logiques
- Meilleur support mouse
- Session management plus simple