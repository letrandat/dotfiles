# Dotfiles

This repository contains my personal dotfiles and configuration files. The repository structure mirrors the exact paths where these files would be located in the home directory (`~/`), making it easy to manage and sync configurations across different machines.

## Structure

Files in this repository are organized to match their exact paths in the home directory. For example:

```
Repository path                    -> Home directory path
./ghostty/config                  -> ~/.ghostty/config
./kitty/kitty.conf               -> ~/.kitty/kitty.conf
```

### macOS Application Support Exception

Some applications (particularly GUI applications) on macOS require their configuration files to be stored in `~/Library/Application Support/`. For these applications, I have to create customized symbolic links.

### XDG Base Directory Standard

To keep the home directory clean and cross-platform compatible, I enforce the **XDG Base Directory Specification** by setting:

```bash
export XDG_CONFIG_HOME="$HOME/.config"
```

This ensures that compliant applications (like `lazygit`, `nvim`, `alacritty`) look for their configuration in `~/.config/` instead of cluttering the home directory or using macOS-specific paths.

### Manual Setup Instructions

```bash
# Run the automated setup script
./setup.sh
```

The script will:

1. Install **GNU Stow** (via Homebrew) if missing.
2. Automatically symlink all configuration packages (zsh, nvim, git, etc.) to your home directory.
3. Handle macOS-specific "Application Support" paths (VS Code, Antigravity) by linking them to `~/.config`, allowing Stow to manage them centrally.

## Repository Structure (GNU Stow)

This repository is organized into **Stow packages**. Each top-level directory corresponds to an application and contains the exact folder structure that should be mirrored in your home directory.

### How Stow Works

Stow acts as a symlink farm manager. It takes a package directory and "folds" it onto the target directory (your home folder).

**Example: `zsh` package**

```
dotfiles/
└── zsh/
    ├── .zshrc                -> symlinks to ~/.zshrc
    └── .config/
        └── zsh/
            └── aliases.zsh   -> symlinks to ~/.config/zsh/aliases.zsh
```

### Package List

- `zsh/`: Shell configuration (`.zshrc`, aliases)
- `nvim/`: Neovim configuration (`.config/nvim`)
- `git/`: Git configuration (`.gitconfig`)
- `antigravity/`: Antigravity Agent configuration (`.config/Antigravity`)
- `vscode/`: VS Code settings (`.config/Code`)
- `windsurf/`: Windsurf settings (`.config/Windsurf`)
- `codeium/`: Codeium configuration (`.codeium`)

### Managing Dotfiles

To add a new configuration file:

1. Create the file inside the appropriate package folder in `dotfiles/`.
   _Example: `dotfiles/zsh/.config/zsh/my-new-script.zsh`_
2. Run `stow -R <package>` to refresh the links.
   _Example: `stow -R zsh`_

## Tmux Sessionizer Ecosystem

A unified terminal session management system that works across editors (VS Code, Windsurf, Antigravity) and standalone terminals (Ghostty).

### Session Naming Convention

Sessions follow a `parent_child` pattern based on the working directory:

```
~/workspace/dotfiles  →  workspace_dotfiles
~/personal/myproject  →  personal_myproject
```

This ensures the same session is accessible from any terminal, regardless of entry point.

### Auto-Attach (Terminal Integration)

When opening a terminal in VS Code-like editors or Ghostty, `tmux-autoattach.sh` automatically:

1. Creates a new tmux session if one doesn't exist for the current directory
2. Attaches to an existing session if it matches the `parent_child` pattern

**Supported terminals:** `$TERM_PROGRAM = vscode | ghostty`

### Session Switching

| Context                   | Keybinding          | Action                                  |
| ------------------------- | ------------------- | --------------------------------------- |
| Editor (VS Code/Windsurf) | `Alt+Space → j → n` | Launch `tmux-sessionizer` via Which-Key |
| Tmux (any terminal)       | `prefix + f`        | Launch `tmux-sessionizer` popup         |

`tmux-sessionizer` provides an fzf-powered interface to:

- View existing tmux sessions
- Create new sessions from project directories
- Switch between sessions instantly

### Configuration

**Config file:** `~/.config/tmux-sessionizer/tmux-sessionizer.conf`

```bash
# Override default search paths (~/workspace ~/personal)
TS_SEARCH_PATHS=(~/workspace ~/personal ~/.config)

# Add extra paths with optional depth limit (path:depth)
TS_EXTRA_SEARCH_PATHS=(~/ghq:3 ~/Git:3)

# Override default max depth (1)
TS_MAX_DEPTH=2
```

**Per-project hydration:** Create a `.tmux-sessionizer` file in your project root to run commands when that session is created.

### Quick Reference

| Script               | Purpose                               |
| -------------------- | ------------------------------------- |
| `tmux-sessionizer`   | fzf session picker/creator            |
| `tmux-autoattach.sh` | Auto-attach on terminal spawn         |
| `tmux-cheatsheet`    | Interactive tmux keybinding reference |

## VSCode Extensions

### Track installed extensions

```bash
code --list-extensions > vscode-extensions.txt
```

### re-install extensions

```bash
cat vscode-extensions.txt | xargs -L 1 code --install-extension
cat vscode-extensions.txt | xargs -L 1 windsurf --install-extension
```

## Experiment with Which-Key

- In Neovim, I use leader as normal.
- Outside of Neovim (e.g., in VS Code), I use Alt+Space to trigger Which-Key.
- From there, I can get back to neovim's keybinds as if I was in neovim and typed leader.

**Benefit:**
This setup lets me use a consistent set of keybindings across both Neovim and VS Code. I don't have to relearn shortcuts for each editor. Which-Key also helps me discover and remember keybinds more easily.

## Git Worktree Workflow

I use Git worktrees to work on multiple branches simultaneously without switching contexts in my main repository.

### Creating a New Worktree

1. **Use Which-Key + GitLens**: Press `Alt+Space` (Which-Key), then `gw` (Git worktree)

   - **Naming**: Branch names can be anything - use descriptive names like `feature-name-branchname` or `bugfix-description`

2. **Add to current workspace**: After the worktree is created, add the new worktree folder to your current VS Code/Windsurf workspace

3. **Save workspace**: Save the updated workspace to your `vscode.workspaces` folder for future use

4. **Work with the new worktree**: The new worktree is now available in your workspace where you can work independently

### Cleaning Up

When you're finished with the worktree:

1. **Delete the worktree**: Press `Alt+Space` (Which-Key), then `gw` then `d` (Git worktree delete)
   - This removes the worktree and cleans up the local repository

### Workspace Management

- **Edit workspace**: Use `Alt+Space` (Which-Key), then `w` then `o` to edit and manage workspaces
- **Workspace location**: Save workspaces in the `vscode.workspaces` folder for easy access

### Committing Changes

- **Use LazyGit**: Open LazyGit to manage commits for your worktree
- **Select correct worktree**: In LazyGit mode, remember to select the correct worktree directory before committing

## Agent Skills

This repository includes portable agent skills that can be installed on any machine using `openskills`.

### Installing Skills from this Repository

```bash
# Install a specific skill globally
openskills install letrandat/dotfiles/skills/<skill-name> -g --universal

# Example: Install all skills from this repo
openskills install letrandat/dotfiles/skills -g --universal
```

### Bootstrap Workflow

Start any conversation with full context by running `/bootstrap`, which:

1. Runs `bd onboard` to load issue tracking instructions
2. Runs `openskills list` to show available skills
