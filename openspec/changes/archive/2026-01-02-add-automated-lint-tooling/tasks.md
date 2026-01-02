# Tasks: Add Automated Lint Tooling

## 0. Install Pre-commit Skill (from Marketplace)

- [ ] 0.1 Install `@Jamie-BitFlight/claude_skills/pre-commit` from Claude plugins marketplace
- [ ] 0.2 Verify skill is available for educational queries
- [ ] 0.3 Test skill: Ask "What is pre-commit?" to verify it responds

**Purpose:** Provides education, guidance, and troubleshooting for pre-commit

## 1. Install Core Dependencies

**Only pre-commit needs manual install - it auto-installs most linters!**

- [ ] 1.1 Install `pre-commit` framework: `pip install pre-commit` or `brew install pre-commit`
- [ ] 1.2 Install `shellcheck` (manual required): `brew install shellcheck`
- [ ] 1.3 Run `pre-commit install` to set up git hooks
- [ ] 1.4 Document that pre-commit auto-installs: ruff, stylua, eslint, golangci-lint

**Auto-installed by pre-commit (no action needed):**

- ✅ Python: `ruff` (pre-commit manages)
- ✅ Lua: `stylua` (pre-commit manages)
- ✅ JavaScript: `eslint` (pre-commit manages)
- ✅ TypeScript: `@typescript-eslint` (pre-commit manages)
- ✅ Go: `golangci-lint` (pre-commit manages)

## 2. Configure pre-commit Framework

- [ ] 2.1 Create `.pre-commit-config.yaml` in repository root
- [ ] 2.2 Add markdownlint-cli2 hook with `--fix` arg
- [ ] 2.3 Add shellcheck hook for bash/zsh scripts
- [ ] 2.4 Add stylua hook for Lua formatting
- [ ] 2.5 Add ruff hook with `--fix` arg for Python
- [ ] 2.6 Add eslint hook with auto-fix for JavaScript
- [ ] 2.7 Add @typescript-eslint/eslint-plugin hook for TypeScript
- [ ] 2.8 Add golangci-lint hook for Go files
- [ ] 2.9 Verify all hooks use appropriate `rev:` (version pinning)

## 3. Create Language-Specific Configurations (Optional)

**Note**: Only create if you need custom rules. pre-commit hooks work with sensible defaults.

- [ ] 3.1 Create `.markdownlint.json` with project-specific Markdown rules
- [ ] 3.2 Create `stylua.toml` for Lua formatting preferences
- [ ] 3.3 Create `.shellcheckrc` for shellcheck custom settings
- [ ] 3.4 Create `ruff.toml` or update `pyproject.toml` for Python rules
- [ ] 3.5 Create `.eslintrc.json` for JavaScript/TypeScript rules
- [ ] 3.6 Create `tsconfig.json` if TypeScript is used
- [ ] 3.7 Create `.golangci.yml` for Go linter configuration

## 4. Update Claude Code Configuration

- [ ] 4.1 Update `.claude/settings.json` to add `pre-commit` to allowed commands
- [ ] 4.2 Update `CLAUDE.md` with new lint workflow using `pre-commit run`
- [ ] 4.3 Add instructions for manual runs: `pre-commit run --files $(git diff --name-only)`
- [ ] 4.4 Document how to run on all files: `pre-commit run --all-files`
- [ ] 4.5 Document fallback behavior when tools unavailable
- [ ] 4.6 Add examples of lint-then-commit workflow

## 5. Testing and Validation

- [ ] 5.1 Test pre-commit hooks on sample files (one per language)
- [ ] 5.2 Test manual run: `pre-commit run --all-files`
- [ ] 5.3 Test git hook: make a commit and verify linters run automatically
- [ ] 5.4 Verify auto-fix works for each language
- [ ] 5.5 Test that Claude Code can invoke `pre-commit` without permission prompts
- [ ] 5.6 Document any language-specific edge cases

## 6. Documentation

- [ ] 6.1 Create or update docs explaining the pre-commit setup
- [ ] 6.2 Document how to skip hooks if needed (SKIP=... git commit)
- [ ] 6.3 Document how to add new languages (just update .pre-commit-config.yaml)
- [ ] 6.4 Add troubleshooting section for common issues
- [ ] 6.5 Document uninstall: `pre-commit uninstall`
