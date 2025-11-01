#!/bin/bash
# AI Agent: Jira Ticket Generator

set -e

if [ -z "$1" ]; then
  echo "Usage: jira-ticket.sh <feature description>"
  exit 1
fi

DESCRIPTION="$1"

# Check if Ollama is running
if ! pgrep -x ollama >/dev/null; then
  echo "⚠️  Ollama not running. Starting..."
  nohup ollama serve > /tmp/ollama.log 2>&1 &
  sleep 2
fi

# Load template if exists
TEMPLATE_FILE="$(dirname "$0")/../templates/jira-ticket.md"
TEMPLATE=""
if [ -f "$TEMPLATE_FILE" ]; then
  TEMPLATE=$(cat "$TEMPLATE_FILE")
fi

echo "🎫 Generating Jira ticket..."
echo ""

ollama run dolphin-mistral "You are a technical product manager. Generate a well-structured Jira ticket for the following feature.

Feature: $DESCRIPTION

Use this template structure:
$TEMPLATE

Output should be in markdown format and include:
- Title (concise and clear)
- Description (what and why)
- Acceptance Criteria (as checklist)
- Technical Notes (implementation hints)
- Story Points estimation

Be professional and concise."
