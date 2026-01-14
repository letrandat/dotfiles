#!/bin/bash
# Claude Code statusline - displays directory, git, model, cost, style, session time

input=$(cat)

# Color helpers
use_color=1
[ -n "$NO_COLOR" ] && use_color=0

color() {
  if [ "$use_color" -eq 1 ]; then
    printf '\033[38;5;%sm' "$1"
  fi
}

rst() {
  if [ "$use_color" -eq 1 ]; then
    printf '\033[0m'
  fi
}

# Color palette
DIR_COLOR=117      # sky blue
GIT_COLOR=150      # soft green
MODEL_COLOR=147    # light purple
COST_COLOR=222     # light gold
STYLE_COLOR=245    # gray

# Extract data from Claude Code JSON input
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "unknown"' | sed "s|^$HOME|~|g")
model_name=$(echo "$input" | jq -r '.model.display_name // "Claude"')
output_style=$(echo "$input" | jq -r '.output_style.name // ""')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')

# Context window percentage
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
usage=$(echo "$input" | jq '.context_window.current_usage')
context_pct=0
context_color=158  # mint green (default)

if [ "$usage" != "null" ] && [ -n "$usage" ]; then
  current_tokens=$(echo "$usage" | jq '(.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0)')
  if [ -n "$current_tokens" ] && [ "$current_tokens" -gt 0 ] 2>/dev/null; then
    context_pct=$((current_tokens * 100 / context_size))
    remaining=$((100 - context_pct))
    if [ "$remaining" -le 20 ]; then
      context_color=203  # coral red
    elif [ "$remaining" -le 40 ]; then
      context_color=215  # peach
    fi
  fi
fi

# Git branch with dirty indicator
git_info=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git branch --show-current 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  if [ -n "$branch" ]; then
    dirty=""
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
      dirty="*"
    fi
    git_info="${branch}${dirty}"
  fi
fi

# Session time from ccusage (optional)
session_txt=""
if command -v ccusage >/dev/null 2>&1; then
  blocks_output=""
  if command -v timeout >/dev/null 2>&1; then
    blocks_output=$(timeout 5s ccusage blocks --json 2>/dev/null)
  elif command -v gtimeout >/dev/null 2>&1; then
    blocks_output=$(gtimeout 5s ccusage blocks --json 2>/dev/null)
  else
    blocks_output=$(ccusage blocks --json 2>/dev/null)
  fi

  if [ -n "$blocks_output" ]; then
    active_block=$(echo "$blocks_output" | jq -c '.blocks[] | select(.isActive == true)' 2>/dev/null | head -n1)
    if [ -n "$active_block" ]; then
      reset_time=$(echo "$active_block" | jq -r '.usageLimitResetTime // .endTime // empty')
      if [ -n "$reset_time" ]; then
        now_sec=$(date +%s)
        # Parse ISO timestamp to epoch
        end_sec=""
        if command -v gdate >/dev/null 2>&1; then
          end_sec=$(gdate -d "$reset_time" +%s 2>/dev/null)
        else
          end_sec=$(date -u -j -f "%Y-%m-%dT%H:%M:%S%z" "${reset_time/Z/+0000}" +%s 2>/dev/null)
        fi
        if [ -n "$end_sec" ]; then
          remaining_sec=$((end_sec - now_sec))
          if [ "$remaining_sec" -gt 0 ]; then
            hours=$((remaining_sec / 3600))
            mins=$(((remaining_sec % 3600) / 60))
            session_txt="${hours}h ${mins}m"
          fi
        fi
      fi
    fi
  fi
fi

# Render statusline
printf '%s%s%s' "$(color $DIR_COLOR)" "$current_dir" "$(rst)"

if [ -n "$git_info" ]; then
  printf ' · ⎇ %s%s%s' "$(color $GIT_COLOR)" "$git_info" "$(rst)"
fi

printf ' · %s%s%s %s%s%%%s' "$(color $MODEL_COLOR)" "$model_name" "$(rst)" "$(color $context_color)" "$context_pct" "$(rst)"

if [ -n "$cost_usd" ]; then
  cost_formatted=$(printf '%.2f' "$cost_usd")
  printf ' · %s$%s%s' "$(color $COST_COLOR)" "$cost_formatted" "$(rst)"
fi

if [ -n "$output_style" ] && [ "$output_style" != "null" ] && [ "$output_style" != "default" ]; then
  printf ' · 🎨 %s%s%s' "$(color $STYLE_COLOR)" "$output_style" "$(rst)"
fi

if [ -n "$session_txt" ]; then
  printf ' · %s%s' "$(color $STYLE_COLOR)" "$session_txt$(rst)"
fi

printf '\n'
