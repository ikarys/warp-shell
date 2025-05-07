# 🧰 WSL Productivity Environment Bootstrap

A modular, modern, and productivity-focused setup script for bootstrapping a clean and efficient **terminal environment in WSL (Ubuntu 22.04 / 24.04)**.

Includes:
- A fast Zsh + Starship shell
- Smart command-line tools (ripgrep, bat, fzf, etc.)
- A minimal layout with versioned dotfiles
- Optional terminal UI tools and visual tweaks

Ideal for developers, sysadmins, and power users who want a better WSL terminal experience — not just another dev stack.

Designed to be reproducible across multiple machines with:
- clean Zsh shell
- Starship prompt
- modern CLI tools
- versioned dotfiles
- and optional terminal visual customization.

---

## 🚀 Key Features

✅ **Zsh + Starship**: Fast, minimal shell setup with a customizable prompt  
🧱 **Zellij**: Terminal multiplexer (tmux alternative) with intuitive keybindings  
⚙️ **Modern CLI stack**:  
- `ls` → `eza`  
- `cat` → `bat`  
- `grep` → `ripgrep`  
- `find` → `fd`  
- `cd` → `zoxide`  
- `du` → `dust`  
- `top` → `btop`  

---

## 📦 Installed Packages Overview

| Package                | Description                                         | Replaces / Enhances     |
|------------------------|-----------------------------------------------------|--------------------------|
| `zsh`                  | Modern shell, faster and more scriptable            | Replaces `bash`         |
| `neovim`               | Modern, extensible Vim-based text editor            | Enhances `vim`           |
| `btop`                 | TUI system monitor with clean interface             | Replaces `top`, `htop`   |
| `fzf`                  | Fuzzy finder for anything (files, history...)       | Enhances `Ctrl+R`, `find` |
| `bat`                  | `cat` with syntax highlighting and git integration  | Replaces `cat`           |
| `ripgrep`              | Ultra-fast file search with regex                   | Replaces `grep`          |
| `fd-find`              | Fast, intuitive file finder                         | Replaces `find`          |
| `eza`                  | Modern `ls` with icons and Git awareness            | Replaces `ls`            |
| `tldr`                 | Simplified manpages with real examples              | Enhances `man`           |
| `locales`              | Sets up system-wide language encoding               | Required for UTF-8       |
| `taskwarrior`          | Powerful task and todo management in CLI            | CLI task manager         |
| `zoxide`               | Smarter `cd` with jump memory                       | Replaces `cd`            |
| `git`                  | Version control system                              | —                        |
| `curl` / `wget`        | Command-line tools to fetch files over HTTP(S)      | —                        |
| `unzip`                | Extract `.zip` archives                             | —                        |
| `build-essential`      | Compiler, linker and build tools                    | Needed for compiling     |
| `software-properties-common` | Adds support for PPAs / apt repo mgmt       | Enables `add-apt-repository` |
---

## Aliases

The `dotfiles/aliases.zsh` file includes a set of helpful aliases to streamline your workflow. Below is a table summarizing the available aliases:

| **Alias**   | **Command**                                      | **Description**                                   |
|-------------|--------------------------------------------------|-------------------------------------------------|
| `cat`       | `bat`                                            | Replaces `cat` with `bat` for syntax highlighting. |
| `gs`        | `git status`                                     | Displays the current Git status.                |
| `gl`        | `git pull origin`                                | Pulls the latest changes from the remote repository. |
| `gp`        | `git push origin`                                | Pushes changes to the remote repository.        |
| `gd`        | `git diff`                                       | Shows the differences between commits or files. |
| `ga`        | `git add .`                                      | Stages all changes for commit.                  |
| `gc`        | `git commit -m`                                  | Commits changes with a message.                 |
| `ls`        | `eza`                                            | Replaces `ls` with `eza` for enhanced output.   |
| `ll`        | `eza -alh --git`                                 | Lists all files with detailed information and Git status. |
| `l`         | `eza -lh`                                        | Lists files in a concise format.                |
| `tree`      | `eza -T -alh --git --level=1`                    | Displays a tree view of the current directory.  |
| `update`    | `sudo apt update && sudo apt upgrade -y`         | Updates and upgrades system packages.           |
| `grep`      | `rg`                                             | Replaces `grep` with `ripgrep` for faster searching. |
| `c`         | `clear`                                          | Clears the terminal screen.                     |
| `top`       | `btop`                                           | Replaces `top` with `btop` for a better system monitor. |
| `v`, `vim`      | `nvim`                                           | Opens `nvim` (Neovim) as the default editor.    |
| `zj`        | `zellij`                                         | Shortcut for launching `zellij`.               |

These aliases are designed to improve productivity and simplify common tasks.

---


📦 **Dotfiles managed and versioned**:  
- `~/.zshrc`  
- `aliases.zsh`  
- `starship.toml`  

🧠 **Makefile-based automation**  
🎨 Optional terminal font and color theme instructions

---

## 📦 Installation

```bash
git clone https://github.com/yourname/wslenvInstaller.git
cd wslenvInstaller
make bootstrap
```
---

## 🧱 Zellij – Terminal Multiplexer

Zellij is a modern alternative to tmux, providing an intuitive way to split your terminal into multiple panes and tabs.

### 🚀 Alias (add to your aliases.zsh)
```bash
alias zj="zellij"
```

| Action                     | Keybinding                                   |
| -------------------------- | -------------------------------------------- |
| New **pane** (split below) | `Ctrl + p`, then `d`                         |
| New **pane** (split right) | `Alt + n`                                    |
| New **tab**                | `Ctrl + p`, then `t`                         |
| Switch to next **tab**     | `Alt + arrows`                                    |
| Close current pane         | `Ctrl + d`                                   |
| Show help                  | `F1`                                         |
| Lock controls              | `Ctrl + g`                                   |
