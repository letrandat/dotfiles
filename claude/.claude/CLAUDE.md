# Dotfiles Project Instructions

## Task Management Policy (ALL AGENTS)

### Workflow
1. Agent completes work → Report to user
2. **User explicitly requests to close the task**
3. Agent then closes the task

### Beads (bd) Usage

This project uses beads for Task Management.

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
