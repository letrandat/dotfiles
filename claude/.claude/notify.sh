#!/bin/bash
# Claude Code notification hook - sets tmux attention flag
set -euo pipefail

# Drain stdin (hook sends JSON but we don't need it)
cat > /dev/null

# Set attention flag on current tmux window (persists until focused)
if [ -n "${TMUX:-}" ] && [ -n "${TMUX_PANE:-}" ]; then
    window_id=$(tmux display-message -p -t "$TMUX_PANE" '#{window_id}')
    tmux set-option -w -t "$window_id" @attention 1
fi
