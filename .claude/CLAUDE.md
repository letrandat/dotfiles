# Dotfiles Project Instructions

## Dotfiles-bin Convention

### Overview

Custom scripts in this repo are stored in `bin/.local/dotfiles-bin/` and stowed to `~/.local/bin/` for execution.

### Structure

```

bin/.local/dotfiles-bin/    # Source location in repo
  ├── script-name           # Custom scripts
  ├── get-project-name      # Shared libraries/utilities
  └── ...

~/.local/bin/               # Installed location (via stow)
  ├── script-name           # Symlinked from dotfiles-bin
  └── ...
```

### Usage

- Install: `stow bin` (from repo root)
- All scripts must be executable: `chmod +x bin/.local/dotfiles-bin/script-name`
- Ensure both paths are in PATH:
  - `~/.local/dotfiles-bin` (direct execution from repo)
  - `~/.local/bin` (stowed scripts)

## Task Management Policy (ALL AGENTS)

### Critical Rules

**NEVER auto-close, update, or delete tasks without explicit user confirmation.**

This applies to:

- ✅ Creating tasks: Allowed without confirmation
- ✅ Listing/viewing tasks: Allowed without confirmation
- ❌ Closing tasks: **REQUIRES USER CONFIRMATION**
- ❌ Updating task status: **REQUIRES USER CONFIRMATION**
- ❌ Deleting tasks: **REQUIRES USER CONFIRMATION**

### Workflow

1. Agent completes work
2. Agent reports completion to user
3. **User explicitly requests to close the task**
4. Agent then closes the task

### Examples

**❌ BAD (Auto-close):**

```
Agent: "I've completed the feature. Closing task dotfiles-abc..."
```

**✅ GOOD (Ask first):**

```
Agent: "I've completed the feature. Would you like me to close task dotfiles-abc?"
User: "Yes, close it"
Agent: "Closing task dotfiles-abc..."
```

**✅ ALSO GOOD (User initiates):**

```
Agent: "Implementation complete!"
User: "Close task abc"
Agent: "Closing task dotfiles-abc..."
```

## Claude Code Settings Management

### Overview

Claude Code settings are version-controlled in this repo and stowed to the home directory.

### Structure

```
claude/.claude/                 # Source location in repo
  ├── settings.json            # Claude Code settings
  ├── CLAUDE.md               # Project-specific instructions
  └── statusline.sh           # Custom status line script

~/.claude/                     # Installed location (via stow)
  ├── settings.json           # Symlinked from repo
  ├── CLAUDE.md              # Symlinked from repo
  └── statusline.sh          # Symlinked from repo
```

### Installation

```bash
# From repo root
stow claude
```

### Settings Configuration

**Allowed Commands:**

- Read, Edit, Write (file operations)
- Git commands (status, diff, log, add, commit, push, etc.)
- Package managers (npm, pip)
- Testing (pytest, jest, vitest)
- View-only bd/b2 commands (--help, --version, list, show, create)
- Utilities (shellcheck, stow)

**Denied Commands (require confirmation):**

- Destructive operations (rm, dd, mkfs, sudo)
- Secret files (.env, *.key,*.pem)
- Task modification (b2/bd close, update, delete)

### Modifying Settings

1. Edit `claude/.claude/settings.json` in the repo
2. Re-stow: `stow -R claude`
3. Restart Claude Code session for changes to take effect

### Important Notes

- All Claude Code config changes MUST happen in this repo
- Never edit `~/.claude/settings.json` directly (it's a symlink)
- Use `stow -R claude` to update after changes
- Settings apply to all projects when using Claude Code

## Windsurf Workflows Sync

### Overview

This repo uses an automated sync system to convert openskills (superpowers skills) into native Windsurf workflows, ensuring reliable skill invocation in Windsurf.

### When Skills Update

Run the sync command to regenerate Windsurf workflows from openskills:

```bash
superpowers-sync sync
```

### What Gets Synced

9 core skills are automatically converted to native Windsurf workflows:

- brainstorming
- systematic-debugging
- test-driven-development
- verification-before-completion
- writing-plans
- requesting-code-review
- receiving-code-review
- using-git-worktrees
- finishing-a-development-branch

### Architecture

- **Source of truth**: `.agent/skills/*/SKILL.md` (openskills)
- **Generated workflows**: `.codeium/windsurf/global_workflows/*.md`
- **Sync tool**: `bin/.local/dotfiles-bin/superpowers-sync`

### When to Sync

- After updating skills via openskills
- After pulling new skills from upstream
- When skills seem out of sync between Claude Code and Windsurf

### Plugin Skills Sync

To sync official Claude plugin skills (like frontend-design) to Windsurf workflows:

```bash
claude-plugins-sync sync
```

This discovers and syncs all skills from `~/.claude/plugins/marketplaces/claude-plugins-official/plugins` to Windsurf workflows using the naming format `plugin-name:skill-name`.

### Documentation

See `docs/windsurf-workflows-sync.md` for detailed usage and architecture.

## Neovim/LazyVim Configuration

### LazyVim Reference

When looking for LazyVim configurations, keymaps, icons, or plugin settings:

1. **Always check the local LazyVim installation FIRST:**
   - Base path: `~/.local/share/nvim/lazy/LazyVim/`
   - Plugin configs: `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/`
   - Core keymaps: `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/config/keymaps.lua`

2. **Only use web search/fetch if not found locally**

### Common LazyVim Files

- Editor plugins (gitsigns, telescope, neo-tree, etc.): `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/editor.lua`
- LSP configuration: `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/init.lua`
- UI plugins (bufferline, lualine, etc.): `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua`
- Coding plugins (completion, snippets): `~/.local/share/nvim/lazy/LazyVim/lua/lazyvim/plugins/coding.lua`
