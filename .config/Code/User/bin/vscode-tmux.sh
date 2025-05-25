# --- VS Code Tmux Auto-Attach ---
# This block attempts to attach to a specific tmux session
# only when run inside a VS Code terminal ($TERM_PROGRAM is 'vscode')
# and not already in a tmux session.

# Check if we are in a VS Code integrated terminal
if [ "$TERM_PROGRAM" = "vscode" ]; then
    VSCODE_CWD="$PWD"
    SESSION_NAME=$(basename "$VSCODE_CWD" | tr . _)
    # Capture the current directory of the VS Code terminal

    # check if the target session exists
    tmux has-session -t "$SESSION_NAME" 2>/dev/null
    if [ $? -eq 0 ]; then
        # Session exists, attach to it.
        exec tmux attach -t "$SESSION_NAME"
    else
        # Session does not exist, create a new one and attach.
        # Use -c to set the initial directory for the new session's first window.
        exec tmux-sessionizer $VSCODE_CWD
    fi
fi
# --- End VS Code Tmux Auto-Attach ---
