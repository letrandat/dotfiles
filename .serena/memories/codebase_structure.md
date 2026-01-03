# Codebase Structure

## Directory Layout

```
dotfiles/
├── setup.sh                      # Main setup script
├── README.md                     # Project documentation
├── AGENTS.md                     # Agent-related documentation
├── README-openskills.md          # openskills documentation
├── install_extensions.sh         # Extension installer script
├── *-extensions.txt              # Extension lists for various editors
│
├── nvim/                         # Neovim configuration package
│   └── .config/nvim/
│       ├── init.lua              # Entry point
│       ├── stylua.toml           # Lua formatter config
│       └── lua/
│           ├── config/           # Core configuration
│           │   ├── lazy.lua      # Plugin manager setup
│           │   ├── options.lua   # Neovim options
│           │   ├── keymaps.lua   # Key mappings
│           │   └── autocmds.lua  # Auto commands
│           └── plugins/          # Plugin configurations
│               ├── language-extras.lua
│               ├── disabled.lua
│               ├── nvim-spider.lua
│               ├── guess-indent.lua
│               └── example.lua
│
├── zsh/                          # Zsh configuration package
│   ├── .zshrc                    # Main zsh config
│   └── .config/zsh/
│       ├── aliases.zsh           # Shell aliases
│       └── env.zsh               # Environment variables
│
├── git/                          # Git configuration package
│   └── .gitconfig                # Git configuration
│
├── tmux/                         # Tmux configuration package
│   └── .tmux.conf                # Tmux configuration
│
├── bin/                          # Executable scripts package
│   └── .local/dotfiles-bin/
│       ├── tmux-sessionizer      # Session picker/creator
│       ├── tmux-autoattach.sh    # Auto-attach on spawn
│       └── tmux-cheatsheet       # Keybinding reference
│
├── kitty/                        # Kitty terminal package
│   └── .config/kitty/
│       └── kitty.conf
│
├── ghostty/                      # Ghostty terminal package
│   └── .config/ghostty/
│       └── config
│
├── lazygit/                      # LazyGit package
│   └── .config/lazygit/
│       └── config.yml
│
├── vscode/                       # VS Code configuration package
│   └── .config/Code/User/
│       ├── settings.json
│       ├── keybindings.json
│       ├── tasks.json
│       └── prompts/
│
├── windsurf/                     # Windsurf configuration package
│   └── .config/Windsurf/User/
│       ├── settings.json
│       └── keybindings.json
│
├── antigravity/                  # Antigravity configuration package
│   └── .config/Antigravity/User/
│       ├── settings.json
│       └── keybindings.json
│
├── codeium/                      # Codeium configuration package
│   └── .codeium/
│
├── amp/                          # Amp configuration package
│   └── .config/amp/
│
├── ideavim/                      # IntelliJ Vim package
│   └── .ideavimrc
│
├── intellimacs/                  # IntelliJ Emacs package
│   └── .config/intellimacs/
│
├── skills/                       # Agent skills for openskills
│   └── (various skill definitions)
│
├── docs/                         # Documentation
│   └── plans/                    # Design and implementation plans
│       ├── 2025-12-19-fresh-lazyvim-setup-design.md
│       └── 2025-12-19-fresh-lazyvim-setup-implementation.md
│
├── notes/                        # Personal notes
│
├── .github/                      # GitHub-specific files
│   └── copilot-instructions.md
│
├── .git/                         # Git repository data
├── .gitignore                    # Git ignore patterns
├── .gitattributes                # Git attributes
└── .gitconfig-local              # Local git config overrides
```

## Key Directories

### Configuration Packages (Stow)

Each top-level directory (nvim, zsh, git, etc.) is a GNU Stow package that gets symlinked to `~/`.

**Structure pattern:**

```
package-name/
└── .exact/path/in/home/
    └── config-files
```

**Example:**

```
nvim/.config/nvim/init.lua  →  ~/.config/nvim/init.lua  (after stowing)
zsh/.zshrc                  →  ~/.zshrc                  (after stowing)
```

### Neovim Structure (LazyVim)

- **init.lua**: Bootstraps lazy.nvim
- **lua/config/**: Core settings (options, keymaps, autocmds)
- **lua/plugins/**: Plugin specifications (one file per plugin or logical group)

LazyVim automatically loads:

1. `lua/config/*.lua`
2. `lua/plugins/*.lua` (each file can return plugin spec or array of specs)

### Shell Configuration

- **zsh/.zshrc**: Main zsh config, sources Oh My Zsh
- **zsh/.config/zsh/**: Custom zsh files (aliases, env)
- Oh My Zsh custom dir: `$ZSH_CUSTOM` points to `~/.config/zsh`

### Binary Scripts

- **bin/.local/dotfiles-bin/**: Custom executable scripts
- These get symlinked to `~/.local/dotfiles-bin/`
- Add to PATH in shell config

### Documentation

- **README.md**: Main project documentation
- **docs/plans/**: Design documents and implementation plans
- **AGENTS.md**: Agent-related documentation
- **README-openskills.md**: openskills integration

## Special Files

### Configuration Files

- **nvim/.config/nvim/stylua.toml**: Lua formatting configuration
- **nvim/.config/nvim/.neoconf.json**: Neovim project settings
- **.gitignore**: Git ignore patterns
- **.gitattributes**: Git attribute patterns

### Setup and Utility Scripts

- **setup.sh**: Automated dotfiles installation
- **install_extensions.sh**: Editor extension installer
- **vscode-extensions.txt**: VS Code extension list
- **windsurf-extensions.txt**: Windsurf extension list
- **antigravity-extensions.txt**: Antigravity extension list

## Navigation Tips

### Finding Configuration Files

- **Neovim plugins**: `nvim/.config/nvim/lua/plugins/`
- **Neovim core config**: `nvim/.config/nvim/lua/config/`
- **Shell aliases**: `zsh/.config/zsh/aliases.zsh`
- **Shell environment**: `zsh/.config/zsh/env.zsh`
- **Editor keybindings**: `{vscode,windsurf,antigravity}/.config/*/User/keybindings.json`

### Working with Multiple Configs

Since editors share similar structure:

- VS Code: `vscode/.config/Code/User/`
- Windsurf: `windsurf/.config/Windsurf/User/`
- Antigravity: `antigravity/.config/Antigravity/User/`

They often have synchronized settings via Which-Key.

## Ignored Directories

- **node_modules/**: Not applicable (no Node.js project)
- **Plugin data**: Neovim plugins are not committed (managed by Lazy.nvim)
- **.git/**: Git internals
- **.serena/**: Serena project data (local)
- **.claude/**: Claude-specific data (local)
