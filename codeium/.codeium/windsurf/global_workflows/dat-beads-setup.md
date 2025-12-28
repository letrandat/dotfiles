---
description: Automate beads redirect pattern setup for new repositories
auto_execution_mode: 0
---

# Beads Redirect Pattern Setup (Antigravity Agent)

## When to Use This Workflow

Use this workflow when the user asks to:

- "Set up beads for this repo"
- "Configure beads redirect mode"
- "Add beads to this project"
- "Set up task tracking"

## Prerequisites

Check these first:

1. `bd` command is installed and available in PATH (`which bd`)
2. Planning repo exists: `~/.beads-planning`
3. User is on macOS/Linux

## Setup Process

### Step 1: Verify Planning Repo Exists

```bash
# Check if planning repo exists
ls -la ~/.beads-planning/.beads 2>/dev/null

# If doesn't exist, ask user:
echo "Planning repo ~/.beads-planning doesn't exist yet. Should I create it?"
```

### Step 2: Create Planning Repo (If Needed)

```bash
# Only run if user confirms and planning repo doesn't exist
mkdir -p ~/.beads-planning
cd ~/.beads-planning
git init
bd init --prefix plan

# Initial commit
git add .beads/ AGENTS.md @AGENTS.md
git commit -m "Initialize beads planning repository"
```

### Step 3: Set Up Current Project Repo

```bash
# Get current directory
PROJECT_DIR=$(pwd)

# Create .beads directory
mkdir -p .beads

# Create redirect file with ABSOLUTE path (critical!)
echo "/Users/$(whoami)/.beads-planning/.beads" > .beads/redirect

# Verify redirect was created correctly
cat .beads/redirect
# Should output: /Users/username/.beads-planning/.beads
```

### Step 4: Configure .gitignore

```bash
# Check if .gitignore exists
if [ ! -f .gitignore ]; then
  touch .gitignore
fi

# Add beads ignore rules (if not already present)
grep -q "^.beads/\*$" .gitignore || cat >> .gitignore <<'EOF'

# Beads - ignore database files, keep redirect and config
.beads/*
!.beads/redirect
!.beads/config.yaml
!.beads/.gitignore
EOF
```

### Step 5: Test the Setup

```bash
# Test that bd commands work
bd list | head -5
```

### Step 6: Commit Setup Files

```bash
# Stage the redirect and .gitignore
git add .beads/redirect .gitignore

# Commit
git commit -m "Configure beads redirect pattern

- Added .beads/redirect pointing to ~/.beads-planning
- Updated .gitignore to exclude beads database files"
```

## Migration from Existing Beads Setup

If the project already has a `.beads/` directory with tasks:

### Step 1: Ask User

"This project already has beads tasks. Should I migrate them to the planning repo?"

### Step 2: Migrate Tasks (If User Confirms)

```bash
# Backup existing .beads
cp -r .beads .beads.backup

# Copy tasks to planning repo
cp -r .beads/* ~/.beads-planning/.beads/

# Commit migration in planning repo
cd ~/.beads-planning
git add .beads/
git commit -m "Migrate tasks from $(basename $PROJECT_DIR)"

# Back to project
cd $PROJECT_DIR

# Remove old .beads (keep backup)
rm -rf .beads

# Create minimal .beads with redirect
mkdir -p .beads
echo "/Users/$(whoami)/.beads-planning/.beads" > .beads/redirect

# Test migration
bd list | head -5

# If works, commit
git add .beads/redirect .beads.backup/ .gitignore
git commit -m "Migrate to beads redirect pattern

- Migrated existing tasks to ~/.beads-planning
- Configured redirect to planning repo
- Kept backup in .beads.backup/"
```

## Verification Steps

After setup, ALWAYS verify:

```bash
# 1. Redirect exists and has correct path
cat .beads/redirect
# Should show: /Users/username/.beads-planning/.beads

# 2. bd commands work
bd list | head -3
```

## Next Steps

Once beads is set up:

- Create your first task: `bd create "My Task" -p 1`
- Check `@workflow dat-bd` workflow for command usage.
