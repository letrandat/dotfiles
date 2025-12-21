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

## Issue Tracking

This project uses **bd (beads)** for issue tracking. Use the **bd skill** (`openskills read bd`) for full documentation on commands and workflows.

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
<name>bd</name>
<description>Use when tracking issues, creating tasks, or managing work items for a project - replaces markdown TODOs and external issue trackers with dependency-aware, git-friendly issue tracking using the bd (beads) CLI tool.</description>
<location>project</location>
</skill>

<skill>
<name>brainstorming</name>
<description>Use when creating or developing, before writing code or implementation plans - refines rough ideas into fully-formed designs through collaborative questioning, alternative exploration, and incremental validation. Don't use during clear 'mechanical' processes</description>
<location>project</location>
</skill>

<skill>
<name>condition-based-waiting</name>
<description>Use when tests have race conditions, timing dependencies, or inconsistent pass/fail behavior - replaces arbitrary timeouts with condition polling to wait for actual state changes, eliminating flaky tests from timing guesses</description>
<location>project</location>
</skill>

<skill>
<name>defense-in-depth</name>
<description>Use when invalid data causes failures deep in execution, requiring validation at multiple system layers - validates at every layer data passes through to make bugs structurally impossible</description>
<location>project</location>
</skill>

<skill>
<name>dispatching-parallel-agents</name>
<description>Use when facing 3+ independent failures that can be investigated without shared state or dependencies - dispatches multiple Claude agents to investigate and fix independent problems concurrently</description>
<location>project</location>
</skill>

<skill>
<name>executing-plans</name>
<description>Use when partner provides a complete implementation plan to execute in controlled batches with review checkpoints - loads plan, reviews critically, executes tasks in batches, reports for review between batches</description>
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
<description>Use when completing tasks, implementing major features, or before merging to verify work meets requirements - dispatches superpowers:code-reviewer subagent to review implementation against plan or requirements before proceeding</description>
<location>project</location>
</skill>

<skill>
<name>root-cause-tracing</name>
<description>Use when errors occur deep in execution and you need to trace back to find the original trigger - systematically traces bugs backward through call stack, adding instrumentation when needed, to identify source of invalid data or incorrect behavior</description>
<location>project</location>
</skill>

<skill>
<name>sharing-skills</name>
<description>Use when you've developed a broadly useful skill and want to contribute it upstream via pull request - guides process of branching, committing, pushing, and creating PR to contribute skills back to upstream repository</description>
<location>project</location>
</skill>

<skill>
<name>subagent-driven-development</name>
<description>Use when executing implementation plans with independent tasks in the current session - dispatches fresh subagent for each task with code review between tasks, enabling fast iteration with quality gates</description>
<location>project</location>
</skill>

<skill>
<name>systematic-debugging</name>
<description>Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes - four-phase framework (root cause investigation, pattern analysis, hypothesis testing, implementation) that ensures understanding before attempting solutions</description>
<location>project</location>
</skill>

<skill>
<name>test-driven-development</name>
<description>Use when implementing any feature or bugfix, before writing implementation code - write the test first, watch it fail, write minimal code to pass; ensures tests actually verify behavior by requiring failure first</description>
<location>project</location>
</skill>

<skill>
<name>testing-anti-patterns</name>
<description>Use when writing or changing tests, adding mocks, or tempted to add test-only methods to production code - prevents testing mock behavior, production pollution with test-only methods, and mocking without understanding dependencies</description>
<location>project</location>
</skill>

<skill>
<name>testing-skills-with-subagents</name>
<description>Use when creating or editing skills, before deployment, to verify they work under pressure and resist rationalization - applies RED-GREEN-REFACTOR cycle to process documentation by running baseline without skill, writing to address failures, iterating to close loopholes</description>
<location>project</location>
</skill>

<skill>
<name>using-git-worktrees</name>
<description>Use when starting feature work that needs isolation from current workspace or before executing implementation plans - creates isolated git worktrees with smart directory selection and safety verification</description>
<location>project</location>
</skill>

<skill>
<name>using-superpowers</name>
<description>Use when starting any conversation - establishes mandatory workflows for finding and using skills, including using Skill tool before announcing usage, following brainstorming before coding, and creating TodoWrite todos for checklists</description>
<location>project</location>
</skill>

<skill>
<name>verification-before-completion</name>
<description>Use when about to claim work is complete, fixed, or passing, before committing or creating PRs - requires running verification commands and confirming output before making any success claims; evidence before assertions always</description>
<location>project</location>
</skill>

<skill>
<name>writing-plans</name>
<description>Use when design is complete and you need detailed implementation tasks for engineers with zero codebase context - creates comprehensive implementation plans with exact file paths, complete code examples, and verification steps assuming engineer has minimal domain knowledge</description>
<location>project</location>
</skill>

<skill>
<name>writing-skills</name>
<description>Use when creating new skills, editing existing skills, or verifying skills work before deployment - applies TDD to process documentation by testing with subagents before writing, iterating until bulletproof against rationalization</description>
<location>project</location>
</skill>

<skill>
<name>frontend-design</name>
<description>Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, artifacts, posters, or applications (examples include websites, landing pages, dashboards, React components, HTML/CSS layouts, or when styling/beautifying any web UI). Generates creative, polished code and UI design that avoids generic AI aesthetics.</description>
<location>project</location>
</skill>

<skill>
<name>skill-creator</name>
<description>Guide for creating effective skills. This skill should be used when users want to create a new skill (or update an existing skill) that extends Claude's capabilities with specialized knowledge, workflows, or tool integrations.</description>
<location>project</location>
</skill>

<skill>
<name>template</name>
<description>Replace with description of the skill and when Claude should use it.</description>
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
   bd sync
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
