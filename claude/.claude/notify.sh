#!/bin/bash
# Claude Code notification hook - sets tmux attention flag + bell
cat > /dev/null

if [ -n "${TMUX:-}" ]; then
    tmux set-option -w @attention 1
    printf '\a'
fi
