#!/bin/bash
# Claude Code notification hook
# - Immediate: sets tmux @attention flag + bell
# - Delayed (30s): desktop notification if still waiting
set -euo pipefail

DEFAULT_MESSAGE="Claude needs your input!"

# Read notification data from stdin and extract message
message=$(cat | jq -r ".message // \"$DEFAULT_MESSAGE\"" 2>/dev/null) || message="$DEFAULT_MESSAGE"

# Build title with tmux context if available
title="Claude Code"
if [ -n "${TMUX:-}" ]; then
    session=$(tmux display-message -p '#{session_name}')
    window=$(tmux display-message -p '#{window_index}')
    name=$(tmux display-message -p '#{window_name}')
    title="Claude Code [${session}:${window}:${name}]"
fi

# Set attention flag and ring bell (immediate feedback)
if [ -n "${TMUX:-}" ] && [ -n "${TMUX_PANE:-}" ]; then
    window_id=$(tmux display-message -p -t "$TMUX_PANE" '#{window_id}')
    tmux set-option -w -t "$window_id" @attention 1

    # Tmux alert: bell + status message
    printf '\a'
    tmux display-message "Claude Code needs attention"

    # Background: desktop notification after 30s if still waiting
    (
        sleep 30
        if [ "$(tmux show-option -wqv -t "$window_id" @attention)" = "1" ]; then
            # Desktop notification: prefer terminal-notifier (click-to-focus), fallback to osascript
            if command -v terminal-notifier &>/dev/null; then
                terminal-notifier \
                    -title "$title" \
                    -message "$message" \
                    -sound "Ping" \
                    -activate com.mitchellh.ghostty
            else
                osascript -e "display notification \"$message\" with title \"$title\" sound name \"Ping\""
            fi
        fi
    ) &>/dev/null &
fi
