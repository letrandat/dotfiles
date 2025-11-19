#!/bin/bash

# install_extensions.sh
# Installs VS Code extensions listed in vscode-extensions.txt
# Usage: ./install_extensions.sh [editor_command]
# Example: ./install_extensions.sh code
#          ./install_extensions.sh windsurf
#          ./install_extensions.sh antigravity

# Determine which editor to use
CMD="$1"

if [ -z "$CMD" ]; then
    echo "Select target editor:"
    echo "1) VS Code (code)"
    echo "2) Windsurf (windsurf)"
    echo "3) Antigravity (antigravity)"
    read -p "Enter choice [1-3]: " choice
    case $choice in
        1) CMD="code" ;;
        2) CMD="windsurf" ;;
        3) CMD="antigravity" ;;
        *) echo "Invalid choice"; exit 1 ;;
    esac
fi

# Select extensions file based on editor
if [ "$CMD" = "antigravity" ]; then
    EXTENSIONS_FILE="antigravity-extensions.txt"
else
    EXTENSIONS_FILE="vscode-extensions.txt"
fi

if [ ! -f "$EXTENSIONS_FILE" ]; then
    echo "Error: $EXTENSIONS_FILE not found!"
    exit 1
fi

# Verify the command exists
if ! command -v "$CMD" &> /dev/null; then
    echo "Error: Command '$CMD' not found in PATH."
    echo ""
    echo "Tip: If you are using Antigravity or Windsurf, you may need to install the shell command."
    echo "Open the Command Palette (Cmd+Shift+P) and run:"
    echo "  > Shell Command: Install '$CMD' command in PATH"
    exit 1
fi

echo "Installing extensions using '$CMD' from $EXTENSIONS_FILE..."

while IFS= read -r extension || [ -n "$extension" ]; do
    # Skip empty lines and comments
    if [[ -z "$extension" ]] || [[ "$extension" == \#* ]]; then
        continue
    fi

    echo "Installing $extension..."
    "$CMD" --install-extension "$extension"

done < "$EXTENSIONS_FILE"

echo "All extensions installed for $CMD!"
