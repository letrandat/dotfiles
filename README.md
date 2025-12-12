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

## VSCode Switcher Utility

The `vscode-switcher` script provides a fast way to fuzzy-search and open any project folder in VS Code from the terminal or directly within VS Code.

### Features

- **Fuzzy search** your project directories using `fzf`
- Opens the selected folder in VS Code (`code`)
- Configurable search paths and depth via `~/.config/vscode-switcher/vscode-switcher.conf`
- Works from both terminal and VS Code

### Setup

1. **Alias and Keybinding (Terminal)**
   Add to your shell config (e.g., `~/.zshrc`):

   ```sh
   alias vscode-switcher='bash ~/.local/bin/vscode-switcher'
   bindkey -s ^f "vscode-switcher\n"   # Ctrl+F to trigger switcher in terminal
   ```

2. **VS Code Keybinding**
   To trigger the switcher from within VS Code (e.g., with `Ctrl+E`), add this to your `keybindings.json`:

   ```json
   {
     "key": "ctrl+e",
     "command": "extension.multiCommand.execute",
     "args": {
       "sequence": [
         // send ctrl+u to terminal to clear terminal before running command
         {
           "key": "cmd+w shift+V",
           "command": "workbench.action.terminal.sendSequence",
           "args": { "text": "\u0015vscode-switcher\u000D" }
         },
         // focus on terminal to select the folder
         {
           "command": "workbench.action.terminal.toggleTerminal",
           "when": "terminal.active"
         }
       ]
     }
   }
   ```

### Configuration

You can customize search paths and depth by creating `~/.config/vscode-switcher/vscode-switcher.conf`.
See the top of the script for an example config.

---

## Tmux Terminal

To open a new tmux terminal, use the shortcut: **Shift + Cmd + J, then N, then T**.

- This sequence stands for **[N]ew [T]mux Terminal**.
- Use this shortcut to quickly start a fresh tmux session after switching to a new folder/workspace

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
