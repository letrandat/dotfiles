# Change: Reorganize Antigravity Workflows and Remove Sync Scripts

## Why

Through detailed analysis, this change addresses multiple workflow management inefficiencies:

1. **Workflow Location Fragmentation**: Antigravity workflows are currently in `.agent/workflows/`, mixing personal workflows with superpower workflows, making management unclear
2. **Unnecessary Sync Automation**: Both `superpowers-sync` and `claude-plugins-sync` scripts exist but are rarely used - manual workflow management is sufficient
3. **Brainstorming Workflow Limitation**: The "one question at a time" restriction slows down productive conversations when answering multiple related questions would be more efficient
4. **AskUserQuestion Pattern Not Documented**: The powerful AskUserQuestion pattern (multiSelect, headers, option labels/descriptions) should be documented as a reusable pattern for other AI agents
5. **Package Management Confusion**: Antigravity uses both `.agent/workflows/` directory and Application Support symlink setup, creating duplicate management paths

## What Changes

### Workflow Reorganization

- **Delete `.agent/workflows/` directory entirely** after moving all contents
- Move ALL workflows (21 files total) to `gemini/.gemini/antigravity/global_workflow/`:
  - 15 dat-*.md personal workflows
  - 3 openspec-*.md workflows (proposal, apply, archive)
  - git-worktree.md
  - sample_workflow.md
  - superpower-brainstorming.md
- Remove all unused superpower-*.md files (12 files)
- **Windsurf workflows remain completely untouched** - no changes to `codeium/.codeium/windsurf/global_workflows/`

### Sync Script Removal

- Delete `bin/.local/dotfiles-bin/superpowers-sync`
- Delete `bin/.local/dotfiles-bin/claude-plugins-sync`
- Remove any references to these scripts from documentation
- Future workflow syncing will be manual when needed

### Brainstorming Workflow Enhancement

Modify `superpower-brainstorming.md` after moving to gemini:

- Remove "one question at a time" restriction (lines 19, 21)
- Remove "One question at a time" from Key Principles section
- **Add AskUserQuestion Pattern Documentation**:
  - Include concrete example using THIS proposal interview as meta-example
  - Document the pattern structure (header, multiSelect, options with label/description)
  - Explain WHY this pattern works (categorization, clear options, efficiency)
- Goal: Enable other AI agents (Windsurf, Antigravity) to replicate Claude's AskUserQuestion experience
- Keep auto_execution_mode: 0 (manual invocation)

### Package Management Cleanup

- Keep `antigravity` in stow PACKAGES list (for settings.json and keybindings.json)
- Remove Application Support symlink setup for Antigravity from setup.sh:
  - Remove `link_app_support "Antigravity" "Antigravity"` line
  - Remove cleanup lines for Antigravity settings/keybindings
- Gemini package manages all workflows via stow to `~/.gemini/antigravity/global_workflow/`

### Additional Cleanup

- Delete `~/.gemini/antigravity/global_workflows/rewrite.md` (unused workflow)

## Impact

**Affected specs:** workflows

**Affected code:**

- `.agent/workflows/` - delete entirely after moving all 21 workflows
- `gemini/.gemini/antigravity/global_workflow/` - receive all Antigravity workflows
- `~/.gemini/antigravity/global_workflows/` - remove rewrite.md
- `bin/.local/dotfiles-bin/` - remove 2 sync scripts
- `setup.sh` - remove Antigravity Application Support rewrite
- Brainstorming workflow - enhance with AskUserQuestion pattern

**Affected sync:** None - sync scripts being removed

**Windsurf:** NO CHANGES - remains completely independent

**Rollback plan:** Git revert if issues arise

**Migration risk:** Low - Antigravity auto-discovers workflows from `~/.gemini/antigravity/global_workflow/` (verified by existing rewrite.md file there)

**Validation:**

- Lint markdown structure with markdownlint
- Validate YAML frontmatter in workflow files
- Verify Antigravity discovers workflows after stowing gemini package
- Ensure Windsurf independence maintained
