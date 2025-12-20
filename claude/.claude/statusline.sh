#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract directory name
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
dir_name=$(basename "$current_dir")

# Get git branch info
git_branch=""
if git -C "$current_dir" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$current_dir" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || \
             git -C "$current_dir" --no-optional-locks rev-parse --short HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
        # Check if there are uncommitted changes
        if ! git -C "$current_dir" --no-optional-locks diff --quiet 2>/dev/null || \
           ! git -C "$current_dir" --no-optional-locks diff --cached --quiet 2>/dev/null; then
            git_branch=" git:($(printf '\033[33m%s\033[0m' "$branch")✗)"
        else
            git_branch=" git:($branch)"
        fi
    fi
fi

# Extract model info
model=$(echo "$input" | jq -r '.model.display_name')
output_style=$(echo "$input" | jq -r '.output_style.name')

# Calculate context usage percentage
context_info=""
usage=$(echo "$input" | jq '.context_window.current_usage')
if [ "$usage" != "null" ]; then
    current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    size=$(echo "$input" | jq '.context_window.context_window_size')

    if [ "$current" != "null" ] && [ "$size" != "null" ] && [ "$size" -gt 0 ]; then
        pct=$((current * 100 / size))
        context_info=" | ctx:${pct}%"
    fi
fi

# Add output style if not default
style_info=""
if [ "$output_style" != "null" ] && [ "$output_style" != "default" ]; then
    style_info=" | style:$output_style"
fi

# Output formatted status line
printf '\033[36m%s\033[0m%s \033[90m[%s%s%s]\033[0m' \
    "$dir_name" \
    "$git_branch" \
    "$model" \
    "$context_info" \
    "$style_info"
