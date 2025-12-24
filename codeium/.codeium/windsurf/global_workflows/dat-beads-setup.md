---
name: dat-beads-setup
description: Automate beads OSS contributor pattern setup for new repositories
---

# Beads OSS Contributor Pattern Setup (Windsurf Agent)

## When to Use This Workflow

Use this workflow when the user asks to:
- "Set up beads for this repo"
- "Configure beads contributor mode"
- "Add beads to this project"
- "Set up task tracking"

## Prerequisites

Check these first:
1. Planning repo exists: `~/.beads-planning`
2. User is on macOS/Linux (uses `/Users/username` or `/home/username`)

If planning repo doesn't exist, ask user if they want to create it first.

## Setup Process

### Step 1: Verify Planning Repo Exists

```bash
# Check if planning repo exists
ls -la ~/.beads-planning/.beads 2>/dev/null

# If doesn't exist, ask user:
"Planning repo ~/.beads-planning doesn't exist yet. Should I create it?"
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

# Inform user
"Created planning repo at ~/.beads-planning with prefix 'plan'"
```

### Step 3: Set Up Current Project Repo

```bash
# Get current directory
PROJECT_DIR=$(pwd)

# Create .beads directory
mkdir -p .beads

# Create redirect file with ABSOLUTE path (critical!)
# Use $(whoami) to get username dynamically
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

# If this works, setup is successful
# If errors, check:
# 1. Redirect file exists: ls -la .beads/redirect
# 2. Path is absolute: cat .beads/redirect
# 3. Planning repo exists: ls -la ~/.beads-planning/.beads
```

### Step 6: Commit Setup Files

```bash
# Stage the redirect and .gitignore
git add .beads/redirect .gitignore

# Commit
git commit -m "Configure beads OSS contributor pattern

- Added .beads/redirect pointing to ~/.beads-planning
- Updated .gitignore to exclude beads database files"

# Inform user
"Setup complete! bd commands in this repo now use ~/.beads-planning"
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
git commit -m "Migrate to beads OSS contributor pattern

- Migrated existing tasks to ~/.beads-planning
- Configured redirect to planning repo
- Kept backup in .beads.backup/"
```

## Verification Steps

After setup, ALWAYS verify:

```bash
# 1. Redirect exists and has correct path
echo "Checking redirect file:"
cat .beads/redirect
# Should show: /Users/username/.beads-planning/.beads

# 2. bd commands work
echo "Testing bd list:"
bd list | head -3

# 3. Create test task
echo "Creating test task:"
bd create "Test beads setup" -p 1 --description "Verifying OSS contributor pattern works"

# 4. Verify it went to planning repo
echo "Verifying task in planning repo:"
cd ~/.beads-planning
bd list | grep "Test beads setup"

# 5. Get task ID and close it
TASK_ID=$(bd list --json | jq -r '.[] | select(.title | contains("Test beads setup")) | .id' | head -1)
bd close $TASK_ID --reason "Test successful"

# 6. Confirm project repo is clean
cd $PROJECT_DIR
git status
# Should NOT show beads database files
```

## Common Issues and Fixes

### Issue: "redirect target does not exist"

**Cause**: Redirect file has relative path or tilde (~)

**Fix**:
```bash
# Use absolute path
echo "/Users/$(whoami)/.beads-planning/.beads" > .beads/redirect

# NOT: ~/.beads-planning/.beads (wrong)
# NOT: $HOME/.beads-planning/.beads (wrong)
```

### Issue: Tasks creating in wrong repo

**Cause**: No redirect file or wrong path

**Fix**:
```bash
# Verify redirect exists
ls -la .beads/redirect || echo "MISSING!"

# Check content
cat .beads/redirect
# Must be absolute path starting with /
```

### Issue: bd commands slow

**Cause**: Old daemon running

**Fix**:
```bash
bd daemons killall
bd --version  # Should restart with fresh daemon
```

## Success Criteria

Setup is complete when ALL of these are true:

✅ Planning repo exists at `~/.beads-planning`
✅ Project has `.beads/redirect` file with absolute path
✅ Project `.gitignore` excludes beads database files
✅ `bd list` works from project directory
✅ Test task creates in planning repo (verified)
✅ Git status shows no beads database files
✅ Setup committed to git

## Example Complete Interaction

```
User: "Set up beads for this repo"

Agent:
1. Checking for planning repo... ✓ Found at ~/.beads-planning
2. Creating .beads/redirect... ✓ Created
3. Updating .gitignore... ✓ Updated
4. Testing setup...
   - Created test task: plan-abc
   - Verified in planning repo ✓
   - Closed test task ✓
5. Committing setup... ✓ Committed

Setup complete! You can now use bd commands in this repo.
All tasks will be stored in ~/.beads-planning.

Try:
  bd create "My first task" -p 1 --description "Details here"
  bd list
  bd ready
```

## Important Notes

1. **Always use absolute paths** in redirect file (not ~ or $HOME)
2. **Always test** before committing
3. **Always verify** tasks go to planning repo
4. **Always commit** the redirect file so others can use it
5. **Never commit** database files (.beads/beads.db, issues.jsonl, etc.)

## Quick Setup Command (For Reference)

This is the minimal command sequence for quick setup:

```bash
mkdir -p .beads
echo "/Users/$(whoami)/.beads-planning/.beads" > .beads/redirect
cat >> .gitignore <<'EOF'
.beads/*
!.beads/redirect
!.beads/config.yaml
EOF
git add .beads/redirect .gitignore
git commit -m "Add beads OSS contributor setup"
bd list  # Test it works
```

But ALWAYS follow the full process above for robustness!
