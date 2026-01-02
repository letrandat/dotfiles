---
trigger: always_on
---

# Dotfiles Management Guide

## Repository Structure

```
├── .config/              # Application configurations
│   ├── zsh/              # Zsh configuration
│   ├── nvim/             # Neovim configuration
│   └── ...               # Other app configs
├── .gitconfig            # Git configuration
├── .gitconfig-local      # Machine-specific Git overrides (git config --file ~/.gitconfig-local)
├── .tmux.conf           # Tmux configuration
├── .ideavimrc            # IntelliJ Vim emulation
└── bin/                  # Custom scripts
```

## Machine-Specific Configurations

1. **Local Overrides**:
   - Use `.gitconfig-local` for machine-specific Git settings
   - Create `~/.zshrc.local` for machine-specific shell customizations
   - Add `*.local` to `.gitignore` to prevent committing machine-specific files

2. **Environment Detection**:
   - Use `hostname` or environment variables to detect the current machine
   - Example in `.zshrc`:

     ```zsh
     if [[ -f ~/.zshrc.$(hostname -s) ]]; then
         source ~/.zshrc.$(hostname -s)
     fi
     ```

## Git Management

1. **Branch Strategy**:
   - `main` branch: Contains stable, tested configurations
   - Feature branches: For trying out new configurations

## Best Practices

1. **Modular Organization**:
   - Keep configurations modular and well-commented
   - Group related configurations together
   - Use symlinks or includes for better organization

2. **Documentation**:
   - Document the purpose of each configuration file
   - Include setup instructions in README.md
   - List required dependencies and installation steps

3. **Security**:
   - Never commit sensitive information (API keys, tokens, etc.)
   - Use environment variables or `.env` files for sensitive data
   - Consider using git-crypt for encrypting sensitive files

## Setup Script

Create a `bootstrap.sh` script to:

1. Create necessary symlinks
2. Install dependencies
3. Set up environment variables
4. Apply machine-specific configurations

## Update Strategy

1. Regularly pull updates from the main branch
2. Test configurations in a separate branch before merging to main
3. Document breaking changes in CHANGELOG.md
