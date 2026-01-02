# Common Pre-commit Hooks Reference

**Design:** Claude reads this when user asks "what hooks should I use?"

## Universal Hooks (All Projects)

From `pre-commit/pre-commit-hooks`:

| Hook | What It Does | Auto-fix |
|------|--------------|----------|
| trailing-whitespace | Removes trailing spaces | ✅ |
| end-of-file-fixer | Ensures newline at EOF | ✅ |
| check-yaml | Validates YAML syntax | ❌ |
| check-json | Validates JSON syntax | ❌ |
| check-merge-conflict | Detects `<<<<<<` markers | ❌ |
| detect-private-key | Prevents committing SSH keys | ❌ |
| check-added-large-files | Blocks files >500KB | ❌ |

**Recommendation:** Include these in ALL projects.

## Language-Specific

### Python

- **ruff** - Fast linter + formatter (replaces black, flake8, isort)
- **mypy** - Type checking
- **bandit** - Security linter

### JavaScript/TypeScript

- **eslint** - Linting + auto-fix
- **prettier** - Code formatter

### Go

- **golangci-lint** - Meta-linter (runs multiple linters)
- **gofmt** - Code formatter

### Rust

- **rustfmt** - Code formatter
- **clippy** - Linter

### Shell

- **shellcheck** - Static analysis (manual install)

### Markdown

- **markdownlint-cli2** - Style + syntax checker

### Lua

- **stylua** - Code formatter

## Security Hooks

- **detect-private-key** - SSH keys, credentials (built-in)
- **detect-secrets** - Hardcoded secrets scanner
- **gitleaks** - Comprehensive secret detection
- **bandit** - Python security issues

## Git Quality

- **no-commit-to-branch** - Protect main/master
- **conventional-pre-commit** - Enforce commit message format
- **check-merge-conflict** - Catch unresolved conflicts

## How to Use This Guide

**User asks:** "What hooks for Python?"

**Claude:**

1. Read this file
2. Show Python section
3. Recommend ruff (most popular)
4. Explain others (mypy, bandit)
5. User picks
6. Add to config

**User asks:** "Security hooks?"

**Claude:**

1. Show Security section
2. Recommend detect-private-key (built-in, fast)
3. Explain detect-secrets, gitleaks
4. User picks

## Finding More Hooks

Search: <https://pre-commit.com/hooks.html>

Categories:

- Language (Python, Go, Rust, etc.)
- Purpose (format, lint, security)
- Tool (eslint, prettier, etc.)
