## ADDED Requirements

### Requirement: Multi-Language Lint Support

The system SHALL support automated linting and auto-fixing for multiple programming languages including Markdown, Lua, JavaScript, TypeScript, Go, Bash/Zsh, and Python.

#### Scenario: Markdown file linting

- **WHEN** a Markdown file is modified
- **THEN** markdownlint-cli2 SHALL check for formatting and style issues
- **AND** auto-fix SHALL be applied when possible

#### Scenario: Shell script linting

- **WHEN** a Bash or Zsh script is modified
- **THEN** shellcheck SHALL perform static analysis
- **AND** warnings and errors SHALL be reported

#### Scenario: Lua file linting

- **WHEN** a Lua file is modified
- **THEN** stylua SHALL check for style issues
- **AND** auto-formatting SHALL be applied

#### Scenario: Python file linting

- **WHEN** a Python file is modified
- **THEN** ruff SHALL check for linting and formatting issues
- **AND** auto-fix SHALL be applied when possible

#### Scenario: JavaScript file linting

- **WHEN** a JavaScript file is modified
- **THEN** eslint SHALL check for code quality and style issues
- **AND** auto-fix SHALL be applied when possible

#### Scenario: TypeScript file linting

- **WHEN** a TypeScript file is modified
- **THEN** eslint with @typescript-eslint SHALL check for type and style issues
- **AND** auto-fix SHALL be applied when possible

#### Scenario: Go file linting

- **WHEN** a Go file is modified
- **THEN** golangci-lint SHALL check for code quality issues
- **AND** linting results SHALL be reported

### Requirement: Automated Linter Installation

The system SHALL leverage pre-commit's environment management to automatically install most linters, minimizing manual setup requirements.

#### Scenario: Auto-install Python linters

- **WHEN** pre-commit encounters a Python hook (e.g., ruff)
- **THEN** pre-commit SHALL create an isolated Python environment
- **AND** install the linter automatically without user intervention

#### Scenario: Auto-install Node linters

- **WHEN** pre-commit encounters a Node hook (e.g., eslint)
- **THEN** pre-commit SHALL create an isolated Node environment
- **AND** install the linter and dependencies automatically

#### Scenario: Auto-install Go linters

- **WHEN** pre-commit encounters a Go hook (e.g., golangci-lint)
- **THEN** pre-commit SHALL create an isolated Go environment
- **AND** install the linter automatically

#### Scenario: Manual install for system tools

- **WHEN** a hook uses `language: system` (e.g., shellcheck)
- **THEN** the tool MUST be manually installed by the user
- **AND** clear error messages SHALL indicate installation requirements

### Requirement: Git-Aware File Detection

The system SHALL only lint files that have been modified according to git status, avoiding unnecessary checks on unchanged files.

#### Scenario: Detect changed files

- **WHEN** `pre-commit run --files $(git diff --name-only)` is invoked
- **THEN** only files returned by git diff SHALL be checked
- **AND** unchanged files SHALL be skipped

#### Scenario: Staged files only mode

- **WHEN** pre-commit hooks run
- **THEN** only staged files SHALL be linted
- **AND** linting SHALL happen before commit completes

### Requirement: Pre-Commit Integration

The system SHALL integrate with the pre-commit framework to automatically run linters before git commits.

#### Scenario: Install pre-commit hooks

- **WHEN** pre-commit install is run
- **THEN** git hooks SHALL be configured in .git/hooks/
- **AND** hooks SHALL trigger on git commit

#### Scenario: Auto-fix during commit

- **WHEN** a commit is attempted with linting errors
- **THEN** auto-fix SHALL attempt to resolve issues
- **AND** fixed files SHALL be re-staged automatically

#### Scenario: Manual hook bypass

- **WHEN** user needs to skip hooks (SKIP=...)
- **THEN** pre-commit SHALL allow selective hook disabling
- **AND** commit SHALL proceed without running skipped hooks

### Requirement: Manual Linting Commands

The system SHALL support manual invocation of linters using pre-commit's native commands, without requiring custom scripts.

#### Scenario: Check changed files only

- **WHEN** `pre-commit run --files $(git diff --name-only)` is invoked
- **THEN** only modified files SHALL be checked by appropriate linters
- **AND** results SHALL be displayed to the user

#### Scenario: Check all files

- **WHEN** `pre-commit run --all-files` is invoked
- **THEN** all tracked files SHALL be checked by appropriate linters
- **AND** results SHALL be displayed to the user

#### Scenario: Auto-fix during manual run

- **WHEN** hooks are configured with auto-fix flags (e.g., --fix)
- **THEN** pre-commit SHALL automatically apply fixes during manual runs
- **AND** modified files SHALL be saved with fixes applied

### Requirement: Claude Code Integration

Claude Code SHALL use pre-commit as a final verification step before committing changes, ensuring code quality standards are met.

#### Scenario: Pre-commit lint check

- **WHEN** Claude Code is ready to commit
- **THEN** `pre-commit run --files $(git diff --name-only --cached)` SHALL be run on staged files
- **AND** any remaining errors SHALL be manually fixed
- **AND** commit SHALL only proceed after all lint issues are resolved

#### Scenario: Standalone mode support

- **WHEN** Claude Code runs in standalone mode (no IDE MCP)
- **THEN** pre-commit SHALL work as primary lint mechanism
- **AND** language-specific hooks SHALL provide diagnostics

#### Scenario: IDE mode augmentation

- **WHEN** Claude Code runs with IDE MCP available
- **THEN** pre-commit SHALL complement IDE diagnostics
- **AND** both mechanisms SHALL be used for comprehensive checking

### Requirement: Language Extensibility

The system SHALL support adding new languages by only updating configuration files, without requiring code changes.

#### Scenario: Add new language support

- **WHEN** a new language needs linting (e.g., Go, Rust, TypeScript)
- **THEN** adding a new repo entry to `.pre-commit-config.yaml` SHALL be sufficient
- **AND** no custom scripts or code changes SHALL be required

#### Scenario: Language-specific configuration

- **WHEN** a language requires custom settings (e.g., .eslintrc, ruff.toml)
- **THEN** configuration files SHALL be created in the project root
- **AND** pre-commit hooks SHALL automatically use these configurations

#### Scenario: Hook ecosystem discovery

- **WHEN** looking for linters for a new language
- **THEN** <https://pre-commit.com/hooks.html> SHALL provide available hooks
- **AND** hooks SHALL follow standard pre-commit YAML format

### Requirement: Graceful Degradation

The system SHALL gracefully handle cases where lint tools are not installed, providing clear error messages and falling back to available tools.

#### Scenario: Missing linter

- **WHEN** a required linter is not installed
- **THEN** a clear error message SHALL indicate which tool is missing
- **AND** instructions for installation SHALL be provided

#### Scenario: Partial tool availability

- **WHEN** some but not all linters are available
- **THEN** available linters SHALL run normally
- **AND** unavailable linters SHALL be skipped with warnings
