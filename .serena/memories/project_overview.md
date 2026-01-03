# Project Overview

## Purpose

This is a personal dotfiles repository for managing and syncing configuration files across different machines. The repository follows the GNU Stow package management approach, making it easy to selectively deploy configurations.

## Key Features

- **GNU Stow-based**: Each top-level directory represents a "package" that can be independently stowed/unstowed
- **XDG Base Directory compliant**: Uses `$XDG_CONFIG_HOME` (`~/.config`) to keep home directory clean
- **Cross-platform**: Primarily macOS-focused but designed with portability in mind
- **Unified workflow**: Consistent tmux session management across editors and terminals
- **Which-Key integration**: Unified keybinding system across Neovim and VS Code/Windsurf

## Repository Structure

The repository mirrors the exact directory structure that should exist in the home directory:

```
Repository path                    -> Home directory path
./ghostty/config                  -> ~/.ghostty/config
./kitty/kitty.conf               -> ~/.kitty/kitty.conf
./nvim/.config/nvim              -> ~/.config/nvim
```

## Main Components

### Configuration Packages

- **nvim**: Neovim configuration (LazyVim-based)
- **zsh**: Shell configuration (Oh My Zsh-based)
- **git**: Git configuration
- **tmux**: Terminal multiplexer configuration
- **kitty/ghostty**: Terminal emulator configs
- **vscode/windsurf/antigravity**: Editor configurations
- **lazygit**: Git TUI configuration
- **ideavim**: IntelliJ Vim emulation
- **codeium/amp**: AI coding assistant configs

### Special Directories

- **bin**: Executable scripts (e.g., tmux-sessionizer)
- **docs**: Documentation and design plans
- **skills**: Agent skills for openskills integration
- **.github**: GitHub-specific files (copilot instructions)

## Setup Process

Run `./setup.sh` to:

1. Install GNU Stow (via Homebrew) if missing
2. Create necessary directories
3. Set up macOS Application Support symlinks
4. Stow all packages to home directory

## Tmux Sessionizer Ecosystem

A unified terminal session management system:

- Auto-attach on terminal spawn
- Session naming: `parent_child` pattern based on directory
- fzf-powered session switcher
- Per-project hydration via `.tmux-sessionizer` files

## Git Worktree Workflow

Supports working on multiple branches simultaneously using git worktrees with Which-Key integration for creation and management.
