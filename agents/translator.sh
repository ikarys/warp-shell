#!/bin/bash
# AI Agent: Translator (French <-> English)

set -e

if [ -z "$1" ]; then
  echo "Usage: translator.sh <text>"
  exit 1
fi

TEXT="$1"

# Check if Ollama is running
if ! pgrep -x ollama >/dev/null; then
  echo "⚠️  Ollama not running. Starting..."
  nohup ollama serve > /tmp/ollama.log 2>&1 &
  sleep 2
fi

echo "🔄 Translating..."
echo ""

ollama run dolphin-mistral "Translate the following text. If it's in French, translate to English. If it's in English, translate to French. Only output the translation, nothing else.

Text: $TEXT"
