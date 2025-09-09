#!/bin/bash

echo "🔁 Installing dev packages..."
sudo apt update && sudo apt install -y \
  git python3-pip python3 pipx
