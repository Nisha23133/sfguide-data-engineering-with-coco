#!/bin/bash
# PreToolUse hook: block dbt commands that target production.
# CoCo pipes the tool call to stdin as JSON. Exit code 2 = block; stderr = reason shown to the agent.

INPUT=$(cat)

# Pull out the bash command text; fall back to the raw JSON if parsing fails.
COMMAND=$(printf '%s' "$INPUT" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get("tool_input", {}).get("command", ""))
except Exception:
    print("")
' 2>/dev/null)
[ -z "$COMMAND" ] && COMMAND="$INPUT"

if echo "$COMMAND" | grep -Eq 'dbt.*(--target|-t)[ =]+prod($|[^A-Za-z0-9_-])'; then
  echo "Direct production dbt runs are not allowed. Use the CI/CD pipeline (open a pull request) to deploy to production." >&2
  exit 2
fi

exit 0
