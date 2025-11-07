#!/bin/bash
# Warp Shell - Code Review Agent
# AI-powered code review assistant

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config
CONFIG_FILE="$HOME/.config/warp-shell/machine.conf"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Machine config not found. Run: just install-ai" >&2
    exit 1
fi

source "$CONFIG_FILE"
MODEL="${AI_MODEL_CODE:-codellama:7b}"

# Parse arguments
COMMIT="staged"

while [[ $# -gt 0 ]]; do
    case $1 in
        --commit)
            COMMIT="$2"
            shift 2
            ;;
        *)
            shift
            ;;
    esac
done

# Check if in git repo
if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "❌ Not in a git repository" >&2
    exit 1
fi

# Get git diff
if [ "$COMMIT" = "staged" ]; then
    DIFF=$(git diff --cached)
else
    DIFF=$(git show "$COMMIT" 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo "❌ Invalid commit: $COMMIT" >&2
        exit 1
    fi
fi

# Check if diff is empty
if [ -z "$DIFF" ]; then
    echo "⚠️  No changes to review" >&2
    if [ "$COMMIT" = "staged" ]; then
        echo "   Tip: Stage files with 'git add'" >&2
    fi
    exit 1
fi

# Count changes
ADDITIONS=$(echo "$DIFF" | grep -c '^+' | grep -v '^+++' || echo 0)
DELETIONS=$(echo "$DIFF" | grep -c '^-' | grep -v '^---' || echo 0)

echo "📊 Changes: +$ADDITIONS -$DELETIONS lines"
echo "🤖 Reviewing with $MODEL..."
echo ""

# Load system prompt
PROMPT_FILE="$SCRIPT_DIR/config/prompts/code_review.txt"
if [ -f "$PROMPT_FILE" ]; then
    SYSTEM_PROMPT=$(cat "$PROMPT_FILE")
else
    SYSTEM_PROMPT="You are an expert code reviewer. Provide constructive, technical, and actionable feedback."
fi

# Run review
ollama run "$MODEL" "$SYSTEM_PROMPT

Review this git diff and provide:

1. **Summary of Changes**: What was modified?
2. **Positive Points**: What is well done
3. **Potential Issues**: Bugs, security, performance
4. **Improvement Suggestions**: How to improve the code
5. **Best Practices Comments**: Conventions compliance

Diff:
\`\`\`
$DIFF
\`\`\`"

echo ""
echo "=================================================="
echo "✅ Review completed!"
echo "=================================================="
echo ""
