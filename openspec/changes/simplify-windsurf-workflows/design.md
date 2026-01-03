# Design: Workflow Reorganization Architecture

## Context

The dotfiles repository manages workflows for multiple AI coding assistants (Claude Code, Antigravity, Windsurf) with different approaches:

- Claude Code uses skills in `.agent/skills/` (openskills framework)
- Antigravity uses workflows in `.agent/workflows/` directory
- Windsurf uses workflows in `codeium/.codeium/windsurf/global_workflows/`

Currently, there's fragmentation:

- Personal workflows (dat-*) mixed with framework workflows (superpower-*)
- Sync scripts (superpowers-sync, claude-plugins-sync) that are rarely used
- Application Support symlink setup creating duplicate management paths
- Brainstorming workflow has artificial restrictions that reduce efficiency

## Goals / Non-Goals

**Goals:**

- Consolidate Antigravity workflow management through single stow package (gemini)
- Remove unnecessary automation (sync scripts) in favor of manual control
- Document the AskUserQuestion pattern for reuse across AI agents
- Enable efficient multi-question conversations in brainstorming
- Maintain clear separation between Antigravity and Windsurf workflows

**Non-Goals:**

- Not changing Windsurf workflow management (remains independent)
- Not creating new sync automation (removing complexity, not adding)
- Not modifying Claude Code skills framework
- Not changing workflow file formats or frontmatter structure

## Decisions

### Decision 1: Delete .agent/workflows/ Entirely

**Rationale:**

- Antigravity auto-discovers workflows from `~/.gemini/antigravity/global_workflow/` (verified by existing rewrite.md)
- Having workflows in both locations creates confusion about source of truth
- Gemini package is the appropriate place for personal workflows (gemini is the AI assistant platform)

**Alternative Considered:**

- Keep .agent/workflows/ as symlink to gemini location
- **Rejected:** Adds complexity; stow already handles symlinking

### Decision 2: Move ALL Workflows to Gemini (Including superpower-brainstorming)

**Rationale:**

- Consistency - all Antigravity workflows in one location
- Brainstorming is the only superpower workflow actually used by Antigravity
- Other superpower workflows are unused (verified: 12 unused files)

**Alternative Considered:**

- Keep superpower-brainstorming in .agent/workflows/, move only dat-* to gemini
- **Rejected:** Creates artificial distinction; brainstorming IS a personal workflow choice

### Decision 3: Remove Both Sync Scripts

**Rationale:**

- User feedback: "I don't need to sync that often"
- Sync scripts add maintenance burden without proportional value
- Manual workflow copying when needed is simpler and more explicit
- Workflows are already in git, easy to copy between locations if needed

**Alternative Considered:**

- Keep sync scripts but improve documentation
- **Rejected:** Automation that's rarely used becomes stale and breaks

### Decision 4: Keep Antigravity Package in Stow (But Not for Workflows)

**Rationale:**

- settings.json and keybindings.json still need to be stowed
- Removing package entirely would lose settings management
- Workflows moving to gemini doesn't mean ALL antigravity config should move

**Alternative Considered:**

- Remove antigravity package entirely, manage settings manually
- **Rejected:** Settings benefit from version control and stow management

### Decision 5: Document AskUserQuestion Pattern in Brainstorming Workflow

**Rationale:**

- Claude's AskUserQuestion tool is powerful but not available in other AI agents
- Documenting the pattern enables Antigravity/Windsurf to replicate the experience
- Using THIS proposal interview as meta-example makes it concrete and relatable
- Pattern: header (categorization), multiSelect (flexibility), options with label+description (clarity)

**Implementation:**

```markdown
## Using Structured Questions (AskUserQuestion Pattern)

When interviewing users, structure questions with:
- **Header**: Short category label (e.g., "Discovery", "Tech stack")
- **Multiple options**: 2-4 clear choices with labels + descriptions
- **MultiSelect**: When choices aren't mutually exclusive

### Example from This Proposal

Question: "Should .agent/workflows/ only contain brainstorming, or be completely empty?"
Header: "Agent cleanup"
Options:
- Label: "Only superpower-brainstorming.md remains"
  Description: "Keep the Antigravity brainstorming workflow in .agent/workflows/"
- Label: "Delete .agent/workflows/ directory entirely"
  Description: "Since everything moves to gemini, remove the directory"

This pattern enables:
- Quick scanning (headers + labels)
- Informed decisions (descriptions explain implications)
- Efficient answers (select rather than type)
```

**Alternative Considered:**

- Just remove restrictions, don't document pattern
- **Rejected:** Misses opportunity to transfer best practices to other AI agents

## Risks / Trade-offs

### Risk: Antigravity Doesn't Discover Workflows After Migration

**Mitigation:**

- Verified auto-discovery works (rewrite.md already exists in ~/.gemini/antigravity/global_workflows/)
- Test workflow discovery after stowing gemini package before deleting .agent/workflows/
- Git revert available if issues arise

### Risk: Git History Lost for Moved Files

**Mitigation:**

- Use `git mv` instead of copy+delete to preserve history
- Document the move in commit message with old and new paths

### Risk: Windsurf Accidentally Affected by Changes

**Mitigation:**

- Explicit "NO CHANGES" in proposal for Windsurf
- Validation step: verify codeium/.codeium/windsurf/global_workflows/ untouched
- Separate commit for Windsurf changes (none) vs Antigravity changes

### Trade-off: Manual vs Automated Workflow Syncing

**Chosen:** Manual

- **Advantage:** Simpler, explicit, no maintenance burden
- **Disadvantage:** Must remember to manually sync when updating workflows
- **Acceptable:** Workflows updated infrequently, manual is sufficient

## Migration Plan

### Phase 1: Prepare Gemini Package

1. Create `gemini/.gemini/antigravity/global_workflow/` directory
2. Move all 21 workflows using `git mv` to preserve history
3. Modify superpower-brainstorming.md with AskUserQuestion pattern

### Phase 2: Remove Sync Automation

1. Delete `bin/.local/dotfiles-bin/superpowers-sync`
2. Delete `bin/.local/dotfiles-bin/claude-plugins-sync`
3. Remove documentation references to sync scripts

### Phase 3: Update Setup Configuration

1. Remove `link_app_support "Antigravity" "Antigravity"` from setup.sh
2. Remove cleanup lines for Antigravity settings/keybindings
3. Verify `gemini` in PACKAGES list (already present)

### Phase 4: Cleanup and Validate

1. Delete `.agent/workflows/` directory
2. Delete `~/.gemini/antigravity/global_workflows/rewrite.md`
3. Stow gemini package: `stow -R gemini`
4. Lint workflows: `markdownlint gemini/.gemini/antigravity/global_workflow/*.md`
5. Validate YAML frontmatter in workflow files
6. Test: Open Antigravity and verify workflows appear
7. Verify Windsurf workflows untouched

### Rollback

- Git revert the commit if any issues with workflow discovery
- Simple, clean rollback path

## Open Questions

None - all questions resolved through interview process.
