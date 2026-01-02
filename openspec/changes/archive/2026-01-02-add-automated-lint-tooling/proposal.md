# Change: Add Automated Lint Tooling for Multi-Language Support

## Why

Currently, Claude Code must manually check for lint issues using IDE diagnostics (when available) or language-specific tools. This is error-prone and inconsistent across different execution modes (IDE vs standalone).

**Problems with current approach:**

- IDE diagnostics only work when launched from Neovim
- No awareness of pre-commit or git hooks
- Manual lint checking is error-prone
- No discovery mechanism for new linters
- Can't explore linting options collaboratively with user

**Philosophy - Editor-free Operation:**

Claude Code should work excellently **without any editor**. Editors (Neovim, VSCode) are nice-to-have, not requirements. Claude should excel at using CLI tools (git, pre-commit, linters) directly, making it effective in:

- Standalone mode (no IDE)
- SSH sessions
- CI/CD pipelines
- Headless environments

This proposal prioritizes CLI-first tooling over editor integrations.

We need an automated, git-aware linting system with intelligent Claude Code integration that:

1. **Detects and auto-installs** pre-commit when missing
2. **Works consistently** in all modes (IDE and standalone)
3. **Auto-fixes** lint issues when possible
4. **Only checks changed files** (git-aware)
5. **Supports multiple languages** (Markdown, Lua, JavaScript, TypeScript, Go, Bash/Zsh, Python)
6. **Auto-installs linters** via pre-commit's environment management
7. **Discovers hooks intelligently** by searching pre-commit.com
8. **Explores collaboratively** with user to find useful hooks
9. **Provides custom skills** for pre-commit management (init, add-hook, explore, check, update)

## What Changes

### Core Infrastructure

- **NEW**: Integrate `pre-commit` framework as the foundation for automated linting
- **NEW**: Add language-specific linter configurations via `.pre-commit-config.yaml` (per-repository):
  - **Markdown**: `markdownlint-cli2` with auto-fix
  - **Lua**: `stylua` for formatting (auto-installed by pre-commit)
  - **Bash/Zsh**: `shellcheck` for static analysis (manual install required)
  - **Python**: `ruff` for linting + formatting (auto-installed by pre-commit)
  - **JavaScript**: `eslint` with auto-fix (auto-installed by pre-commit)
  - **TypeScript**: `eslint` + `@typescript-eslint` (auto-installed by pre-commit)
  - **Go**: `golangci-lint` for linting (auto-installed by pre-commit)
- **NEW**: Universal hooks for all projects (trailing-whitespace, check-yaml, detect-private-key, etc.)
- **NEW**: Configure auto-fix where available (built into pre-commit hooks)

### Pre-commit Integration

- **USE**: Existing pre-commit skill from Claude plugins marketplace:
  - Skill: `@Jamie-BitFlight/claude_skills/pre-commit`
  - URL: <https://claude-plugins.dev/skills/@Jamie-BitFlight/claude_skills/pre-commit>
  - Provides: Education, configuration, troubleshooting, hook management, all pre-commit functionality

### Global Configuration

- **UPDATE**: `.claude/settings.json` to add `pre-commit` to allowed commands
  - Allows Claude to run pre-commit CLI commands without permission prompts

### Documentation

- All pre-commit documentation and guidance provided by existing skill
- No additional documentation needed

**Key Principles**:

- Use existing skill for all pre-commit functionality
- No custom automation - leverage what already exists
- Most linters are auto-installed by pre-commit in isolated environments
- `.pre-commit-config.yaml` is per-repository (project-specific config)

## Impact

### Affected Specifications

- **NEW**: `lint-automation` capability with 8 requirements:
  - Multi-language support
  - Automated linter installation
  - Git-aware file detection
  - Pre-commit integration
  - Manual linting commands
  - Claude Code integration
  - Language extensibility
  - Graceful degradation

### Affected Files (Per-Repository)

- `.pre-commit-config.yaml` (new) - Per-repo hook configuration
- `CLAUDE.md` (updated) - Project-specific pre-commit workflow
- `.claude/settings.json` (updated) - Add `pre-commit` to allowed commands
- Language-specific configs (optional):
  - `.markdownlint.json` - Markdown rules
  - `.shellcheckrc` - Shell script settings
  - `.eslintrc.json` - JavaScript/TypeScript rules
  - `ruff.toml` or `pyproject.toml` - Python settings
  - `.golangci.yml` - Go linter settings

### External Dependencies

- **Required**: `@Jamie-BitFlight/claude_skills/pre-commit` (from Claude plugins marketplace)
  - Provides: All pre-commit functionality (education, configuration, troubleshooting)
  - Install: Via Claude plugins marketplace
  - URL: <https://claude-plugins.dev/skills/@Jamie-BitFlight/claude_skills/pre-commit>

### Documentation

- All documentation provided by existing skill `@Jamie-BitFlight/claude_skills/pre-commit`
- No proposal-specific docs needed

### User Experience Changes

**Before:**

- Claude manually checks IDE diagnostics (IDE mode only)
- No lint checking in standalone mode
- No pre-commit knowledge or integration

**After:**

- Use existing skill for all pre-commit tasks
- Skill provides education, setup, troubleshooting
- Works via CLI (editor-free)
- Access to full pre-commit functionality through marketplace skill

**Key Points**:

- `.pre-commit-config.yaml` is **per-repository**, NOT global
- Each project can have different linting rules
- Adding languages only requires updating config (no code changes)
- pre-commit auto-installs most linters in isolated environments
- Claude Code actively helps discover and manage hooks

## Existing Solutions

This proposal leverages existing, battle-tested tools:

- **pre-commit** (<https://pre-commit.com/>): Multi-language framework for git hooks
- **markdownlint-cli2**: Fast Markdown linter with auto-fix
- **luacheck/stylua**: Lua linting and formatting
- **shellcheck**: Shell script static analysis
- **eslint**: JavaScript/TypeScript linting
- **ruff**: Fast Python linter and formatter (replaces black + flake8 + isort)

Alternative considered: Building custom tooling → Rejected in favor of proven ecosystem tools
