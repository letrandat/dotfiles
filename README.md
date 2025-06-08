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

### Manual Setup Instructions

```bash
# Create symbolic links for standard dotfiles
ln -s ~/workspace/repo/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/workspace/repo/dotfiles/.tmux.conf ~/.tmux.conf

# tmux-sessionizer
mkdir -p ~/.local/bin
ln -s ~/workspace/repo/dotfiles/.local/bin/tmux-sessionizer ~/.local/bin/
ln -s ~/workspace/repo/dotfiles/.local/bin/vscode-switcher ~/.local/bin/

ln -s ~/workspace/repo/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/workspace/repo/dotfiles/.config/ghostty/config ~/.config/ghostty/config
ln -s ~/workspace/repo/dotfiles/.config/lazygit/.lazygit.config ~/.config/lazygit/.lazygit.config


# Create symbolic links for folders
ln -s ~/workspace/repo/dotfiles/.config/nvim ~/.config/
ln -s ~/workspace/repo/dotfiles/.config/nvim-kickstart ~/.config/
ln -s ~/workspace/repo/dotfiles/.config/nvim-vscode ~/.config/

# Create symbolic links for macOS Application Support
# VS Code
ln -s ~/workspace/repo/dotfiles/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/workspace/repo/dotfiles/.config/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/workspace/repo/dotfiles/.config/Code/User/prompts/code-gen.instructions.md ~/Library/Application\ Support/Code/User/prompts/code-gen.instructions.md
ln -s ~/workspace/repo/dotfiles/.config/Code/User/tasks.json ~/Library/Application\ Support/Code/User/tasks.json

# Windsurf
ln -s ~/workspace/repo/dotfiles/.config/Windsurf/User/settings.json ~/Library/Application\ Support/Windsurf/User/settings.json
ln -s ~/workspace/repo/dotfiles/.config/Windsurf/User/keybindings.json ~/Library/Application\ Support/Windsurf/User/keybindings.json

# config zsh
# add more *.zsh files under ~/.config/zsh to extend functionality
mkdir -p ~/.config/zsh
ln -s ~/workspace/repo/dotfiles/.config/zsh/aliases.zsh ~/.config/zsh/aliases.zsh
chmod +x ~/.config/zsh/aliases.zsh
ln -s ~/workspace/repo/dotfiles/.config/zsh/env.zsh ~/.config/zsh/env.zsh
chmod +x ~/.config/zsh/env.zsh
ln -s ~/workspace/repo/dotfiles/.config/zsh/vscode-tmux.zsh ~/.config/zsh/vscode-tmux.zsh
chmod +x ~/.config/zsh/vscode-tmux.zsh
ln -s ~/workspace/repo/dotfiles/.zshrc ~/.zshrc

# config vscode profiles
mkdir -p ~/.config/Code/User/bin
ln -s ~/workspace/repo/dotfiles/.local/bin/vscode-tmux.sh ~/.local/bin/vscode-tmux.sh
chmod +x ~/.local/bin/vscode-tmux.sh

# Remember to update ~/.gitconfig-local
ln -s ~/workspace/repo/dotfiles/.gitconfig ~/.gitconfig
```

## VSCode Switcher Utility

The `vscode-switcher` script provides a fast way to fuzzy-search and open any project folder in VS Code from the terminal or directly within VS Code.

### Features

- **Fuzzy search** your project directories using `fzf`
- Opens the selected folder in VS Code (`code`)
- Configurable search paths and depth via `~/.config/vscode-switcher/vscode-switcher.conf`
- Works from both terminal and VS Code

### Setup

1. **Script Installation**
   The script is located at `.local/bin/vscode-switcher` and should be symlinked to `~/.local/bin/`:

   ```bash
   ln -s ~/workspace/repo/dotfiles/.local/bin/vscode-switcher ~/.local/bin/
   ```

2. **Alias and Keybinding (Terminal)**
   Add to your shell config (e.g., `~/.zshrc`):

   ```sh
   alias vscode-switcher='bash ~/.local/bin/vscode-switcher'
   bindkey -s ^f "vscode-switcher\n"   # Ctrl+F to trigger switcher in terminal
   ```

3. **VS Code Keybinding**
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
```
