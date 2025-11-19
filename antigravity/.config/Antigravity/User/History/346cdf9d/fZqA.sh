#!/bin/bash

# setup.sh
# Automates the symlinking of dotfiles using GNU Stow.

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Setting up dotfiles from $DOTFILES_DIR..."

# 1. Install GNU Stow if missing
if ! command -v stow &> /dev/null; then
    echo "GNU Stow not found. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install stow
    else
        echo "Error: Homebrew not found. Please install Homebrew or GNU Stow manually."
        exit 1
    fi
fi

# 2. Ensure ~/.config exists
mkdir -p "$HOME/.config"

# 3. MacOS Application Support Symlinks
# We link these to ~/.config so Stow can manage them normally
echo "Setting up macOS Application Support links..."

# Function to link App Support to .config
link_app_support() {
    local app_name="$1"
    local config_name="$2" # e.g., "Code" or "Antigravity"
    local app_support_path="$HOME/Library/Application Support/$app_name/User"
    local config_path="$HOME/.config/$config_name/User"

    # Only proceed if on macOS
    if [[ "$OSTYPE" != "darwin"* ]]; then
        return
    fi

    # Create the config path parent if needed (stow will fill it, but we need the dir for the link)
    mkdir -p "$(dirname "$config_path")"

    # If the App Support folder exists and is a real directory (not a symlink), backup or warn
    if [ -d "$app_support_path" ] && [ ! -L "$app_support_path" ]; then
        echo "Backing up existing $app_name User settings..."
        mv "$app_support_path" "${app_support_path}.backup_$(date +%Y%m%d)"
    fi

    # Create the symlink: App Support/User -> ~/.config/App/User
    # We need to ensure the parent directory exists in App Support
    mkdir -p "$(dirname "$app_support_path")"

    if [ ! -L "$app_support_path" ]; then
        echo "Linking $app_name User config to ~/.config/$config_name/User"
        ln -s "$config_path" "$app_support_path"
    fi
}

link_app_support "Code" "Code"
link_app_support "Windsurf" "Windsurf"
link_app_support "Antigravity" "Antigravity"

# 4. Run Stow for all packages
PACKAGES=(
    zsh
    git
    tmux
    ideavim
    nvim
    kitty
    ghostty
    lazygit
    intellimacs
    bin
    vscode
    windsurf
    antigravity
)

echo "Stowing packages..."
for pkg in "${PACKAGES[@]}"; do
    echo "  - $pkg"
    # Force re-stow by removing conflicts if they are symlinks
    # Stow will complain if we don't clean up first
    stow -d "$DOTFILES_DIR" -t "$HOME" --adopt "$pkg" 2>/dev/null || {
        echo "    Conflict detected. Resetting package $pkg..."
        stow -d "$DOTFILES_DIR" -t "$HOME" -D "$pkg" 2>/dev/null
        stow -d "$DOTFILES_DIR" -t "$HOME" --adopt "$pkg"
    }
    # Reset any changes adopt might have made to the repo (optional, but good if we trust the repo)
    git checkout "$DOTFILES_DIR/$pkg" 2>/dev/null
done

echo "Done! Dotfiles configured via GNU Stow."
