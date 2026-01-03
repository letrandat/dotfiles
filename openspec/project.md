# Project Context

## Purpose

Personal dotfiles repository for managing development environment configurations across machines. The repository uses GNU Stow to create symbolic links from this repo to the home directory, enabling:

- Centralized version control for all configuration files
- Easy synchronization across multiple machines
- Consistent development environment setup
- Portable agent skills and custom automation scripts

## Tech Stack

### Core Tools

- **Shell**: Zsh with Oh-My-Zsh framework
- **Dotfiles Manager**: GNU Stow (symlink farm manager)
- **Editor**: Neovim with LazyVim configuration
- **Terminal**: Ghostty
- **Multiplexer**: Tmux with custom sessionizer
- **Version Control**: Git with Delta (diff/pager), LazyGit (TUI)

### AI Coding Assistants

- Claude Code (CLI)
- Windsurf
- VS Code with various extensions
- Antigravity Agent

### Development Utilities

- **Task Management**: Beads (git-based issue tracker)
- **Skills**: Openskills (portable agent skills)
- **Spec Management**: OpenSpec (spec-driven development)
- **Custom Scripts**: Located in `bin/.local/dotfiles-bin/`

### Languages & Formats

- Bash/Shell scripts
- Lua (Neovim configuration)
- Markdown (documentation)
- YAML/JSON (configuration files)

## Project Conventions

### Code Style

- **Shell Scripts**: Follow shellcheck recommendations, executable permissions required
- **Markdown**: Use markdownlint-cli2 with relaxed rules (MD013, MD041 disabled)
- **Naming**: kebab-case for files and directories
- **Scripts**: Shebang required (`#!/bin/bash` or `#!/usr/bin/env bash`)

### Architecture Patterns

**GNU Stow Package Structure**:

- Each top-level directory is a "package" representing an application
- Directory structure mirrors exact home directory paths
- Example: `zsh/.zshrc` → `~/.zshrc`, `nvim/.config/nvim/` → `~/.config/nvim/`

**XDG Base Directory Standard**:

- Use `~/.config/` for configuration files whenever possible
- Set `XDG_CONFIG_HOME="$HOME/.config"` in shell
- Avoid cluttering home directory root

**macOS Application Support Handling**:

- GUI apps requiring `~/Library/Application Support/` are symlinked to `~/.config/`
- This allows Stow to manage them like other configs
- Handled in `setup.sh` for VS Code, Windsurf, Antigravity

**Custom Scripts Convention**:

- Source: `bin/.local/dotfiles-bin/`
- Installed: Stowed to `~/.local/bin/` (symlinked)
- Both paths must be in `$PATH`
- All scripts must be executable: `chmod +x`

### Testing Strategy

**Manual Testing Only**:

- No automated test suite
- Scripts tested manually after changes
- Shellcheck used for static analysis of shell scripts
- Markdownlint for documentation quality

**Validation Approach**:

- Test setup.sh on clean environment when making structural changes
- Verify stow operations don't conflict with existing files
- Check custom scripts execute correctly after installation

### Git Workflow

**Commit Convention**:

- Follow Conventional Commits specification
- Format: `type(scope): subject` with bulleted body
- Template provided in `.gitmessage`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`
- Subject: imperative, present tense, no capitalization, no period
- Reference tasks: `(close abc)` in subject or body

**Branching Strategy**:

- Git worktrees for parallel development
- Main branch: `main`
- Descriptive branch names: `feature-name` or `bugfix-description`
- Use Which-Key + GitLens for worktree management

**Pull Request Process**:

- LazyGit for commit management
- Select correct worktree in LazyGit before committing
- Conventional commit messages required

## Domain Context

**Dotfiles Management**:

- Repository structure mirrors home directory structure exactly
- Stow "folds" package directories onto the target (home) directory
- Changes in repo are immediately reflected via symlinks
- Backup existing configs before stowing (setup.sh does this)

**Tmux Sessionizer Ecosystem**:

- Unified session management across editors and terminals
- Session naming: `parent_child` pattern based on working directory
- Auto-attach on terminal spawn (VS Code, Ghostty)
- Session switching: `Alt+Space → j → n` in editors, `prefix + f` in tmux
- Per-project hydration: `.tmux-sessionizer` files

**Which-Key Integration**:

- Consistent keybindings across Neovim and VS Code
- `Alt+Space` triggers Which-Key outside Neovim
- Maps to leader key bindings from Neovim
- Enables muscle memory consistency

**Windsurf Workflows Sync**:

- Openskills automatically synced to Windsurf workflows
- Command: `superpowers-sync sync`
- 9 core skills converted to native Windsurf workflows
- Plugin skills synced via `claude-plugins-sync sync`

## Important Constraints

**Platform**:

- Primary target: macOS (Darwin)
- Some cross-platform support, but macOS-specific handling required
- Application Support symlinks are macOS-only

**Installation**:

- Requires manual setup.sh execution
- Homebrew must be installed first
- No automated deployment or CI/CD

**File Management**:

- Never edit symlinked files in home directory directly
- Always edit source files in this repo
- Re-stow packages after structural changes: `stow -R <package>`

**Task Management Policy**:

- NEVER auto-close, update, or delete Beads tasks without explicit user confirmation
- Creating and listing tasks allowed without confirmation
- Closing/updating/deleting requires user approval first

## External Dependencies

**Package Managers**:

- Homebrew (macOS package manager)

**Required Tools**:

- GNU Stow (symlink manager)
- Git (version control)
- Zsh (shell)

**Optional but Expected**:

- Neovim (editor)
- Tmux (multiplexer)
- Ghostty (terminal)
- Delta (git diff)
- LazyGit (git TUI)
- fzf (fuzzy finder)
- ripgrep (search)
- Openskills (skill management)
- Beads (task management)

**AI Services**:

- Claude Code (Anthropic)
- GitHub Copilot (various extensions)
- Windsurf/Codeium
