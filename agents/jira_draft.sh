#!/bin/bash
# Warp Shell - Jira Draft Agent
# Helps draft Jira tickets with best practices

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load config
CONFIG_FILE="$HOME/.config/warp-shell/machine.conf"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Machine config not found. Run: just install-ai" >&2
    exit 1
fi

source "$CONFIG_FILE"
MODEL="${AI_MODEL_DEFAULT:-llama3.2:3b}"

# Parse arguments
LANG="fr"
INTERACTIVE=false
DESCRIPTION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --lang)
            LANG="$2"
            shift 2
            ;;
        --interactive)
            INTERACTIVE=true
            shift
            ;;
        *)
            DESCRIPTION="$1"
            shift
            ;;
    esac
done

# Load system prompt
PROMPT_FILE="$SCRIPT_DIR/config/prompts/jira_${LANG}.txt"
if [ -f "$PROMPT_FILE" ]; then
    SYSTEM_PROMPT=$(cat "$PROMPT_FILE")
else
    SYSTEM_PROMPT="You are an expert in writing professional Jira tickets."
fi

# Interactive mode
if [ "$INTERACTIVE" = true ]; then
    echo "🎯 Interactive mode - Let's answer some questions:"
    echo ""
    
    echo "❓ What is the main subject of the ticket?"
    read -r SUBJECT
    
    echo "❓ What is the context or problem to solve?"
    read -r CONTEXT
    
    echo "❓ What are the objectives or expected results?"
    read -r GOALS
    
    echo "❓ Are there any technical constraints or dependencies?"
    read -r CONSTRAINTS
    
    USER_PROMPT="Write a complete Jira ticket based on this information:

Subject: ${SUBJECT:-Not specified}
Context: ${CONTEXT:-Not specified}
Objectives: ${GOALS:-Not specified}
Constraints: ${CONSTRAINTS:-None}

Create a professional and structured ticket."
else
    if [ -z "$DESCRIPTION" ]; then
        echo "❌ Error: description required (or use --interactive)" >&2
        echo "Usage: $0 \"Task description\" [--lang fr|en]" >&2
        echo "       $0 --interactive [--lang fr|en]" >&2
        exit 1
    fi
    
    USER_PROMPT="Write a complete and structured Jira ticket for this task:

$DESCRIPTION

The ticket must include:
- Clear and actionable title
- Context/Background
- Detailed description
- Acceptance criteria
- Technical impact (if applicable)"
fi

# Generate ticket
echo "🤖 Generating ticket with $MODEL..."
echo ""

ollama run "$MODEL" "$SYSTEM_PROMPT

$USER_PROMPT"

echo ""
echo "=================================================="
echo "📋 Ticket ready to copy to Jira!"
echo "=================================================="
echo ""
