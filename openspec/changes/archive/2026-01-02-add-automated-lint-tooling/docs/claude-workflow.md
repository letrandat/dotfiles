# Claude Code + Pre-commit Workflow

**Design principle:** Keep CLAUDE.md short. Claude reads this doc when needed.

## Core Workflow

### 1. Detect & Install

```bash
# Claude checks
which pre-commit || echo "Not installed"

# If missing, Claude proposes
brew install pre-commit  # macOS
# OR
pip3 install pre-commit  # Linux
```

### 2. Initialize in Repository

```bash
# Detect languages
find . -name "*.py" -o -name "*.js" -o -name "*.sh" -o -name "*.md"

# Create config (copy from docs/default-config.yaml)
# Uncomment relevant language sections

# Setup hooks
pre-commit install
pre-commit run --all-files
```

### 3. Before Every Commit

```bash
# Claude runs automatically
pre-commit run --files $(git diff --name-only --cached)

# If failures: fix → re-run → commit
```

### 4. Discover New Hooks

```bash
# User asks: "What hooks for security?"
# Claude: WebFetch https://pre-commit.com/hooks.html
# Search for "security" → present options → explain → add if approved
```

### 5. Update Hook Versions

```bash
pre-commit autoupdate
pre-commit run --all-files  # Test
git commit -m "chore: update pre-commit hooks"
```

## Common Commands

```bash
pre-commit install              # Setup (once per repo)
pre-commit run                  # Check staged files
pre-commit run --all-files      # Check everything
pre-commit autoupdate           # Update versions
SKIP=hook-name git commit       # Skip temporarily
pre-commit uninstall            # Remove hooks
```

## Hook Discovery

When unsure about hooks:

1. WebFetch: <https://pre-commit.com/hooks.html>
2. Search by language or keyword
3. Read hook description
4. Explain to user
5. Add if approved
6. Test: `pre-commit run --all-files`

## Example: Adding Rust Support

```
User: "Add Rust linting"

Claude:
1. WebFetch pre-commit.com/hooks.html
2. Find: rustfmt, clippy
3. Explain both
4. User picks clippy
5. Add to .pre-commit-config.yaml:
   ```yaml
   - repo: https://github.com/doublify/pre-commit-rust
     rev: v1.0
     hooks:
       - id: clippy
   ```

1. Run: pre-commit run --all-files
2. Report results

```

## Troubleshooting

**Hook fails:**
- Check error message
- Fix issue
- Re-run
- Don't commit until passing

**Tool missing:**
- Most auto-install (ruff, eslint, etc.)
- Some need manual: shellcheck

**Skip if needed:**
```bash
SKIP=shellcheck git commit -m "..."
```
