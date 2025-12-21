# Code Style and Conventions

## Lua (Neovim Configuration)

### Formatting
- **Tool**: StyLua
- **Indent**: 2 spaces (not tabs)
- **Column width**: 120 characters
- **Configuration**: `nvim/.config/nvim/stylua.toml`

### Structure
- **Entry point**: `init.lua` - bootstraps lazy.nvim and LazyVim
- **Config directory**: `lua/config/` - Core configuration
  - `lazy.lua`: Plugin manager setup
  - `options.lua`: Neovim options
  - `keymaps.lua`: Key mappings
  - `autocmds.lua`: Auto commands
- **Plugins directory**: `lua/plugins/` - Plugin configurations
  - Each plugin gets its own file or is grouped logically
  - Files can override/extend LazyVim defaults

### Naming Conventions
- **Files**: lowercase with hyphens (e.g., `language-extras.lua`, `guess-indent.lua`)
- **Modules**: Follow Lua conventions (snake_case for variables/functions)

## Shell Scripts

### Bash
- **Shebang**: `#!/bin/bash` (explicit bash requirement)
- **Style**: Standard bash conventions
- **Comments**: Document functions and complex logic
- **Error handling**: Check for command availability before use

### Zsh
- **Shebang**: Implicit (sourced, not executed)
- **Framework**: Oh My Zsh conventions
- **Custom files**: Stored in `$ZSH_CUSTOM` (`~/.config/zsh`)
- **Extensions**: `.zsh` suffix for custom files

### Shell Script Patterns
```bash
# Check for command existence
if ! command -v tool &> /dev/null; then
    echo "Tool not found"
    exit 1
fi

# Directory of current script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
```

## Directory Structure Conventions

### GNU Stow Packages
- Each top-level directory = one stow package
- Internal structure mirrors target home directory structure
- Package name should match the primary tool it configures

### XDG Base Directory
- Prefer `~/.config/` for configuration files
- Use `~/.local/bin/` for user binaries
- Keep home directory root minimal

## Naming Conventions

### Files
- **Config files**: Use tool's default names (`.zshrc`, `init.lua`, `config`)
- **Scripts**: Descriptive names with hyphens (e.g., `tmux-sessionizer`, `tmux-autoattach.sh`)
- **Documentation**: Lowercase with hyphens (e.g., `fresh-lazyvim-setup-design.md`)

### Git Branches
- Descriptive names allowed
- Examples: `feature-name-branchname`, `bugfix-description`
- No strict convention enforced

### Tmux Sessions
- Pattern: `parent_child` based on directory
- Example: `~/workspace/dotfiles` → `workspace_dotfiles`

## Configuration Patterns

### Modular Configuration
- Split configs into logical files
- Use separate files for aliases, environment variables, functions
- Import/source from main config file

### LazyVim Plugin Pattern
Each plugin config file should return a table:
```lua
return {
  "plugin/name",
  opts = {},
  keys = {},
  -- other lazy.nvim specs
}
```

### Documentation
- Keep README.md up to date at repository root
- Use `docs/` for design documents and plans
- Include setup instructions and workflow documentation

## Git Commit Messages

### Format
Follow the Conventional Commits specification with a bulleted body for details:

```text
type(scope): subject

- Detail 1
- Detail 2
- Detail 3
```

### Types
- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that do not affect the meaning of the code (white-space, formatting, etc)
- **refactor**: A code change that neither fixes a bug nor adds a feature
- **perf**: A code change that improves performance
- **test**: Adding missing tests or correcting existing tests
- **chore**: Changes to the build process or auxiliary tools and libraries such as documentation generation

### Guidelines
- **Subject**: Imperative, present tense ("add" not "added"), no capitalization, no period.
- **Body**: Use a bulleted list (`- `) to explain *what* and *why* vs. *how*.

