# Lazygit Configuration & Usage Guide

## Configuration Explanation

The `lazygit` configuration is located at `~/.config/lazygit/config.yml` (symlinked from this dotfiles repository).

### Editor Integration

```yaml
edit: "windsurf {{filename}}"
editAtLine: "windsurf --goto {{filename}}:{{line}}"
```

- **`edit`**: This command is used when you press `e` to edit a file in Lazygit. It opens the file in **Windsurf**.
- **`editAtLine`**: This command is used when you press `e` on a specific line (e.g., in the diff view). It opens Windsurf and jumps directly to that line using the `--goto` flag.
- **Changing the Editor**: To change the editor (e.g., to VS Code or Neovim), you simply replace `windsurf` with your editor's command (e.g., `code`, `nvim`).

### User Interface & Behavior

```yaml
promptToReturnFromSubprocess: false
gui:
  showIcons: true
```

- **`promptToReturnFromSubprocess: false`**: By default, when Lazygit runs a command that takes over the terminal (like opening an editor), it asks you to "Press Enter to return to lazygit" after the command finishes. Setting this to `false` disables that prompt, making the return to Lazygit instant and smoother.
- **`gui.showIcons: true`**: Enables file icons in the Lazygit interface (requires a Nerd Font to be installed in your terminal).

### Keybindings

```yaml
keybinding:
  universal:
    prevBlock-alt: "" # This will unbind 'h'
    nextBlock-alt: "" # This will unbind 'l'
    prevTab: "h"
    nextTab: "l"
```

- **`prevBlock-alt` / `nextBlock-alt`**: These are set to empty strings `""` to unbind the default `h` and `l` keys (which usually navigate blocks or items), preventing conflicts.
- **`prevTab` / `nextTab`**: These are then mapped to `h` and `l`, allowing you to use them to switch between the main panels (Status, Files, Branches, Commits, Stash).

## Intermediate Usage Tips

### Common Actions

- **Stage/Unstage**: `Space` on a file.
- **Commit**: `c` to open the commit dialog.
- **Amend Commit**: `A` to amend the last commit with currently staged changes.
- **Push**: `P` to push to the upstream branch.
- **Pull**: `p` to pull from the upstream branch.

### Advanced Features

- **Interactive Rebase**: Press `i` on a commit in the Commits panel to start an interactive rebase from that point.
- **Cherry Pick**: Press `c` on a commit in the Commits panel (when viewing another branch) to copy it, then paste it in your branch.
- **Patch Building**:
  1.  Go to a specific commit and press `Enter` to view its files.
  2.  Press `Space` on a file to add it to the patch, or `Enter` to enter the file and `Space` on specific lines.
  3.  Press `Ctrl+p` to open the patch options menu (e.g., to create a patch).
- **Custom Commands**: You can define custom commands in `config.yml` under `customCommands`.

## Resources

- [Official Lazygit Documentation](https://github.com/jesseduffield/lazygit)
