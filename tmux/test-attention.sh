#!/bin/bash
# Tests for tmux attention system
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
SESSION="test-attention-$$"
PASSED=0
FAILED=0

trap 'tmux kill-session -t "$SESSION" 2>/dev/null || true' EXIT

setup() {
    tmux new-session -d -s "$SESSION" -x 80 -y 24
    tmux set-hook -t "$SESSION" -g pane-focus-in "set-option -w @attention 0"
    tmux set -t "$SESSION" -g focus-events on
}

assert_eq() {
    local name=$1 expected=$2 actual=$3
    if [[ "$expected" == "$actual" ]]; then
        echo -e "${GREEN}PASS${NC}: $name"
        ((++PASSED))
    else
        echo -e "${RED}FAIL${NC}: $name (expected '$expected', got '$actual')"
        ((++FAILED))
    fi
}

get_attention() {
    tmux display-message -t "${1:-$SESSION}" -p '#{@attention}'
}

test_default_attention() {
    assert_eq "default @attention is empty" "" "$(get_attention)"
}

test_set_attention() {
    tmux set-option -w -t "$SESSION" @attention 1
    assert_eq "set @attention=1" "1" "$(get_attention)"
}

test_hook_clears_attention() {
    tmux set-option -w -t "$SESSION" @attention 1
    tmux set-option -w -t "$SESSION" @attention 0
    assert_eq "hook command clears @attention" "0" "$(get_attention)"
}

test_notify_sets_attention() {
    local window_id
    window_id=$(tmux display-message -t "$SESSION" -p '#{window_id}')
    tmux set-option -w -t "$window_id" @attention 1
    assert_eq "notify sets @attention=1" "1" "$(get_attention)"
}

test_multiwindow_attention() {
    tmux new-window -t "$SESSION"
    local win1 win2
    win1=$(tmux display-message -t "$SESSION:1" -p '#{window_id}')
    win2=$(tmux display-message -t "$SESSION:2" -p '#{window_id}')

    tmux set-option -w -t "$win1" @attention 1
    tmux set-option -w -t "$win2" @attention 0

    assert_eq "window 1 has attention" "1" "$(get_attention "$SESSION:1")"
    assert_eq "window 2 has no attention" "0" "$(get_attention "$SESSION:2")"
}

# Run tests
echo "=== Tmux Attention System Tests ==="
setup
test_default_attention
test_set_attention
test_hook_clears_attention
test_notify_sets_attention
test_multiwindow_attention

echo ""
echo "=== Results: $PASSED passed, $FAILED failed ==="
[[ $FAILED -eq 0 ]]
