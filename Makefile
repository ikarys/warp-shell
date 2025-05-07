# Makefile – Bootstrap environnement WSL

.PHONY: all bootstrap shell packages visuals dotfiles fix-shell full-clean

all: bootstrap

bootstrap:
	bash bootstrap.sh

shell:
	bash scripts/setup_shell_starship.sh

packages:
	bash scripts/install_packages.sh

visuals:
	bash scripts/visuals.sh

dotfiles:
	bash scripts/dotfiles.sh

fix-shell:
	bash scripts/fix_shell.sh

full-clean:
	rm -rf ~/.oh-my-zsh ~/.p10k.zsh ~/.config/starship.toml ~/.zshrc ~/.fzf.zsh
