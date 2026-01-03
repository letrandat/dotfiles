# Task Completion Checklist

## When You Complete a Task

Follow these steps to ensure changes are properly applied and tested:

### 1. Format Code

If you modified Lua files (Neovim configs):

```bash
stylua nvim/.config/nvim/
```

If you modified shell scripts, ensure they follow standard conventions (no automatic formatter).

### 2. Update Symlinks (if needed)

If you modified configuration files that are stowed:

```bash
# Re-stow the affected package to update symlinks
stow -R <package-name>

# Examples:
stow -R nvim
stow -R zsh
stow -R tmux
```

**Note**: Only needed if you added/removed files. Editing existing files doesn't require re-stowing.

### 3. Test the Configuration

#### For Neovim Changes

```bash
# Quick syntax check
nvim --headless "+Lazy! sync" +qa

# Manual testing
nvim
# Then inside Neovim:
# :checkhealth
# :Lazy
```

#### For Zsh Changes

```bash
# Source the updated config
source ~/.zshrc

# Or start a new shell
zsh
```

#### For Tmux Changes

```bash
# Reload tmux config (inside tmux)
tmux source ~/.tmux.conf

# Or restart tmux sessions
```

#### For Shell Scripts

```bash
# Test script execution
bash -n script.sh         # Syntax check
./script.sh               # Run it
```

### 4. Verify Changes Work

- **Neovim**: Open Neovim and test the changed functionality
- **Shell**: Open a new terminal and verify aliases/functions work
- **Tmux**: Test keybindings and session management
- **Scripts**: Run the script and verify expected behavior

### 5. Git Workflow

Only commit when explicitly requested by the user. If committing:

```bash
git status                # Review changes
git add .                 # Stage changes
git commit -m "type: description"
# Examples:
# "feat: Add new keybinding for X"
# "fix: Correct tmux session naming"
# "docs: Update README with new workflow"
# "refactor: Reorganize plugin configs"
```

### 6. Documentation

If the change affects user workflows or adds new features:

- Update README.md if it affects setup or usage
- Consider adding notes to docs/ for significant changes
- Update inline comments for complex configurations

## Pre-Commit Checklist

Before committing configuration changes:

- [ ] Code is formatted (stylua for Lua)
- [ ] Symlinks are updated (if files added/removed)
- [ ] Configuration loads without errors
- [ ] Tested in relevant environment (Neovim, shell, etc.)
- [ ] Documentation is updated (if needed)
- [ ] No sensitive data (API keys, tokens) included

## Common Issues and Solutions

### Stow Conflicts

```bash
# Remove old symlink and re-stow
rm ~/.config/nvim
stow -R nvim
```

### Neovim Plugin Issues

```vim
:Lazy clean               " Remove unused plugins
:Lazy sync                " Update all plugins
:Lazy restore             " Restore from lockfile
```

### Zsh Not Loading Changes

```bash
# Ensure .zshrc sources custom configs
source ~/.zshrc

# Check for syntax errors
zsh -n ~/.zshrc
```

## No Automated Testing

This is a dotfiles repository with no automated test suite. Testing is manual:

- **Linting**: Only for Lua (via stylua)
- **Testing**: Manual verification in respective applications
- **CI/CD**: None (personal configurations)

## Special Considerations

### macOS Application Support

If modifying VS Code/Windsurf/Antigravity configs:

- Changes are automatically reflected (symlinked via setup.sh)
- Restart the application to pick up changes
- No need to manually copy files to ~/Library/Application Support/

### Tmux Sessionizer

If modifying tmux-sessionizer or related scripts:

- Ensure they're executable: `chmod +x bin/.local/dotfiles-bin/script.sh`
- Re-stow bin package: `stow -R bin`
- Test in both editor-integrated and standalone terminal contexts
