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
