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

ln -s ~/workspace/repo/dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s ~/workspace/repo/dotfiles/.config/ghostty/config ~/.config/ghostty/config
ln -s ~/workspace/repo/dotfiles/.config/lazygit/.lazygit.config ~/.config/lazygit/.lazygit.config


# Create symbolic links for folders
ln -s ~/workspace/repo/dotfiles/.config/nvim ~/.config/

# Create symbolic links for macOS Application Support
ln -s ~/workspace/repo/dotfiles/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/workspace/repo/dotfiles/.config/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/workspace/repo/dotfiles/.config/Code/User/prompts/code-gen.instructions.md ~/Library/Application\ Support/Code/User/prompts/code-gen.instructions.md

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
ln -s ~/workspace/repo/dotfiles/.config/Code/User/bin/vscode-tmux.sh ~/.config/Code/User/bin/vscode-tmux.sh
chmod +x ~/.config/Code/User/bin/vscode-tmux.sh

# Remember to update ~/.gitconfig-local
ln -s ~/workspace/repo/dotfiles/.gitconfig ~/.gitconfig
```
