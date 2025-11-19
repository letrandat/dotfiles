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

# Cleanup legacy links that might block stow
cleanup_legacy() {
    local target="$1"
    if [ -L "$target" ]; then
        echo "Removing legacy link: $target"
        rm "$target"
    fi
}

echo "Cleaning up legacy links..."
cleanup_legacy "$HOME/.zshrc"
cleanup_legacy "$HOME/.gitconfig"
cleanup_legacy "$HOME/.tmux.conf"
cleanup_legacy "$HOME/.ideavimrc"
cleanup_legacy "$HOME/.config/nvim"
cleanup_legacy "$HOME/.config/kitty/kitty.conf"
cleanup_legacy "$HOME/.config/ghostty/config"
cleanup_legacy "$HOME/.config/lazygit/config.yml"
cleanup_legacy "$HOME/.config/intellimacs"
cleanup_legacy "$HOME/.local/bin/tmux-sessionizer"
cleanup_legacy "$HOME/.local/bin/vscode-switcher"
cleanup_legacy "$HOME/.local/bin/vscode-tmux.sh"
cleanup_legacy "$HOME/.config/zsh/aliases.zsh"
cleanup_legacy "$HOME/.config/zsh/env.zsh"
cleanup_legacy "$HOME/.config/zsh/vscode-tmux.zsh"
cleanup_legacy "$HOME/.config/nvim-kickstart"
cleanup_legacy "$HOME/.config/nvim-vscode"
cleanup_legacy "$HOME/.config/Code/User/settings.json"
cleanup_legacy "$HOME/.config/Code/User/keybindings.json"
cleanup_legacy "$HOME/.config/Code/User/tasks.json"
cleanup_legacy "$HOME/.config/Code/User/prompts/code-gen.instructions.md"
cleanup_legacy "$HOME/.config/Windsurf/User/settings.json"
cleanup_legacy "$HOME/.config/Windsurf/User/keybindings.json"
cleanup_legacy "$HOME/.config/Antigravity/User/settings.json"
cleanup_legacy "$HOME/.config/Antigravity/User/keybindings.json"

echo "Stowing packages..."
for pkg in "${PACKAGES[@]}"; do
    echo "  - $pkg"
    stow -d "$DOTFILES_DIR" -t "$HOME" "$pkg"
done

echo "Done! Dotfiles configured via GNU Stow."
