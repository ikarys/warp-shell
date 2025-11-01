#!/bin/bash
# AI Agent: Documentation Generator

set -e

if [ -z "$1" ]; then
  echo "Usage: doc-generator.sh <file_path or code_snippet>"
  exit 1
fi

INPUT="$1"

# Check if input is a file
if [ -f "$INPUT" ]; then
  CODE=$(cat "$INPUT")
  FILENAME=$(basename "$INPUT")
else
  CODE="$INPUT"
  FILENAME="code"
fi

# Check if Ollama is running
if ! pgrep -x ollama >/dev/null; then
  echo "⚠️  Ollama not running. Starting..."
  nohup ollama serve > /tmp/ollama.log 2>&1 &
  sleep 2
fi

echo "📝 Generating documentation..."
echo ""

ollama run dolphin-mistral "You are a technical writer. Generate clear, comprehensive documentation for the following code.

File: $FILENAME

Code:
\`\`\`
$CODE
\`\`\`

Generate documentation that includes:
1. Overview - What this code does
2. Key Functions/Classes - Main components
3. Usage Examples - How to use it
4. Parameters/Arguments - What inputs it expects
5. Returns - What outputs it produces
6. Notes - Any important considerations

Use markdown format. Be clear and concise."
