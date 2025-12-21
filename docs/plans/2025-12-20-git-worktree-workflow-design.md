# Git Worktree Workflow Design

**Date:** 2025-12-20
**Status:** Approved

## Overview

Implement a git worktree workflow with automated script and CLAUDE.md integration to manage feature branches in isolated workspaces.

## Directory Structure

- **Main branch:** `~/workspace/<repo-name>`
- **Worktree branches:** `~/worktree/<repo-name>/<short-name>`

## Script: git-worktree-create

### Interface

```bash
git-worktree-create <short-name> [full-branch-name]
```

**Arguments:**
- `short-name` (required): Short identifier for filesystem path (e.g., `ABC-123`, `bugfix`)
- `full-branch-name` (optional): Full git branch name (auto-generated if not provided)

**Output:**
- On success: Print worktree path to stdout
- On error: Print error to stderr, exit non-zero

### Detection Logic

#### 1. Home vs Work Detection
```bash
if [[ "$(pwd)" == /Users/dat/* ]]; then
    location="home"
else
    location="work"
fi
```

#### 2. Repo Name Detection
- Parse from `git remote get-url origin`
- Extract from GitHub URL patterns:
  - SSH: `git@github.com:owner/repo.git` → `repo`
  - HTTPS: `https://github.com/owner/repo.git` → `repo`
- Remove `.git` suffix

#### 3. Branch Name Generation
If `full-branch-name` not provided:
- **Home:** `feat/<short-name>`
- **Work:** `usr/dat/<short-name>`

#### 4. Worktree Path
Always: `~/worktree/<repo-name>/<short-name>`

### Error Handling

- Not in a git repository
- Remote origin not found or not GitHub
- Worktree directory already exists
- Git worktree add fails

## Script Implementation

### Structure

```bash
#!/usr/bin/env bash

sanity_check() {
    # Check if in git repo
    # Check if git command exists
}

detect_location() {
    if [[ "$(pwd)" == /Users/dat/* ]]; then
        echo "home"
    else
        echo "work"
    fi
}

get_repo_name() {
    # git remote get-url origin
    # Parse: git@github.com:owner/repo.git → repo
    # Parse: https://github.com/owner/repo.git → repo
}

generate_branch_name() {
    local short_name="$1"
    local location="$2"

    if [[ "$location" == "home" ]]; then
        echo "feat/$short_name"
    else
        echo "usr/dat/$short_name"
    fi
}

main() {
    # Parse arguments
    # Run detections
    # Create worktree
    # Print path
}
```

### Flow

1. Sanity check (git repo exists, git installed)
2. Detect location (home/work)
3. Get repo name from remote
4. Use provided branch name OR generate it
5. Construct worktree path
6. Create parent directory: `mkdir -p ~/worktree/<repo-name>`
7. Run: `git worktree add ~/worktree/<repo-name>/<short-name> -b <branch-name>`
8. Print worktree path to stdout

## CLAUDE.md Integration

Update `/Users/dat/workspace/dotfiles/claude/.claude/CLAUDE.md`:

```markdown
# Git Worktree Workflow

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
```

## Deployment

### File Location
```
dotfiles/bin/.local/dotfiles-bin/git-worktree-create
```

### Stow Structure
```
dotfiles/
├── bin/
│   └── .local/
│       └── dotfiles-bin/
│           ├── git-worktree-create  # New script
│           ├── tmux-sessionizer
│           └── ... other scripts
└── claude/
    └── .claude/
        └── CLAUDE.md  # Updated
```

### Steps
1. Create script: `bin/.local/dotfiles-bin/git-worktree-create`
2. Make executable: `chmod +x bin/.local/dotfiles-bin/git-worktree-create`
3. Stow creates symlink: `~/.local/dotfiles-bin/git-worktree-create`
4. Assumes `~/.local/dotfiles-bin` is in `$PATH`

## Testing

- Test from home location (`/Users/dat/...`)
- Test from work location (any other path)
- Verify correct branch name generation for both
- Verify repo name detection from various remote formats (SSH, HTTPS)
- Test error cases (not in git repo, worktree exists, etc.)

## Usage by Claude

The script is designed for LLM usage:
- Non-interactive (no stdin prompts)
- Clear stdout/stderr separation
- Predictable error codes
- Consistent behavior for automation
