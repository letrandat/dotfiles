# Dotfiles Project Instructions

## Task Management Policy (ALL AGENTS)

### Critical Rules

**NEVER auto-close or delete tasks without explicit user confirmation.**

This applies to:
- ✅ Creating tasks: Allowed without confirmation
- ✅ Listing/viewing tasks: Allowed without confirmation
- ❌ Closing tasks: **REQUIRES USER CONFIRMATION**
- ❌ Deleting tasks: **REQUIRES USER CONFIRMATION**

### Workflow
1. Agent completes work → Report to user
2. **User explicitly requests to close the task**
3. Agent then closes the task

### Beads (bd) Usage

This project uses beads with OSS contributor pattern (planning repo: ~/.beads-planning).

**Creating Tasks:**
- Use `bd create "Title" -p 1 --description "Detailed description"`
- Always provide rich descriptions with context, scope, and success criteria
- Structure like Jira: Title (short), Description (full body), Comments (updates)
- Use --description flag for initial task body
- Use `bd comment` for later updates/discussion

**Updating Tasks:**
- When implementation plan changes significantly, add comment: `bd comment plan-abc "Progress update..."`
- Document major scope changes, discoveries, or blockers
- Update description if task requirements fundamentally change

**Closing Tasks:**
- NEVER auto-close tasks
- When work is complete, ASK: "Should I close task plan-abc?"
- Only close after explicit user confirmation
- Agents frequently misjudge completion - always verify first

## Claude Code Settings Management

### Overview
This directory contains Claude Code settings that are version-controlled and stowed to `~/.claude/`.

### Important
- **Never edit `~/.claude/settings.json` directly** - it's a symlink to this repo
- All config changes must happen in `claude/.claude/settings.json`
- After editing, run `stow -R claude` to update symlinks
- Restart Claude Code session for changes to take effect

### Permissions Summary
- **Allowed**: Read-only bd/b2 commands (--help, --version, list, show, create)
- **Denied**: Task modifications (close, update, delete) - these require confirmation

## Git Worktree Workflow

## Directory Structure
- Main branch: `~/workspace/<repo-name>`
- Worktree branches: `~/worktree/<repo-name>/<short-name>`

## Worktree Creation
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
