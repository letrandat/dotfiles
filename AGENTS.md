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
- `bin` (scripts in `~/.local/dotfiles-bin` — separate from external binaries in `~/.local/bin`)
- `vscode` (VS Code user config under `~/.config/Code/User`)
- `windsurf` (Windsurf user config under `~/.config/Windsurf/User`)
- `antigravity` (Antigravity user config under `~/.config/Antigravity/User`)
- `codeium` (Windsurf/Codeium assistant state and workflows under `.codeium/...`)
- `amp`

## Key workflow utilities (bin package)

These scripts are stowed into `~/.local/dotfiles-bin`:

- **`tmux-sessionizer`**: fzf-based tmux session switcher/creator.
  - Config: `~/.config/tmux-sessionizer/tmux-sessionizer.conf`
  - Supports per-project hydration: `.tmux-sessionizer` file in the project root.
  - Keybindings: `Ctrl+F` in terminal
- **`tmux-autoattach.sh`**: auto-attaches/creates a tmux session when launched in supported terminals (VS Code-like editors, Ghostty).

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

### Commit Messages

Follow the **Conventional Commits** specification with a bulleted body for details. A `.gitmessage` template is provided and configured.

```text
type(scope): subject

- Detail 1
- Detail 2
- Detail 3
```

- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`
- **Subject**: Imperative, present tense, no capitalization, no period.
- **Body**: Use a bulleted list (`- `) to explain *what* and *why*.
- **Task IDs**: Reference beads task IDs in the subject or body (e.g., `fix(b2): expand short hashes (close 5jp)`).

## Issue Tracking

This project uses **[beads](https://github.com/steveyegge/beads)** for issue tracking, with a custom stealth-first wrapper called **b2**.

**Quick reference:**
- `b2 ready` - Find unblocked work
- `b2 create "Title" --type task --priority 2` - Create issue
- `b2 show <id>` - Show issue details (supports short hashes like `5jp`)
- `b2 close <id>` - Complete work
- `b2 --no-stealth sync` - Sync with git (run at session end)

**Setup on New Machine:**
1. `b2 init` - Initialize (auto-installs bd if missing)
2. `b2 --no-stealth sync` - Pull tasks from the `beads-sync` branch

<skills_system priority="1">

## Available Skills

<!-- SKILLS_TABLE_START -->
<usage>
When users ask you to perform tasks, check if any of the available skills below can help complete the task more effectively. Skills provide specialized capabilities and domain knowledge.

How to use skills:
- Invoke: Bash("openskills read <skill-name>")
- The skill content will load with detailed instructions on how to complete the task
- Base directory provided in output for resolving bundled resources (references/, scripts/, assets/)

Usage notes:
- Only use skills listed in <available_skills> below
- Do not invoke a skill that is already loaded in your context
- Each skill invocation is stateless
</usage>

<available_skills>

<skill>
<name>brainstorming</name>
<description>"You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation."</description>
<location>project</location>
</skill>

<skill>
<name>dispatching-parallel-agents</name>
<description>Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies</description>
<location>project</location>
</skill>

<skill>
<name>executing-plans</name>
<description>Use when you have a written implementation plan to execute in a separate session with review checkpoints</description>
<location>project</location>
</skill>

<skill>
<name>finishing-a-development-branch</name>
<description>Use when implementation is complete, all tests pass, and you need to decide how to integrate the work - guides completion of development work by presenting structured options for merge, PR, or cleanup</description>
<location>project</location>
</skill>

<skill>
<name>receiving-code-review</name>
<description>Use when receiving code review feedback, before implementing suggestions, especially if feedback seems unclear or technically questionable - requires technical rigor and verification, not performative agreement or blind implementation</description>
<location>project</location>
</skill>

<skill>
<name>requesting-code-review</name>
<description>Use when completing tasks, implementing major features, or before merging to verify work meets requirements</description>
<location>project</location>
</skill>

<skill>
<name>subagent-driven-development</name>
<description>Use when executing implementation plans with independent tasks in the current session</description>
<location>project</location>
</skill>

<skill>
<name>systematic-debugging</name>
<description>Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes</description>
<location>project</location>
</skill>

<skill>
<name>test-driven-development</name>
<description>Use when implementing any feature or bugfix, before writing implementation code</description>
<location>project</location>
</skill>

<skill>
<name>using-git-worktrees</name>
<description>Use when starting feature work that needs isolation from current workspace or before executing implementation plans - creates isolated git worktrees with smart directory selection and safety verification</description>
<location>project</location>
</skill>

<skill>
<name>using-superpowers</name>
<description>Use when starting any conversation - establishes how to find and use skills, requiring Skill tool invocation before ANY response including clarifying questions</description>
<location>project</location>
</skill>

<skill>
<name>verification-before-completion</name>
<description>Use when about to claim work is complete, fixed, or passing, before committing or creating PRs - requires running verification commands and confirming output before making any success claims; evidence before assertions always</description>
<location>project</location>
</skill>

<skill>
<name>writing-plans</name>
<description>Use when you have a spec or requirements for a multi-step task, before touching code</description>
<location>project</location>
</skill>

<skill>
<name>writing-skills</name>
<description>Use when creating new skills, editing existing skills, or verifying skills work before deployment</description>
<location>project</location>
</skill>

</available_skills>
<!-- SKILLS_TABLE_END -->

</skills_system>

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   b2 --no-stealth sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
