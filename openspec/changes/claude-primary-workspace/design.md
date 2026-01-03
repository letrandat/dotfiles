# Design: Claude-Primary 2-Pane Workspace

## Architecture Overview

This design implements a tmux-based 2-pane workspace optimized for AI-first development workflows. The architecture inverts traditional editor-first patterns by treating Claude Code as the primary tool and Neovim as a quick-access verification utility.

## Design Principles

### 1. Spatial Consistency

**Principle**: Panes occupy fixed positions with semantic meaning

- Left pane (pane 1): Primary workspace (AI/Claude Code)
- Right pane (pane 2): Secondary editor (Neovim)
- Layout mirrors reading direction (left-to-right, primary-to-secondary)

**Rationale**: Muscle memory depends on spatial consistency. Fixed positions reduce cognitive load during rapid context switching.

### 2. Lazy Resource Allocation

**Principle**: Create resources only when accessed

- Start: Single pane (Claude Code, zoomed)
- On first Cmd+L: Create right pane (empty terminal, zoomed)
- User manually launches Neovim when needed

**Rationale**: Most sessions may never need Neovim. Defer creation until proven necessary. Saves memory and keeps UI simple.

### 3. Visual Affordance

**Principle**: UI should reveal workspace structure

- Pane borders display: "1(ai)" and "2(nvim)"
- Visible when unzoomed (both panes shown)
- Hidden when zoomed (single pane fills screen)

**Rationale**: When both panes are visible, labels help identify each. When zoomed, context is obvious.

### 4. True Toggle Semantics

**Principle**: Single keybind bidirectionally switches context

- From pane 1 (Claude) + Cmd+L → pane 2 (Neovim) zoomed
- From pane 2 (Neovim) + Cmd+L → pane 1 (Claude) zoomed
- Always results in target pane zoomed (full screen)

**Rationale**: Symmetric behavior. Same key returns you to where you came from. Similar to Alt+Tab.

### 5. Strict 2-Pane Boundary

**Principle**: This workflow supports exactly 2 panes, no more

- Additional needs (logs, tests, terminals) use tmux windows
- Cmd+L in 3+ pane scenarios toggles between panes 1 and 2 (ignores others)
- Never auto-creates a 3rd pane

**Rationale**: Clear mental model. Panes = workspace duo. Windows = additional contexts.

## Component Design

### Component 1: Ghostty Keybind

**Purpose**: Translate Cmd+L to tmux command sequence

**Location**: `ghostty/.config/ghostty/config`

**Implementation**:

```
keybind = super+l=text:\x02<tmux-command-sequence>
```

Where:

- `super+l` = Cmd+L
- `\x02` = Ctrl+B (default tmux prefix)
- Command sequence executes tmux toggle logic

**Edge Cases**:

- If tmux not running: Ghostty sends literal text (harmless)
- If in Neovim pane: Neovim doesn't process Cmd+L (tmux intercepts)

**Alternatives Considered**:

- Alt+L: Already used by other tools
- Cmd+K: Reserved for other workflows
- Cmd+Shift+L: Too many modifiers

### Component 2: Tmux Pane Toggle Logic

**Purpose**: Smart pane switching with zoom and creation

**Location**: `tmux/.tmux.conf`

**State Machine**:

```
Current State              | Cmd+L Action
---------------------------|------------------------------------------
Pane 1 (Claude), zoomed    | → Create pane 2 if missing → Select pane 2 → Zoom pane 2
Pane 2 (Neovim), zoomed    | → Select pane 1 → Zoom pane 1
Pane 1, unzoomed           | → Select pane 2 (create if missing) → Zoom pane 2
Pane 2, unzoomed           | → Select pane 1 → Zoom pane 1
Only 1 pane exists         | → Create pane 2 → Zoom pane 2
No panes (edge case)       | → No-op or error
```

**Implementation Strategy**:

Use tmux `if-shell` conditionals to:

1. Detect current pane index (`#{pane_index}`)
2. Count total panes (`#{window_panes}`)
3. Branch logic:
   - If in pane 1: go to pane 2 (create if needed)
   - If in pane 2: go to pane 1
   - Always zoom target pane

**Tmux Command Pseudo-code**:

```bash
bind <key> run-shell '
  if [ "#{pane_index}" = "1" ]; then
    # Currently in Claude pane, go to Neovim
    if ! tmux select-pane -t :.2 2>/dev/null; then
      # Pane 2 doesn't exist, create it
      tmux split-window -h -c "#{pane_current_path}"
    fi
    tmux resize-pane -Z
  else
    # Currently in Neovim (or other), go to Claude
    tmux select-pane -t :.1
    tmux resize-pane -Z
  fi
'
```

**Challenges**:

- Ghostty keybind must encode entire sequence as text, not execute shell script
- Solution: Use tmux's built-in `if-shell` in bind command
- Tmux command chaining: `\;` separator

### Component 3: Pane Border Formatting

**Purpose**: Display pane labels "1(ai)" and "2(nvim)"

**Location**: `tmux/.tmux.conf`

**Implementation**:

```bash
# Pane border format
set -g pane-border-format "#{pane_index}(#{?#{==:#{pane_index},1},ai,nvim})"
set -g pane-border-status top  # or 'bottom'
```

**Dynamic Labeling Logic**:

- If `pane_index == 1`: show "(ai)"
- Else (pane 2): show "(nvim)"

**Tmux Format Syntax**:

- `#{pane_index}`: Current pane number
- `#{?condition,true,false}`: Ternary operator
- `#{==:a,b}`: Equality check

**Trade-off**:

- **Simple approach**: Fixed labels based on pane index
- **Smart approach**: Detect running process (pane_current_command) and label dynamically

**Decision**: Use simple pane-index-based labels. Process detection is fragile (what if user runs something else in pane 1?). Index-based is predictable.

### Component 4: Error Recovery

**Purpose**: Handle manually killed panes gracefully

**Scenario 1**: Claude pane (pane 1) killed, only Neovim remains

**Behavior**:

- Cmd+L detects pane 1 missing
- Auto-creates left pane (split vertical, target left)
- Leaves empty terminal (user launches Claude manually)

**Implementation**:

- Check if pane 1 exists: `tmux select-pane -t :.1 2>/dev/null`
- If fails: `tmux split-window -hb` (split horizontal, before current pane)

**Scenario 2**: Neovim pane (pane 2) killed, only Claude remains

**Behavior**:

- Cmd+L from Claude creates pane 2 as usual (already handled by base logic)

**Scenario 3**: Both panes killed (no panes in window)

**Behavior**:

- Cmd+L does nothing (edge case, user should create pane manually)
- Or: tmux command errors harmlessly

### Component 5: Cross-Window Behavior

**Purpose**: Handle Cmd+L in windows with different pane counts

**Scenario 1**: Window has 0 panes (empty window, edge case)

**Behavior**: No-op or tmux error (user should manually create pane)

**Scenario 2**: Window has 1 pane (any pane)

**Behavior**:

- Cmd+L creates pane 2 (right split)
- Assumes current pane will become pane 1

**Scenario 3**: Window has 2 panes (expected case)

**Behavior**: Standard toggle between pane 1 and pane 2

**Scenario 4**: Window has 3+ panes (user manually created extras)

**Behavior**:

- Cmd+L still toggles between pane 1 and pane 2
- Ignores panes 3, 4, etc.
- Does NOT create additional panes

**Implementation**:

- Don't check pane count; always target pane 1 or pane 2 by index
- Let tmux's `select-pane -t :.N` handle invalid indices (error if missing)

## Data Flow

### User Action: Cmd+L in Claude Pane

```
User                    Ghostty                  Tmux                     Panes
  |                        |                       |                        |
  |--- Cmd+L pressed ----->|                       |                        |
  |                        |                       |                        |
  |                        |-- Sends '\x02...' -->|                        |
  |                        |   (tmux prefix +      |                        |
  |                        |    toggle command)    |                        |
  |                        |                       |                        |
  |                        |                       |-- Check pane_index -->|
  |                        |                       |   (currently 1)        |
  |                        |                       |                        |
  |                        |                       |-- select-pane :.2 --->|
  |                        |                       |   (if exists)          |
  |                        |                       |        OR              |
  |                        |                       |-- split-window -h --->|
  |                        |                       |   (if not exists)      |
  |                        |                       |                        |
  |                        |                       |-- resize-pane -Z ---->|
  |                        |                       |   (zoom pane 2)        |
  |                        |                       |                        |
  |<----------------------- Display pane 2 (zoomed) ----------------------->|
```

### User Action: Cmd+L in Neovim Pane

```
User                    Ghostty                  Tmux                     Panes
  |                        |                       |                        |
  |--- Cmd+L pressed ----->|                       |                        |
  |                        |                       |                        |
  |                        |-- Sends '\x02...' -->|                        |
  |                        |                       |                        |
  |                        |                       |-- Check pane_index -->|
  |                        |                       |   (currently 2)        |
  |                        |                       |                        |
  |                        |                       |-- select-pane :.1 --->|
  |                        |                       |                        |
  |                        |                       |-- resize-pane -Z ---->|
  |                        |                       |   (zoom pane 1)        |
  |                        |                       |                        |
  |<----------------------- Display pane 1 (zoomed) ----------------------->|
```

## Integration Points

### Existing Cmd+e Keybind (Neovim-Integrated Claude)

**Current Behavior**:

- Ghostty sends Alt+e (`\x1be`) to terminal
- Neovim's autocmd detects Alt+e and toggles Claude terminal

**Interaction with New Cmd+L**:

- Orthogonal: Cmd+e works inside Neovim pane
- Cmd+L switches between panes (tmux-level)
- No conflict; both can coexist

**User Workflow Choice**:

1. Use Cmd+e for integrated Claude (quick queries while coding)
2. Use Cmd+L for paned Claude (longer AI sessions with verification)
3. User experiments and converges to preferred mode over time

### Existing Tmux Keybinds

**Preserved Keybinds**:

- `prefix w v`: Manual vertical split (still works)
- `prefix w s`: Manual horizontal split (still works)
- `prefix ,`: Choose-tree (unchanged)
- `prefix h/l`: Window navigation (unchanged)

**No Conflicts**: Cmd+L is net-new; doesn't override existing tmux binds

### Tmux Sessionizer

**Integration**: None needed

- Sessionizer manages sessions/windows
- This change manages panes within a window
- Orthogonal concerns

## Configuration

### Tmux Config Structure

```bash
# ============================================================================
# 2-Pane Workspace: Claude-Primary Model
# ============================================================================
# Left pane (1): Claude Code - primary AI workspace
# Right pane (2): Neovim - quick verification/edits
#
# Usage:
# - Start: Claude in pane 1, zoomed
# - Cmd+L: Toggle to pane 2 (creates if missing, zooms)
# - Cmd+L: Toggle back to pane 1 (zooms)
#
# Edge cases:
# - Pane 2 missing: auto-creates right split with same cwd
# - Pane 1 missing: auto-recreates left split (if from pane 2)
# - 3+ panes: ignores extras, toggles between 1 and 2
# ============================================================================

# Pane border labels: "1(ai)" and "2(nvim)"
set -g pane-border-format "#{pane_index}(#{?#{==:#{pane_index},1},ai,nvim})"
set -g pane-border-status top

# Pane toggle logic (triggered by Ghostty Cmd+L)
bind <key> if-shell ...
```

### Ghostty Config Addition

```bash
# ============ 2-Pane Workspace Keybind ============
# Cmd+L: Toggle between Claude (pane 1) and Neovim (pane 2) with zoom
keybind = super+l=text:\x02<command-sequence>
```

## Testing Strategy

### Manual Test Cases

1. **TC1: Fresh session, first Cmd+L**
   - Start: 1 pane (Claude)
   - Action: Cmd+L
   - Expected: Pane 2 created, zoomed, empty terminal

2. **TC2: Toggle back to Claude**
   - Start: Pane 2 zoomed
   - Action: Cmd+L
   - Expected: Pane 1 zoomed (Claude)

3. **TC3: Repeated toggling**
   - Action: Cmd+L, Cmd+L, Cmd+L
   - Expected: Alternates between panes 1 and 2, always zoomed

4. **TC4: Kill pane 2, then Cmd+L**
   - Start: Pane 1 zoomed
   - Action: Kill pane 2 manually (prefix b d)
   - Action: Cmd+L
   - Expected: Pane 2 recreated, zoomed

5. **TC5: Kill pane 1, then Cmd+L from pane 2**
   - Start: Pane 2 zoomed
   - Action: Kill pane 1 manually
   - Action: Cmd+L
   - Expected: Pane 1 recreated (left split), zoomed

6. **TC6: Window with 3 panes**
   - Start: Manually create panes 1, 2, 3
   - Action: Cmd+L from pane 1
   - Expected: Goes to pane 2, does NOT create pane 4

7. **TC7: Cmd+L in different tmux window**
   - Start: Switch to a window with 1 random pane
   - Action: Cmd+L
   - Expected: Creates pane 2, zooms to it

8. **TC8: Pane labels visible when unzoomed**
   - Start: Panes 1 and 2 both visible (unzoomed)
   - Expected: Borders show "1(ai)" and "2(nvim)"

9. **TC9: Pane working directory**
   - Start: Claude in ~/dotfiles
   - Action: Cmd+L (creates pane 2)
   - Expected: Pane 2 cwd is ~/dotfiles (same as pane 1)

10. **TC10: Cmd+e still works in Neovim pane**
    - Start: Pane 2 with Neovim open
    - Action: Cmd+e
    - Expected: Neovim's Claude terminal toggles (independent of pane workflow)

## Performance Considerations

### Memory Usage

- **Baseline**: 1 pane (Claude only): ~50MB (tmux + Claude)
- **With pane 2 empty**: +2MB (tmux pane overhead)
- **With pane 2 + Neovim**: +100MB (Neovim instance)

**Lazy spawn saves ~100MB** when Neovim not needed.

### Latency

- Cmd+L keybind → tmux response: <50ms (local)
- Pane creation: <100ms (create + zoom)
- Pane switch (existing): <10ms

**Negligible impact** on user experience.

## Security Considerations

None. This change only affects local tmux/Ghostty config. No network, no external data, no credentials.

## Compatibility

### Minimum Versions

- Tmux 3.2+ (for pane-border-format)
- Ghostty 1.0+ (for keybind support)

### Backward Compatibility

- Changes are additive (new keybind, new tmux config section)
- No breaking changes to existing keybinds or behavior
- Stow re-application will symlink new configs

### Future Compatibility

- Tmux pane-border-format may change in future versions
- Ghostty keybind syntax may evolve
- Both risks are low; syntax is stable

## Maintenance

### Config Ownership

- `tmux/.tmux.conf`: Managed by this repo, stowed to ~/.tmux.conf
- `ghostty/.config/ghostty/config`: Managed by this repo, stowed to ~/.config/ghostty/config

### Documentation Burden

- Inline comments in config files explain behavior
- No external docs to sync
- OpenSpec proposal serves as historical design rationale

### Future Enhancements

Potential (not in scope for this change):

- Named layouts: Save/restore 2-pane setup as a tmux layout
- Session templates: Auto-create this layout on new sessions
- Status bar integration: Show which pane is active
- Pane title override: Let user rename panes manually

## Decision Log

| Decision | Rationale | Alternatives Rejected |
|----------|-----------|----------------------|
| Use pane indices (1, 2) not marks | Simple, predictable | Pane marks: complex, harder to debug |
| Lazy spawn pane 2 | Save resources, most sessions won't need it | Eager spawn: wastes memory |
| Always zoom on toggle | Clear focus, matches "trust then verify" | Smart zoom: confusing state |
| Create empty terminal, not auto-nvim | Flexibility, no assumptions | Auto-launch nvim: assumes file to open |
| Keep Cmd+e separate | User wants to experiment | Remove Cmd+e: too aggressive |
| No automation scripts | Manual setup preferred by user | Shell function: added complexity |
| No separate docs | Config is self-documenting | Dedicated guide: maintenance burden |
| 50/50 split | Balanced, standard | 70/30: premature optimization |
| Pane labels always show index+(ai/nvim) | Consistent, simple | Process-based labels: fragile |
