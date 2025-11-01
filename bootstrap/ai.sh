#!/bin/bash
# AI tools: Ollama for local LLM agents

set -e

echo "🤖 Setting up AI tools (Ollama)..."

# Install Ollama
if ! command -v ollama &>/dev/null; then
  echo "📦 Installing Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
else
  echo "✓ Ollama already installed"
fi

# Start Ollama service (if not running)
if ! pgrep -x ollama >/dev/null; then
  echo "🚀 Starting Ollama service..."
  nohup ollama serve > /tmp/ollama.log 2>&1 &
  sleep 2
fi

# Pull recommended models for agents
echo "📦 Pulling recommended models..."

# Dolphin - great for coding and general tasks
if ! ollama list | grep -q "dolphin-mistral"; then
  echo "🐬 Pulling dolphin-mistral (7B - good for agents)..."
  ollama pull dolphin-mistral
fi

# Mistral - fast and efficient
if ! ollama list | grep -q "mistral"; then
  echo "🌪️  Pulling mistral (7B - very fast)..."
  ollama pull mistral
fi

echo "✅ AI tools setup complete"
echo ""
echo "💡 Available models:"
ollama list
echo ""
echo "💡 Test with: ollama run dolphin-mistral"
