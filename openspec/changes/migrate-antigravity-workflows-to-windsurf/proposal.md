# Proposal: Migrate Antigravity Workflows to Windsurf

The goal is to ensure parity between Antigravity and Windsurf workflows by migrating all custom workflows currently residing in `.agent/workflows` to the Windsurf global workflows directory.

## User Review Required

> [!IMPORTANT]
> Some workflows in Windsurf (like `dat-bd.md`) have slightly different policies than their Antigravity counterparts (`dat-beads.md`). We need to Decide which policy to favor (typically standardizing on the one aligned with Global Rules).

## Proposed Changes

### Workflows Migration & Transformation

The migration involves porting workflows from `.agent/workflows` to Windsurf's global workflows directory. This is not a direct copy; files must be **transformed** to match Windsurf's environment:

1.  **Frontmatter**: Inject `auto_execution_mode: 0`.
2.  **Syntax**: Convert Antigravity slash commands (`/superpower-name`) to Windsurf workflow mentions (`@workflow superpowers-name`).
3.  **Filenames**: Standardize filenames to match Antigravity (removing `DAT-W-` or `DAT-Z-` prefixes found in Windsurf).
4.  **Content**: Overwrite divergent Windsurf workflows (e.g. `dat-beads-setup`) with the Antigravity version ("Redirect Pattern") as the Source of Truth.

#### [NEW] [dat-design-to-spec.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-design-to-spec.md)

#### [NEW] [dat-design-to-tasks.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-design-to-tasks.md)

#### [NEW] [dat-refine-epic.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-refine-epic.md)

#### [NEW] [dat-spec-to-tasks.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-spec-to-tasks.md)

### Standardization & Fixes

#### [MODIFY] [dat-bd.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-bd.md)

Update content to match Antigravity's `dat-beads.md` (Source of Truth).

#### [MODIFY] [dat-beads-setup.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-beads-setup.md)

Update content to match Antigravity's `dat-beads-setup.md` (Redirect Pattern vs Contributor Pattern).

#### [RENAME] [dat-wiki.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-wiki.md)

Rename from `dat-w-wiki.md` and update content.

#### [RENAME] [dat-github.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-github.md)

Rename from `dat-z-github.md` and update content.

#### [DELETE] [dat-faster.md](file:///Users/dat/workspace/dotfiles/codeium/.codeium/windsurf/global_workflows/dat-faster.md)

Synchronize with Antigravity version.

## Verification Plan

### Manual Verification

- Verify that new files exist in `codeium/.codeium/windsurf/global_workflows/`.
- Run `stow -R codeium` to ensure they are symlinked to `~/.codeium/windsurf/global_workflows/`.
- Verify Windsurf can see and use the new workflows.
