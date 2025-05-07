#!/bin/bash
set -e

# 1. Change default shell to zsh (if possible)
ZSH_PATH="$(which zsh)"

if [ "$SHELL" != "$ZSH_PATH" ]; then
  echo "🔁 Tentative de bascule de bash vers zsh..."

  # chsh échoue souvent sous WSL, donc on ajoute un fallback
  if command -v chsh >/dev/null 2>&1; then
    chsh -s "$ZSH_PATH" "$USER" || echo "⚠️ chsh échoué, fallback .bashrc"
  fi

  # 2. Ajoute fallback dans ~/.bashrc
  if ! grep -q 'exec zsh' ~/.bashrc; then
    echo "⚙️  Ajout de exec zsh dans ~/.bashrc"
    echo '' >> ~/.bashrc
    echo '# Auto-launch zsh if installed' >> ~/.bashrc
    echo 'if [ -t 1 ] && command -v zsh >/dev/null && [ "$SHELL" != "$(which zsh)" ]; then' >> ~/.bashrc
    echo '  exec zsh' >> ~/.bashrc
    echo 'fi' >> ~/.bashrc
  else
    echo "✅ .bashrc already set to launch zsh"
  fi
else
  echo "✅ Shell déjà configuré sur zsh"
fi
