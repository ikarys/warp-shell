# ⚡ Aliases - Raccourcis Cyberpunk

Liste complète des alias configurés pour maximum de productivité.

## 🔗 Git & Développement

```bash
gs          # git status
gl          # git pull origin
gp          # git push origin
gd          # git diff
ga          # git add .
gc          # git commit -m "message"
glog        # git log graphique
lg          # lazygit
```

## 📁 Navigation & Fichiers

```bash
ls          # eza --icons
ll          # eza -alh --git --icons  
l           # eza -lh --icons
la          # eza -la --icons
tree        # eza tree 2 niveaux
find        # fd (recherche fichiers)
```

## 🔍 Recherche & Analyse

```bash
grep        # ripgrep (rg)
du          # dust (analyse disque)
df          # duf (usage disques)  
ps          # procs (processus stylé)
top         # btop (moniteur système)
cat         # bat avec coloration
```

## ⚡ Productivité

```bash
c           # clear
reload      # source ~/.zshrc
update      # apt update && upgrade
..          # cd ..
...         # cd ../..
....        # cd ../../..
```

## 🛠️ Développement

```bash
vim         # neovim
v           # neovim (court)
zj          # zellij
bench       # hyperfine (benchmark)
info        # macchina (system info)
count       # tokei (lignes code)
gitinfo     # onefetch (info repo)
help        # tealdeer (tldr)
```

## 🔮 Cyberpunk Vibes

```bash
matrix      # cmatrix -s -C cyan
neo         # cmatrix
pipes       # pipes.sh -t 2 -R
hacker      # hollywood
```

## 📂 Raccourcis Dossiers

```bash
projects    # cd ~/projects
downloads   # cd ~/Downloads
docs        # cd ~/Documents
```

## 🎯 Recherche Avancée

```bash
h           # history | fzf (recherche historique)
```

## 💡 Tips d'usage

- Tous les alias sont configurés dans `~/aliases.zsh`
- `reload` pour recharger après modifications
- Tapez l'alias seul pour voir sa définition
- Combinez avec fzf : `vim $(fzf)`