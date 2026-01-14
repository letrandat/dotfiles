#!/bin/bash
# Claude Code PostToolUse hook - runs pre-commit on edited files
# Exit 0: Pre-commit passed, no changes (silent)
# Exit 2: Pre-commit auto-fixed or failed (interrupt Claude with message)

# Read stdin JSON from Claude Code
input=$(cat)

# Extract file path from tool_input.file_path
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

# Graceful exit if JSON parsing failed or no file_path
if [ -z "$file_path" ]; then
  exit 0
fi

# Graceful exit if file doesn't exist (may have been deleted)
if [ ! -f "$file_path" ]; then
  exit 0
fi

# Graceful exit if pre-commit not installed
if ! command -v pre-commit >/dev/null 2>&1; then
  exit 0
fi

# Capture file checksum BEFORE running pre-commit
checksum_before=$(shasum "$file_path" 2>/dev/null | awk '{print $1}')

# Run pre-commit on the specific file
precommit_output=$(pre-commit run --files "$file_path" 2>&1)
precommit_exit=$?

# Capture file checksum AFTER (empty if file deleted)
checksum_after=$(shasum "$file_path" 2>/dev/null | awk '{print $1}')

# Determine outcome and exit
if [ "$checksum_before" != "$checksum_after" ]; then
  if [ ! -f "$file_path" ]; then
    echo "Pre-commit removed file: $file_path" >&2
  else
    echo "Pre-commit auto-fixed: $file_path" >&2
    echo "Re-read the file to see changes." >&2
  fi
  exit 2
elif [ "$precommit_exit" -ne 0 ]; then
  echo "Pre-commit failed: $file_path" >&2
  echo "$precommit_output" >&2
  exit 2
fi
