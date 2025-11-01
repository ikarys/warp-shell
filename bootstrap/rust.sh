#!/bin/bash
# Rust toolchain and cargo-based tools

set -e

echo "🦀 Installing Rust toolchain..."

# Install Rust via rustup
if ! command -v rustc &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
  source "$HOME/.cargo/env"
else
  echo "✓ Rust already installed"
fi

# Ensure cargo is in path
export PATH="$HOME/.cargo/bin:$PATH"

# Install Rust-based CLI tools for performance
echo "⚡ Installing fast Rust-based CLI tools..."

RUST_TOOLS=(
  "du-dust"        # Better du
  "procs"          # Better ps
  "tokei"          # Code line counter
  "onefetch"       # Git repo info
  "macchina"       # System info
  "hyperfine"      # Benchmarking
  "git-delta"      # Better git diff
)

for tool in "${RUST_TOOLS[@]}"; do
  if ! command -v ${tool} &>/dev/null; then
    echo "Installing ${tool}..."
    cargo install ${tool}
  else
    echo "✓ ${tool} already installed"
  fi
done

echo "✅ Rust toolchain and tools installed"
