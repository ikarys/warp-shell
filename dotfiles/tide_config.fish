#!/usr/bin/env fish
# Tide prompt configuration — Warp Shell
# Generated via:
#   tide configure --auto --style=Lean --prompt_colors='True color' \
#     --show_time='24-hour format' --lean_prompt_height='Two lines' \
#     --prompt_connection=Dotted --prompt_connection_andor_frame_color=Darkest \
#     --prompt_spacing=Sparse --icons='Many icons' --transient=No
# Apply with: fish dotfiles/tide_config.fish

# Layout
set -U tide_left_prompt_items os pwd git newline character
set -U tide_right_prompt_items status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time

# Left prompt frame
set -U tide_left_prompt_frame_enabled false
set -U tide_left_prompt_prefix ''
set -U tide_left_prompt_separator_diff_color ' '
set -U tide_left_prompt_separator_same_color ' '
set -U tide_left_prompt_suffix ' '

# Right prompt frame
set -U tide_right_prompt_frame_enabled false
set -U tide_right_prompt_prefix ' '
set -U tide_right_prompt_separator_diff_color ' '
set -U tide_right_prompt_separator_same_color ' '
set -U tide_right_prompt_suffix ''

# General prompt
set -U tide_prompt_add_newline_before true
set -U tide_prompt_color_frame_and_connection 444444
set -U tide_prompt_color_separator_same_color 949494
set -U tide_prompt_icon_connection "·"
set -U tide_prompt_min_cols 34
set -U tide_prompt_pad_items false
set -U tide_prompt_transient_enabled false

# Character (prompt symbol ❯)
set -U tide_character_color 5FD700
set -U tide_character_color_failure FF0000
set -U tide_character_icon "❯"
set -U tide_character_vi_icon_default "❮"
set -U tide_character_vi_icon_replace "▶"
set -U tide_character_vi_icon_visual V

# OS icon
set -U tide_os_bg_color normal
set -U tide_os_color normal
set -U tide_os_icon ""

# PWD
set -U tide_pwd_bg_color normal
set -U tide_pwd_color_anchors 00AFFF
set -U tide_pwd_color_dirs 0087AF
set -U tide_pwd_color_truncated_dirs 8787AF
set -U tide_pwd_icon ""
set -U tide_pwd_icon_home ""
set -U tide_pwd_icon_unwritable ""
set -U tide_pwd_markers .bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform bun.lockb Cargo.toml composer.json CVS go.mod package.json build.zig

# Git
set -U tide_git_bg_color normal
set -U tide_git_bg_color_unstable normal
set -U tide_git_bg_color_urgent normal
set -U tide_git_color_branch 5FD700
set -U tide_git_color_conflicted FF0000
set -U tide_git_color_dirty D7AF00
set -U tide_git_color_operation FF0000
set -U tide_git_color_staged D7AF00
set -U tide_git_color_stash 5FD700
set -U tide_git_color_untracked 00AFFF
set -U tide_git_color_upstream 5FD700
set -U tide_git_icon ""
set -U tide_git_truncation_length 24
set -U tide_git_truncation_strategy ''

# Status
set -U tide_status_bg_color normal
set -U tide_status_bg_color_failure normal
set -U tide_status_color 5FAF00
set -U tide_status_color_failure D70000
set -U tide_status_icon "✔"
set -U tide_status_icon_failure "✘"

# Cmd duration
set -U tide_cmd_duration_bg_color normal
set -U tide_cmd_duration_color 87875F
set -U tide_cmd_duration_decimals 0
set -U tide_cmd_duration_icon ""
set -U tide_cmd_duration_threshold 3000

# Context (user@host)
set -U tide_context_always_display false
set -U tide_context_bg_color normal
set -U tide_context_color_default D7AF87
set -U tide_context_color_root D7AF00
set -U tide_context_color_ssh D7AF87
set -U tide_context_hostname_parts 1

# Jobs
set -U tide_jobs_bg_color normal
set -U tide_jobs_color 5FAF00
set -U tide_jobs_icon ""
set -U tide_jobs_number_threshold 1000

# Node
set -U tide_node_bg_color normal
set -U tide_node_color 44883E
set -U tide_node_icon ""

# Python
set -U tide_python_bg_color normal
set -U tide_python_color 00AFAF
set -U tide_python_icon "\U000f0320"

# Kubectl
set -U tide_kubectl_bg_color normal
set -U tide_kubectl_color 326CE5
set -U tide_kubectl_icon "\U000f10fe"

# Time
set -U tide_time_bg_color normal
set -U tide_time_color 5F8787
set -U tide_time_format '%T'

# AWS
set -U tide_aws_bg_color normal
set -U tide_aws_color FF9900
set -U tide_aws_icon ""

# Bun
set -U tide_bun_bg_color normal
set -U tide_bun_color FBF0DF
set -U tide_bun_icon "\U000f0cd3"

# Crystal
set -U tide_crystal_bg_color normal
set -U tide_crystal_color FFFFFF
set -U tide_crystal_icon ""

# Direnv
set -U tide_direnv_bg_color normal
set -U tide_direnv_bg_color_denied normal
set -U tide_direnv_color D7AF00
set -U tide_direnv_color_denied FF0000
set -U tide_direnv_icon "▼"

# Distrobox
set -U tide_distrobox_bg_color normal
set -U tide_distrobox_color FF00FF
set -U tide_distrobox_icon "\U000f01a7"

# Docker
set -U tide_docker_bg_color normal
set -U tide_docker_color 2496ED
set -U tide_docker_default_contexts default colima
set -U tide_docker_icon ""

# Elixir
set -U tide_elixir_bg_color normal
set -U tide_elixir_color 4E2A8E
set -U tide_elixir_icon ""

# Gcloud
set -U tide_gcloud_bg_color normal
set -U tide_gcloud_color 4285F4
set -U tide_gcloud_icon "\U000f02ad"

# Go
set -U tide_go_bg_color normal
set -U tide_go_color 00ACD7
set -U tide_go_icon ""

# Java
set -U tide_java_bg_color normal
set -U tide_java_color ED8B00
set -U tide_java_icon ""

# Nix shell
set -U tide_nix_shell_bg_color normal
set -U tide_nix_shell_color 7EBAE4
set -U tide_nix_shell_icon ""

# PHP
set -U tide_php_bg_color normal
set -U tide_php_color 617CBE
set -U tide_php_icon ""

# Private mode
set -U tide_private_mode_bg_color normal
set -U tide_private_mode_color FFFFFF
set -U tide_private_mode_icon "\U000f05f9"

# Pulumi
set -U tide_pulumi_bg_color normal
set -U tide_pulumi_color F7BF2A
set -U tide_pulumi_icon ""

# Ruby
set -U tide_ruby_bg_color normal
set -U tide_ruby_color B31209
set -U tide_ruby_icon ""

# Rust
set -U tide_rustc_bg_color normal
set -U tide_rustc_color F74C00
set -U tide_rustc_icon ""

# Shell level
set -U tide_shlvl_bg_color normal
set -U tide_shlvl_color d78700
set -U tide_shlvl_icon ""
set -U tide_shlvl_threshold 1

# Terraform
set -U tide_terraform_bg_color normal
set -U tide_terraform_color 844FBA
set -U tide_terraform_icon "\U000f1062"

# Toolbox
set -U tide_toolbox_bg_color normal
set -U tide_toolbox_color 613583
set -U tide_toolbox_icon ""

# Vi mode
set -U tide_vi_mode_bg_color_default normal
set -U tide_vi_mode_bg_color_insert normal
set -U tide_vi_mode_bg_color_replace normal
set -U tide_vi_mode_bg_color_visual normal
set -U tide_vi_mode_color_default 949494
set -U tide_vi_mode_color_insert 87AFAF
set -U tide_vi_mode_color_replace 87AF87
set -U tide_vi_mode_color_visual FF8700
set -U tide_vi_mode_icon_default D
set -U tide_vi_mode_icon_insert I
set -U tide_vi_mode_icon_replace R
set -U tide_vi_mode_icon_visual V

# Zig
set -U tide_zig_bg_color normal
set -U tide_zig_color F7A41D
set -U tide_zig_icon ""

echo "✓ Tide configuré"
