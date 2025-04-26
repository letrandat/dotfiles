# --- VS Code Tmux Auto-Attach ---
# This block attempts to attach to a specific tmux session
# only when run inside a VS Code terminal ($TERM_PROGRAM is 'vscode')
# and not already in a tmux session.

# Check if we are in a VS Code integrated terminal
if [ "$TERM_PROGRAM" = "vscode" ]; then
    SESSION_NAME="vscode"
    # Capture the current directory of the VS Code terminal
    VSCODE_CWD="$PWD"

    # check if the target session exists
    tmux has-session -t "$SESSION_NAME" 2>/dev/null
    if [ $? -eq 0 ]; then
        # Session exists, attach to it.
        # Send the cd command to the current pane of the current window in the session.
        # Use double quotes around $VSCODE_CWD to handle spaces or special characters in the path.
        # C-m simulates pressing Enter.
        # This command is sent *before* the attach happens.
        tmux send-keys -t "$SESSION_NAME:." "cd \"$VSCODE_CWD\"" C-m
        # 'exec' replaces the current shell process with tmux.
        exec tmux attach -t "$SESSION_NAME"
    else
        # Session does not exist, create a new one and attach.
        # Use -c to set the initial directory for the new session's first window.
        # 'exec' replaces the current current process with tmux.
        exec tmux new-session -c "$VSCODE_CWD" -s "$SESSION_NAME"
    fi
fi
# --- End VS Code Tmux Auto-Attach ---