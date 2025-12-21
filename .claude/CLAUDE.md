# Dotfiles Project Instructions

## Git Worktree Workflow

### Directory Structure
- Main branch: `~/workspace/<repo-name>`
- Worktree branches: `~/worktree/<repo-name>/<short-name>`

### Worktree Creation
Use the `git-worktree-create` script:

Usage:
  git-worktree-create <short-name> [full-branch-name]

Examples:
  git-worktree-create ABC-123              # Auto: feat/ABC-123 (home) or usr/dat/ABC-123 (work)
  git-worktree-create bugfix               # Auto: feat/bugfix (home) or usr/dat/bugfix (work)
  git-worktree-create ABC-123 bug/auth-fix # Explicit branch name

Branch Naming:
- Home (pwd starts with /Users/dat/): feat/<name> or bug/<name>
- Work (otherwise): usr/dat/<name>

Path Conventions:
- Keep short-name brief (prefer ticket numbers like ABC-123)
- Git branch names can be longer and more descriptive
- Worktree path: ~/worktree/<repo-name>/<short-name>

When I need to create a worktree:
1. Call git-worktree-create with appropriate short-name
2. Use the returned path for all work
3. After work is complete, use finishing-a-development-branch skill

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
- Secret files (.env, *.key, *.pem)
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
openskills-to-windsurf sync
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
- **Sync tool**: `bin/.local/dotfiles-bin/openskills-to-windsurf`

### When to Sync
- After updating skills via openskills
- After pulling new skills from upstream
- When skills seem out of sync between Claude Code and Windsurf

### Documentation
See `docs/windsurf-workflows-sync.md` for detailed usage and architecture.
