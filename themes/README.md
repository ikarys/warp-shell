# 🎨 Thème Cyberpunk

Thème coordonné à travers Starship, Zellij et Neovim avec une palette néon cyberpunk.

## Palette de Couleurs

- **Neon Cyan**: `#00ffff` - Primary
- **Neon Magenta**: `#ff00ff` - Secondary  
- **Neon Yellow**: `#ffff00` - Accent
- **Neon Red**: `#ff0055` - Error
- **Dark Background**: `#0a0e27` - Background
- **Light Gray**: `#e0e0e0` - Foreground

## Installation

```bash
just install-theme
```

Ou manuellement:
```bash
cp themes/cyberpunk/starship.toml ~/.config/starship.toml
mkdir -p ~/.config/zellij/themes
cp themes/cyberpunk/zellij-theme.kdl ~/.config/zellij/themes/cyberpunk.kdl
```

## Font Recommandée

**JetBrains Mono Nerd Font** est fortement recommandée pour une expérience optimale.

### Installation Windows (pour WSL)

1. Télécharge [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads)
2. Extrais le zip
3. Installe les fichiers `.ttf` (double-clic)
4. Configure ton terminal:
   - **Windows Terminal**: Settings → Profiles → Defaults → Appearance → Font face → "JetBrainsMono Nerd Font"
   - **VSCode Terminal**: Settings → Terminal → Font Family → `'JetBrainsMono Nerd Font'`

### Installation Linux

```bash
# Télécharge et installe
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv
```

## Customisation

### Starship

Édite `~/.config/starship.toml`:
```toml
[palettes.cyberpunk]
neon_cyan = "#00ffff"
neon_magenta = "#ff00ff"
# ... change les couleurs
```

### Zellij

Édite `~/.config/zellij/themes/cyberpunk.kdl`:
```kdl
themes {
    cyberpunk {
        cyan "#00ffff"
        magenta "#ff00ff"
        # ... change les couleurs
    }
}
```

### Neovim

Le colorscheme recommandé est **tokyonight-storm** (inclus avec LazyVim).

Pour customiser, édite `~/.config/nvim/lua/config/options.lua`:
```lua
vim.g.lazyvim_colorscheme = "tokyonight-storm"
```

Alternatives cyberpunk:
- `cyberdream`
- `synthwave84`
- `neon`

## Preview

### Starship Prompt
```
╭─ikarys @hostname ~/projects/warp-shell  main  !1 ?2 
╰─❯ 
```

### Zellij
Bordures cyan, tabs magenta, status bar thématique.

### Terminal
Un fond sombre (`#0a0e27`) avec texte clair permet aux couleurs néon de vraiment ressortir.

## Ressources

- [Nerd Fonts](https://www.nerdfonts.com/)
- [Starship Presets](https://starship.rs/presets/)
- [Zellij Themes](https://zellij.dev/documentation/theme-gallery.html)
- [Neovim Colorschemes](https://vimcolorschemes.com/)
