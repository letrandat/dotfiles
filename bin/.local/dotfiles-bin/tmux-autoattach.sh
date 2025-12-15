# --- Tmux Auto-Attach ---
# Automatically attach to or create a tmux session when launching
# supported terminals (VS Code-like editors, Ghostty).
# Session name follows the `parent-child` pattern based on PWD.

# Check if we are in a supported terminal
if [ "$TERM_PROGRAM" = "vscode" ] || [ "$TERM_PROGRAM" = "ghostty" ]; then
    # Capture the current directory
    CWD="$PWD"
    PARENT_DIR=$(basename "$(dirname "$CWD")")
    PROJECT_DIR=$(basename "$CWD")
    SESSION_NAME="${PARENT_DIR}-${PROJECT_DIR}"
    SESSION_NAME=$(echo "$SESSION_NAME" | tr . _)

    # check if the target session exists
    tmux has-session -t "$SESSION_NAME" 2>/dev/null
    if [ $? -eq 0 ]; then
        # Session exists, attach to it.
        # 'exec' replaces the current shell process with tmux.
        exec tmux attach -t "$SESSION_NAME"
    else
        # Session does not exist, create a new one and attach.
        # Use -c to set the initial directory for the new session's first window.
        # 'exec' replaces the current shell process with tmux.
        exec tmux new-session -c "$CWD" -s "$SESSION_NAME"
    fi
fi
# --- End Tmux Auto-Attach ---
