# Fresh LazyVim Setup Design

**Date:** 2025-12-19
**Goal:** Set up a fresh LazyVim configuration as default, preserve old config as nvim-full, and enable iterative "discover & add" workflow.

## Overview

Replace current heavily-customized LazyVim (24 extras) with a minimal fresh start. Keep old config accessible via `NVIM_APPNAME=nvim-full` for reference and cherry-picking.

## Design Decisions

### Approach: Iterative "Discover & Add"
- Start with minimal LazyVim + essential customizations only
- Add extras/plugins as needed during real usage
- Cherry-pick from nvim-full when you remember "I had X feature"
- Avoid recreating bloat - only add what you actually use

### Naming Strategy: Purpose-Based
- Fresh config → `nvim/.config/nvim/` (default, minimal)
- Old config → `nvim/.config/nvim-full/` (feature-rich reference)
- Alternatives preserved: `nvim-kickstart/`, `nvim-vscode/`

## Directory Structure

### Current State
```
dotfiles/
├── nvim/
│   └── .config/
│       ├── nvim/          # Current LazyVim (24 extras)
│       ├── nvim-kickstart/
│       └── nvim-vscode/
└── .config/
    └── nvim/              # Orphaned lazy-lock.json only
```

### Target State
```
dotfiles/
├── nvim/
│   └── .config/
│       ├── nvim/          # Fresh LazyVim (default)
│       ├── nvim-full/     # Renamed from current nvim
│       ├── nvim-kickstart/
│       └── nvim-vscode/
├── .config/
│   └── nvim/              # Cleaned up
└── docs/
    └── nvim-migration-reference.md  # Cherry-pick guide
```

## Setup Process

### 1. Backup & Rename
- Rename `nvim/.config/nvim` → `nvim/.config/nvim-full`
- Remove orphaned `.config/nvim/lazy-lock.json`
- Commit: `feat: Rename nvim to nvim-full and clean up orphaned files`

### 2. Fresh LazyVim Installation
- Clone LazyVim starter template into `nvim/.config/nvim/`
- Remove `.git` folder (integrate into dotfiles repo)
- Commit immediately: `feat: Add fresh LazyVim starter as default nvim config` ← **baseline marker**

### 3. Essential Customizations (Day 1)
Add only what's needed for basic usability:
- Set `vim.g.autoformat = false` (user preference)
- Install nvim-spider plugin (better w/e/b word motions)
- Install guess-indent (auto-detect indentation)
- Disable bufferline (prefer clean UI)

Commit: `feat: Add essential customizations (autoformat off, disable bufferline, nvim-spider, guess-indent)`

### 4. Language Extras (Initial Set)
Install LazyVim extras for primary languages:
- **Languages:** typescript, go, python, java, scala, vue
- **Formats:** json, yaml, toml, markdown, sql
- **Tools:** docker, git

Commit: `feat: Add LazyVim language extras`

### 5. Utility Extras (Selected)
Install useful editor utilities:
- `editor.mini-files` - File explorer
- `editor.dial` - Smart increment/decrement
- `editor.inc-rename` - LSP rename with preview
- `util.dot` - Dotfiles syntax

Commit: `feat: Add LazyVim utility extras`

### 6. Stow Activation
- Run `stow -R nvim` to symlink fresh config as default
- Verify: `ls -la ~/.config/nvim` points to `dotfiles/nvim/.config/nvim`
- Test both configs work:
  - `nvim` → fresh LazyVim
  - `NVIM_APPNAME=nvim-full nvim` → old config

## Migration Reference

Create `docs/nvim-migration-reference.md` with checklist of nvim-full customizations.

### Custom Plugins from nvim-full
- [x] guess-indent.lua - Auto-detect indentation (added day 1)
- [x] nvim-spider.lua - Better word motions (added day 1)
- [x] disabled.lua - Disables bufferline (added day 1)
- [ ] extend-mini-files.lua - Wider preview (width: 100) - add when you miss it
- [ ] extend-snacks.lua - Show hidden files in picker (excluding node_modules, .git)

### LazyVim Extras from nvim-full

**Already added:**
- ✅ Languages: typescript, go, python, java, scala, vue, json, yaml, toml, markdown, sql, docker, git
- ✅ Editor: mini-files, dial, inc-rename
- ✅ Util: dot

**Available to add later (from nvim-full):**
- [ ] coding.yanky - Enhanced clipboard (SKIP - not needed)
- [ ] test.core - Neotest integration (add when you need testing)
- [ ] util.mini-hipatterns - Highlight colors/TODOs (add when you want it)
- [ ] lang.cmake - Add when working with CMake projects
- [ ] lang.kotlin - Already in initial set

**Other languages to add as needed:**
- Python, Kotlin were in nvim-full but not in initial set (add when working on those projects)

### Custom Options (already covered)
- ✅ `vim.g.autoformat = false`

## Cherry-Pick Workflow

When you need something from nvim-full:

1. **Identify:** Check `docs/nvim-migration-reference.md` for file location
2. **Copy:** `cp nvim/.config/nvim-full/lua/plugins/<file>.lua nvim/.config/nvim/lua/plugins/`
3. **Reload:** Restart nvim or run `:Lazy sync`
4. **Track:** Check off item in migration reference
5. **Commit:** Clear message like `feat: Add <plugin> from nvim-full`

Adding LazyVim extras:
- Run `:LazyExtras` in nvim
- Browse and press `x` to toggle install
- Or manually add to plugin file

## Config Management

### Default Config
```bash
nvim                    # Opens fresh LazyVim
ls -la ~/.config/nvim   # → symlink to dotfiles/nvim/.config/nvim
```

### Alternative Configs
```bash
NVIM_APPNAME=nvim-full nvim         # Old config with all extras
NVIM_APPNAME=nvim-kickstart nvim    # Kickstart variant
NVIM_APPNAME=nvim-vscode nvim       # VSCode variant
```

### Stow Management
```bash
stow -R nvim            # Refresh symlinks after changes
```

### Shell Aliases (Optional)
```bash
alias nvim-full='NVIM_APPNAME=nvim-full nvim'
alias nvim-kick='NVIM_APPNAME=nvim-kickstart nvim'
```

### Data Separation
- Each config has independent data: `~/.local/share/nvim-*/`
- Separate plugin installations (no conflicts)
- Independent lazy-lock.json files

## Commit Strategy

Clear, granular commits to track evolution:

1. `feat: Rename nvim to nvim-full and clean up orphaned files`
2. `feat: Add fresh LazyVim starter as default nvim config` ← baseline
3. `feat: Add essential customizations (autoformat off, disable bufferline, nvim-spider, guess-indent)`
4. `feat: Add LazyVim language extras (typescript, go, python, java, scala, vue, markdown, json, yaml, toml, sql, docker, git)`
5. `feat: Add LazyVim utility extras (dial, inc-rename, dot, mini-files)`

Future additions:
- `feat: Add <plugin-name> from nvim-full`
- `feat: Add LazyVim extra: <extra-name>`
- `feat: Customize <feature> for <reason>`

## Success Criteria

- ✅ Fresh LazyVim loads without errors
- ✅ Old config accessible via `NVIM_APPNAME=nvim-full`
- ✅ Essential customizations working (no autoformat, nvim-spider, guess-indent)
- ✅ Language support for primary languages (TS, Go, Python, Java, Scala, Vue)
- ✅ Clean commit history showing fresh baseline + additions
- ✅ Migration reference doc created for future cherry-picking
- ✅ Stow correctly symlinks fresh config as default

## Future Workflow

1. Use fresh LazyVim as daily driver
2. When you need a feature: check migration reference
3. Either copy from nvim-full or add new extra via `:LazyExtras`
4. Commit with clear message
5. Update migration reference checklist
6. Over time, build a lean, purposeful configuration
