# Windsurf Configuration Simplification

## Overview

Simplified Windsurf configuration to use it as a lightweight UI wrapper for AI agent interaction. Stripped editor bloat for performance while keeping agent capabilities and language servers for lint.

## Files Modified

| File                                              | Before        | After         | Change                      |
| ------------------------------------------------- | ------------- | ------------- | --------------------------- |
| `windsurf-extensions.txt`                         | 25 extensions | 17 extensions | -8                          |
| `windsurf/.config/Windsurf/User/settings.json`    | 1833 lines    | ~1050 lines   | -42%                        |
| `windsurf/.config/Windsurf/User/keybindings.json` | 215 lines     | 215 lines     | No change (already minimal) |

## Extensions

### Removed

- `alefragnani.bookmarks` - not used
- `eamodio.gitlens` - don't use blame anymore
- `github.github-vscode-theme` - using Catppuccin
- `mechatroner.rainbow-csv` - not needed
- `ms-azuretools.vscode-containers` - not needed
- `ms-azuretools.vscode-docker` - not needed
- `rangav.vscode-thunder-client` - not needed
- `streetsidesoftware.code-spell-checker` - not needed

### Kept

**Core:**

- `asvetliakov.vscode-neovim` - Neovim integration
- `vspacecode.whichkey` - Spacemacs-style keybindings
- `tompollak.lazygit-vscode` - Git UI
- `przybylski.cursor-harpoon` - File bookmarks
- `danprince.vsnetrw` - File explorer
- `alefragnani.project-manager` - Project switching
- `pkief.material-icon-theme` - Icons
- `ryuta46.multi-command` - Command sequences

**Language Servers & Formatters:**

- `codeium.windsurfpyright` - Python LSP
- `ms-python.python` - Python support
- `ms-python.debugpy` - Python debugging
- `ms-python.vscode-python-envs` - Python environments
- `redhat.vscode-yaml` - YAML support
- `dbaeumer.vscode-eslint` - ESLint
- `esbenp.prettier-vscode` - Prettier formatter
- `bradlc.vscode-tailwindcss` - Tailwind CSS
- `yoavbls.pretty-ts-errors` - TypeScript error formatting

## Settings.json Changes

### Which-key Groups Removed

| Key   | Group       | Reason              |
| ----- | ----------- | ------------------- |
| `Tab` | Last buffer |                     |
| `:`   | Tasks       | Not used            |
| `d`   | Debug       | Extensive, not used |
| `m`   | Bookmarks   | Extension removed   |
| `l`   | Lang        | Empty submenu       |
| `t`   | Testing     | Not used            |
| `u`   | Toggle/UI   | Rarely used         |
| `v`   | Neovim      | Rarely used         |
| `z`   | Fold        | Rarely used         |

### Which-key Groups Kept

| Key     | Group       | Purpose                        |
| ------- | ----------- | ------------------------------ |
| `Space` | Commands    | Command palette                |
| `,`     | Buffers     | Show all buffers               |
| `?`     | Search      | Search keybindings             |
| `.`     | Repeat      | Repeat last action             |
| `*`     | Search      | Search with selection          |
| `/`     | Search      | Search in project              |
| `$`     | Terminal    | Run recent command             |
| `b`     | Buffers     | Buffer management              |
| `c`     | Code        | Code actions, format, rename   |
| `e`     | Errors      | Error navigation and fixes     |
| `f`     | File        | File operations, copy path     |
| `g`     | Git         | Lazygit, stage/unstage, commit |
| `h`     | Harpoon     | Harpoon layouts (1-4 splits)   |
| `j`     | Panel       | Terminal, output, problems     |
| `p`     | Project     | Project Manager                |
| `q`     | Quit        | Close buffer, quit app         |
| `s`     | Show/Search | Explorer, symbols, settings    |
| `w`     | Window      | Splits, maximize, reload       |

### Settings Removed

- Gitlens configuration (extension removed)
- find-it-faster configuration (extension removed)
- GitHub Copilot configuration (using Windsurf AI instead)
- Bookmarks configuration (extension removed)

### Settings Kept

- All comments preserved
- Workbench/editor/window configuration
- Language-specific settings (Go inlay hints, formatters)
- Terminal configuration with tmux profile
- MultiCommand sequences (maximize, vscodeSwitcher)
- vscode-neovim configuration
- lazygit-vscode configuration
- MCP discovery for agent integration

## Keybindings.json

Already minimal. Key bindings:

| Keys           | Purpose                |
| -------------- | ---------------------- |
| `cmd+w r`      | Emergency reload       |
| `cmd+d`        | Focus editor           |
| `cmd+shift+h`  | Toggle secondary bar   |
| `ctrl+u/d/b/f` | Vim-style scrolling    |
| `alt+space`    | Which-key menu         |
| `alt+j/k/l/;`  | Harpoon slots 1-4      |
| `alt+m/o/p`    | Harpoon mark/edit/pick |
| `shift+cmd+g`  | Lazygit toggle         |
| `ctrl+=`       | Terminal toggle        |
| `cmd+k`        | Windsurf agent picker  |
| `cmd+l`        | Chat panel             |

## Key Design Decisions

1. **Last buffer: `Tab`** - More consistent with default key pattern
2. **No debug/testing which-key** - Use Neovim or terminal for these
3. **Keep language servers** - Essential for AI agents to see lint errors
4. **Keep MCP discovery** - Enables AI agent integration across tools
5. **Minimal keybindings.json** - Prefer which-key for discoverability

## Conflict Resolution

If merging with changes that add back removed settings:

1. **Extensions**: Check if extension is actually used before re-adding
2. **Which-key groups**: Only add back if actively used
3. **Copilot settings**: Not needed if using Windsurf AI
4. **Gitlens settings**: Not needed if extension not installed

## Branch

Changes made on: `feat/simplify-windsurf-config`
