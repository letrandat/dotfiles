# Suggested Commands

## macOS System Commands

Since this project runs on **macOS (Darwin)**, standard Unix commands are available. Note that macOS uses BSD-based utilities which may differ slightly from GNU versions.

### Common macOS Commands
```bash
# File operations
ls -la                    # List files with details
find . -name "*.lua"      # Find files
grep -r "pattern" .       # Search in files

# File manipulation
cat file.txt              # Display file contents
head -n 20 file.txt       # Show first 20 lines
tail -f logfile           # Follow log file

# Directory operations
cd /path/to/dir           # Change directory
pwd                       # Print working directory
mkdir -p dir/subdir       # Create nested directories
```

## GNU Stow Commands

### Initial Setup
```bash
./setup.sh                # Run automated setup (recommended)
```

### Manual Stow Management
```bash
# Stow a single package
stow -d ~/dotfiles -t ~/ zsh

# Re-stow (update) a package
stow -R zsh

# Unstow (remove symlinks) a package
stow -D zsh

# Stow multiple packages
stow zsh git nvim tmux

# Dry run (see what would happen)
stow -n -v zsh
```

### Troubleshooting Stow
```bash
# If stow reports conflicts, remove old symlinks
rm ~/.zshrc
stow -R zsh

# Check what's stowed
ls -la ~/ | grep '^l'     # List all symlinks in home
```

## Neovim/LazyVim Commands

### Formatting
```bash
# Format Lua files with stylua
stylua nvim/.config/nvim/

# Format specific file
stylua nvim/.config/nvim/init.lua

# Check formatting (dry run)
stylua --check nvim/.config/nvim/
```

### Neovim Health Check
```vim
" Inside Neovim
:checkhealth              " Check Neovim installation
:Lazy                     " Open Lazy plugin manager
:LazyHealth               " Check LazyVim health
```

## Git Commands

### Standard Git Operations
```bash
git status                # Check repository status
git add .                 # Stage all changes
git commit -m "message"   # Commit changes
git push                  # Push to remote
git pull                  # Pull from remote
```

### Git Worktree Workflow
```bash
# Create new worktree
git worktree add ../dotfiles-feature feature-name

# List worktrees
git worktree list

# Remove worktree
git worktree remove ../dotfiles-feature

# Prune deleted worktrees
git worktree prune
```

## VS Code/Windsurf Extension Management

### Export Extensions
```bash
# VS Code
code --list-extensions > vscode-extensions.txt

# Windsurf
windsurf --list-extensions > windsurf-extensions.txt
```

### Install Extensions
```bash
# VS Code
cat vscode-extensions.txt | xargs -L 1 code --install-extension

# Windsurf
cat windsurf-extensions.txt | xargs -L 1 windsurf --install-extension

# Use provided script
./install_extensions.sh
```

## Tmux Commands

### Session Management
```bash
# List sessions
tmux ls

# Attach to session
tmux attach -t session_name

# Kill session
tmux kill-session -t session_name

# Custom sessionizer (with fzf picker)
tmux-sessionizer          # Must be in PATH via stowed bin/
```

### Tmux Keybindings
```
prefix + f                # Open tmux-sessionizer
prefix + ?                # Show all keybindings
```

## LazyGit

```bash
# Open LazyGit
lazygit

# Open LazyGit in specific directory
lazygit -p ~/workspace/dotfiles
```

## Homebrew (Package Management)

```bash
# Install package
brew install package-name

# Update Homebrew
brew update

# Upgrade packages
brew upgrade

# List installed packages
brew list

# Search for packages
brew search keyword
```

## openskills (Agent Skills)

```bash
# Install skills from this repository
openskills install letrandat/dotfiles/skills/<skill-name> -g --universal

# Install all skills
openskills install letrandat/dotfiles/skills -g --universal

# List installed skills
openskills list
```

## Development Workflow Commands

### After Making Changes
```bash
# Format Lua files
stylua nvim/.config/nvim/

# Re-stow updated package
stow -R nvim

# Test Neovim configuration
nvim --headless "+Lazy! sync" +qa
nvim                      # Launch and verify manually

# Commit changes
git add .
git commit -m "feat: description of changes"
git push
```

### Testing Configurations

```bash
# Test zsh config (start new shell)
zsh

# Test tmux config
tmux source ~/.tmux.conf

# Test Neovim config
nvim --noplugin          # Start without plugins
nvim                     # Start normally
```

## File Navigation

```bash
# Quick navigation to common directories
cd ~/workspace/dotfiles   # This repository
cd ~/.config/nvim         # Neovim config (symlink)
cd ~/.config/zsh          # Zsh custom configs

# Edit configurations
nvim ~/.zshrc
nvim ~/.config/nvim/init.lua
nvim ~/.tmux.conf
```
