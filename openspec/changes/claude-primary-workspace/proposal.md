# Proposal: Claude-Primary 2-Pane Workspace

## Change ID

`claude-primary-workspace`

## Status

Proposed

## Summary

Introduce a tmux 2-pane workspace optimized for Claude Code as the primary development tool, with Neovim as a secondary quick-reference editor. This inverts the traditional editor-first workflow to support an AI-first development model where Claude Code handles most work and Neovim provides fast verification and minor edits.

## Motivation

### Current State

The dotfiles currently support two ways to use Claude Code:

1. **Integrated mode**: Cmd+e toggles Claude Code terminal within Neovim (nvim-integrated)
2. **Standalone mode**: Claude Code runs in a regular terminal without special tmux pane management

There is no optimized workflow for using standalone Claude Code as the primary tool with occasional Neovim access.

### Problem

When using Claude Code as the primary development tool (the emerging workflow), the current setup has friction:

- No quick keybind to switch to Neovim for file verification
- Manual pane management required (prefix w v, etc.)
- No spatial consistency (panes are ad-hoc, not workflow-aware)
- Cognitive overhead deciding when to use integrated vs standalone Claude

### Proposed Solution

Implement a 2-pane tmux workspace with:

- **Left pane (pane 1)**: Claude Code - primary AI workspace (starts zoomed)
- **Right pane (pane 2)**: Neovim - quick verification/edits (lazy-spawned)
- **Cmd+L**: True toggle keybind via Ghostty to switch between panes with zoom
- **Visual labels**: Automatic pane titles "1(ai)" and "2(nvim)" in borders
- **Strict 2-pane model**: Additional tools use tmux windows, not more panes

This mirrors the old 2-pane setup (commit 960d7a4) but inverts the priority: Claude is primary, Neovim is secondary.

## Goals

1. **Fast context switching**: Single keypress (Cmd+L) to toggle between AI and editor
2. **Clear mental model**: Spatial consistency with labeled panes
3. **Lazy resource usage**: Neovim pane only created when needed
4. **Workflow preservation**: Keep existing Cmd+e integrated mode for experimentation
5. **Zero documentation debt**: Self-explanatory through inline config comments

## Non-Goals

- Automation scripts for session initialization (manual setup preferred)
- Support for 3+ pane layouts in this workflow (use tmux windows instead)
- Auto-reload of files in Neovim (manual :e preferred for safety)
- Separate documentation files (config is self-documenting)
- Removing or modifying the existing Cmd+e integrated Claude toggle

## Scope

### In Scope

- Ghostty keybind: Cmd+L sends tmux command sequence
- Tmux config: Smart pane toggle with zoom and lazy pane creation
- Pane border formatting: Automatic visual labels "1(ai)" and "2(nvim)"
- Cross-window behavior: Handle Cmd+L in windows with 0, 1, or 2+ panes
- Error recovery: Auto-recreate panes if manually killed

### Out of Scope

- Session/window initialization scripts
- Integration with tmux sessionizer
- Changes to existing Cmd+e keybind or nvim integration
- Documentation beyond inline comments
- Automated file reload in Neovim
- Pane size persistence or custom layouts

## Success Metrics

- Cmd+L reliably toggles between Claude and Neovim panes with zoom
- Pane titles correctly display "1(ai)" and "2(nvim)"
- Lazy pane creation works: pane 2 only exists after first Cmd+L
- Cross-window behavior: no 3rd pane created in windows with 2 panes
- Config changes are clear and maintainable with inline comments

## Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|-----------|
| Cmd+L conflicts with Neovim's own keybinds | Medium | Ghostty sends tmux commands, Neovim never sees Cmd+L directly |
| Lazy pane creation causes startup delay | Low | Creating empty terminal pane is instant; user manually launches nvim |
| Pane indices become unreliable if user manually rearranges | Medium | Document the 2-pane assumption in comments; use strict index-based targeting |
| Users forget which pane is which when zoomed | Low | Rely on muscle memory; pane titles visible when unzoomed |
| Breaking changes to existing workflow | Low | Additive only; existing Cmd+e and manual pane management unchanged |

## Alternatives Considered

### Alternative 1: Use tmux pane marks instead of indices

**Pros**: More robust if panes are rearranged
**Cons**: Complex implementation, harder to reason about
**Decision**: Use indices; simpler and matches user's strict 2-pane model

### Alternative 2: Auto-spawn Neovim with specific file

**Pros**: Zero manual typing after Cmd+L
**Cons**: Assumes we know which file to open; complex to detect
**Decision**: Create empty terminal; user manually types nvim command

### Alternative 3: Dedicated tmux session for this workflow

**Pros**: Clean separation from other work
**Cons**: User prefers project-named sessions, not workflow-named
**Decision**: Apply to any session; rely on user's manual setup

### Alternative 4: Replace Cmd+e integrated mode

**Pros**: Single unified workflow
**Cons**: User wants to experiment with both modes
**Decision**: Keep both; user will naturally converge to preferred mode

## Dependencies

### Technical Dependencies

- Tmux 3.2+ (for pane-border-format features)
- Ghostty terminal (for keybind support)
- Existing dotfiles stow setup

### Change Dependencies

None. This change is independent of existing OpenSpec changes.

## Rollout Plan

### Phase 1: Core Implementation

1. Add Ghostty Cmd+L keybind
2. Implement tmux pane toggle logic
3. Add pane border formatting

### Phase 2: Validation

1. Manual testing in multi-window scenarios
2. Test error recovery (killing panes)
3. Verify cross-window behavior

### Phase 3: Refinement

1. Add inline comments explaining behavior
2. Ensure no regression to existing keybinds
3. Validate with OpenSpec

## Open Questions

None. All design decisions have been clarified through user interview.

## Related Changes

- Historical reference: commit 960d7a4 (original 2-pane zoom workflow)
- Historical reference: commit 79decd5 (removal of pane arrow bindings)

## Spec Deltas

This proposal introduces one new capability:

- **tmux-pane-workflow**: 2-pane workspace with Claude-primary model and smart pane toggling
