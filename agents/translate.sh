#!/bin/bash
# Warp Shell - Translation Agent
# AI-powered translation assistant

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config
CONFIG_FILE="$HOME/.config/warp-shell/machine.conf"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Machine config not found. Run: just install-ai" >&2
    exit 1
fi

source "$CONFIG_FILE"
MODEL="${AI_MODEL_TRANSLATE:-llama3.2:3b}"

# Language names mapping
declare -A LANG_NAMES=(
    ["fr"]="français"
    ["en"]="anglais"
    ["es"]="espagnol"
    ["de"]="allemand"
    ["it"]="italien"
    ["pt"]="portugais"
    ["ru"]="russe"
    ["ja"]="japonais"
    ["zh"]="chinois"
)

# Parse arguments
TARGET_LANG=""
SOURCE_LANG="auto"
INPUT_FILE=""
OUTPUT_FILE=""
TEXT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --to)
            TARGET_LANG="$2"
            shift 2
            ;;
        --from)
            SOURCE_LANG="$2"
            shift 2
            ;;
        --file)
            INPUT_FILE="$2"
            shift 2
            ;;
        --output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        *)
            TEXT="$1"
            shift
            ;;
    esac
done

# Validate target language
if [ -z "$TARGET_LANG" ]; then
    echo "❌ Error: --to <language> is required" >&2
    echo "Usage: $0 \"text\" --to <lang> [--from <lang>]" >&2
    echo "       $0 --file <path> --to <lang> [--output <path>]" >&2
    echo "Supported languages: fr, en, es, de, it, pt, ru, ja, zh" >&2
    exit 1
fi

TARGET_NAME="${LANG_NAMES[$TARGET_LANG]:-$TARGET_LANG}"

# Load system prompt
PROMPT_FILE="$SCRIPT_DIR/config/prompts/translate.txt"
if [ -f "$PROMPT_FILE" ]; then
    SYSTEM_PROMPT=$(cat "$PROMPT_FILE")
else
    SYSTEM_PROMPT="You are an expert multilingual translator. Provide accurate, natural, and context-appropriate translations."
fi

# Handle file translation
if [ -n "$INPUT_FILE" ]; then
    if [ ! -f "$INPUT_FILE" ]; then
        echo "❌ File not found: $INPUT_FILE" >&2
        exit 1
    fi
    TEXT=$(cat "$INPUT_FILE")
fi

# Read from stdin if no text provided
if [ -z "$TEXT" ] && [ -z "$INPUT_FILE" ]; then
    if [ ! -t 0 ]; then
        TEXT=$(cat)
    else
        echo "❌ Error: No text provided (use argument, --file, or stdin)" >&2
        exit 1
    fi
fi

# Build prompt
if [ "$SOURCE_LANG" = "auto" ]; then
    USER_PROMPT="Translate the following text to $TARGET_NAME. Auto-detect the source language.

Text to translate:
$TEXT

Provide ONLY the translation, no explanations or comments."
else
    SOURCE_NAME="${LANG_NAMES[$SOURCE_LANG]:-$SOURCE_LANG}"
    USER_PROMPT="Translate this text from $SOURCE_NAME to $TARGET_NAME:

$TEXT

Provide ONLY the translation, no explanations or comments."
fi

echo "🌍 Translating to $TARGET_NAME with $MODEL..." >&2
echo "" >&2

# Translate
TRANSLATION=$(ollama run "$MODEL" "$SYSTEM_PROMPT

$USER_PROMPT")

# Output
if [ -n "$OUTPUT_FILE" ]; then
    echo "$TRANSLATION" > "$OUTPUT_FILE"
    echo "✅ Translated file: $OUTPUT_FILE" >&2
else
    echo "$TRANSLATION"
fi
