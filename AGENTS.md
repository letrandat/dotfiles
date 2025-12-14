# Agents Configuration

**Before starting any work, run 'bd onboard' to understand the current project state and available issues.**

## Repository Overview

This is a dotfiles repository managed as a set of **GNU Stow packages**. Each top-level package folder contains files laid out to mirror their intended location under `$HOME`.

### XDG Base Directory

This repo assumes XDG-style config locations:

```bash
export XDG_CONFIG_HOME="$HOME/.config"
```

Most configs live under `~/.config/...` and are stowed there via package layout.

### macOS Application Support exception

Some GUI apps on macOS require config to live under:

`~/Library/Application Support/<App>/User`

This repo normalizes those configs back into `~/.config/...` via symlinks created by `setup.sh` (see below), so Stow can still manage them.

## Primary entry points

- **Bootstrap / symlinking**: `./setup.sh`
- **Install editor extensions**: `./install_extensions.sh`

### `setup.sh` behavior (authoritative)

`setup.sh`:

1. Ensures `stow` exists (installs via Homebrew on macOS if missing)
2. Ensures `~/.config` exists
3. On macOS, creates Application Support symlinks for:
   - `~/Library/Application Support/Code/User -> ~/.config/Code/User`
   - `~/Library/Application Support/Windsurf/User -> ~/.config/Windsurf/User`
   - `~/Library/Application Support/Antigravity/User -> ~/.config/Antigravity/User`
4. Removes a set of “legacy links” that may block stow
5. Runs `stow -d <repo> -t $HOME <package>` for all packages in the list

## Stow package map

Packages currently stowed by `setup.sh`:

- `zsh`
- `git`
- `tmux`
- `ideavim`
- `nvim` (includes `nvim`, `nvim-kickstart`, `nvim-vscode` appnames)
- `kitty`
- `ghostty`
- `lazygit`
- `intellimacs`
- `bin` (scripts in `~/.local/bin`)
- `vscode` (VS Code user config under `~/.config/Code/User`)
- `windsurf` (Windsurf user config under `~/.config/Windsurf/User`)
- `antigravity` (Antigravity user config under `~/.config/Antigravity/User`)
- `codeium` (Windsurf/Codeium assistant state and workflows under `.codeium/...`)
- `amp`

## Key workflow utilities (bin package)

These scripts are stowed into `~/.local/bin`:

- **`vscode-switcher`**: fzf-based directory picker to open a project in `code` / `windsurf` / `antigravity`.
  - Config: `~/.config/vscode-switcher/vscode-switcher.conf`
- **`tmux-sessionizer`**: fzf-based tmux session switcher/creator.
  - Config: `~/.config/tmux-sessionizer/tmux-sessionizer.conf`
  - Supports per-project hydration: `.tmux-sessionizer` file in the project root.
- **`vscode-tmux.sh`**: auto-attaches/creates a tmux session when launched inside an integrated VS Code terminal.

## Editor integration conventions

### Windsurf / VS Code

- Prefer keeping `keybindings.json` **small** and putting most “discoverable” keymaps under Which-Key.
- Which-Key is bound to `alt+space` (Windsurf config).
- `vscode-neovim` is configured to use appname `nvim-vscode`.

### Lazygit

Lazygit is configured to open files in Windsurf:

- Config: `lazygit/.config/lazygit/config.yml`
- Documentation: `lazygit/README.md`

### IntelliJ (IdeaVim + Intellimacs)

- Config entrypoint: `ideavim/.ideavimrc`
- Loads Intellimacs modules from `~/.config/intellimacs/*` (stowed from `intellimacs/` package)

## Git + repo hygiene

- Do not commit sensitive or machine-specific data.
- Use `.gitconfig-local` (not `.gitconfig`) for machine-specific overrides.
- Editor state folders (e.g. `History/`, `globalStorage/`, `workspaceStorage/`) are intentionally ignored.
- The beads SQLite DB should not be committed (ignored by `.beads/.gitignore`).

## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Why bd?

- Dependency-aware: Track blockers and relationships between issues
- Git-friendly: Auto-syncs to JSONL for version control
- Agent-optimized: JSON output, ready work detection, discovered-from links
- Prevents duplicate tracking systems and confusion

### Quick Start

**Check for ready work:**

```bash
bd ready --json
```

**Create new issues:**

```bash
bd create "Issue title" -t bug|feature|task -p 0-4 --json
bd create "Issue title" -p 1 --deps discovered-from:bd-123 --json
bd create "Subtask" --parent <epic-id> --json  # Hierarchical subtask (gets ID like epic-id.1)
```

**Claim and update:**

```bash
bd update bd-42 --status in_progress --json
bd update bd-42 --priority 1 --json
```

**Complete work:**

```bash
bd close bd-42 --reason "Completed" --json
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task**: `bd update <id> --status in_progress`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd close <id> --reason "Done"`
6. **Commit together**: Always commit the `.beads/issues.jsonl` file together with the code changes so issue state stays in sync with code state

### Auto-Sync

bd automatically syncs with git:

- Exports to `.beads/issues.jsonl` after changes (5s debounce)
- Imports from JSONL when newer (e.g., after `git pull`)
- No manual export/import needed!

### GitHub Copilot Integration

If using GitHub Copilot, also create `.github/copilot-instructions.md` for automatic instruction loading.
Run `bd onboard` to get the content, or see step 2 of the onboard instructions.

### MCP Server (Recommended)

If using Claude or MCP-compatible clients, install the beads MCP server:

```bash
pip install beads-mcp
```

Add to MCP config (e.g., `~/.config/claude/config.json`):

```json
{
  "beads": {
    "command": "beads-mcp",
    "args": []
  }
}
```

Then use `mcp__beads__*` functions instead of CLI commands.

### Managing AI-Generated Planning Documents

AI assistants often create planning and design documents during development:

- PLAN.md, IMPLEMENTATION.md, ARCHITECTURE.md
- DESIGN.md, CODEBASE_SUMMARY.md, INTEGRATION_PLAN.md
- TESTING_GUIDE.md, TECHNICAL_DESIGN.md, and similar files

**Best Practice: Use a dedicated directory for these ephemeral files**

**Recommended approach:**

- Create a `history/` directory in the project root
- Store ALL AI-generated planning/design docs in `history/`
- Keep the repository root clean and focused on permanent project files
- Only access `history/` when explicitly asked to review past planning

**Example .gitignore entry (optional):**

```
# AI planning documents (ephemeral)
history/
```

**Benefits:**

- ✅ Clean repository root
- ✅ Clear separation between ephemeral and permanent documentation
- ✅ Easy to exclude from version control if desired
- ✅ Preserves planning history for archeological research
- ✅ Reduces noise when browsing the project

### CLI Help

Run `bd <command> --help` to see all available flags for any command.
For example: `bd create --help` shows `--parent`, `--deps`, `--assignee`, etc.

### Important Rules

- ✅ Use bd for ALL task tracking
- ✅ Always use `--json` flag for programmatic use
- ✅ Link discovered work with `discovered-from` dependencies
- ✅ Check `bd ready` before asking "what should I work on?"
- ✅ Store AI planning docs in `history/` directory
- ✅ Run `bd <cmd> --help` to discover available flags
- ❌ Do NOT create markdown TODO lists
- ❌ Do NOT use external issue trackers
- ❌ Do NOT duplicate tracking systems
- ❌ Do NOT clutter repo root with planning documents

For more details, see README.md and QUICKSTART.md.
