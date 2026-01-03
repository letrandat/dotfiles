# Tasks: Claude-Primary 2-Pane Workspace

## Overview

Implementation tasks for the Claude-primary 2-pane tmux workspace. Tasks are ordered for incremental delivery with validation at each step.

## Task Breakdown

### Task 1: Add pane border formatting to tmux config

**Description**: Configure tmux to display pane labels "1(ai)" and "2(nvim)" in pane borders.

**Changes**:

- Edit `tmux/.tmux.conf`
- Add pane-border-format configuration
- Set pane-border-status to "top"

**Implementation**:

```bash
# Add to tmux/.tmux.conf
set -g pane-border-format "#{pane_index}(#{?#{==:#{pane_index},1},ai,nvim})"
set -g pane-border-status top
```

**Validation**:

- Start tmux with 2 panes
- Unzoom both panes (so borders are visible)
- Verify pane 1 shows "1(ai)" in border
- Verify pane 2 shows "2(nvim)" in border

**Dependencies**: None

**Estimated Complexity**: Low

---

### Task 2: Implement tmux pane toggle logic (basic version)

**Description**: Create tmux keybind that toggles between panes 1 and 2 with zoom, without lazy creation.

**Changes**:

- Edit `tmux/.tmux.conf`
- Add bind command with if-shell logic for pane toggle
- Test with manually created 2-pane setup

**Implementation Approach**:

```bash
# Simplified first version (assumes both panes exist)
bind <temp-key> if-shell '[ "#{pane_index}" = "1" ]' \
  'select-pane -t :.2 \; resize-pane -Z' \
  'select-pane -t :.1 \; resize-pane -Z'
```

**Validation**:

- Manually create 2 panes (prefix w v)
- Test toggle from pane 1 → pane 2 (zooms pane 2)
- Test toggle from pane 2 → pane 1 (zooms pane 1)
- Verify zoom state is always active after toggle

**Dependencies**: Task 1 (border labels help validate which pane is active)

**Estimated Complexity**: Medium

---

### Task 3: Add lazy pane creation to toggle logic

**Description**: Enhance toggle logic to create pane 2 if it doesn't exist when toggling from pane 1.

**Changes**:

- Modify tmux bind command from Task 2
- Add conditional split-window if pane 2 missing
- Use #{pane_current_path} for working directory inheritance

**Implementation Approach**:

```bash
# Enhanced version with lazy creation
bind <temp-key> if-shell '[ "#{pane_index}" = "1" ]' \
  'if-shell "tmux select-pane -t :.2 2>/dev/null" "" "split-window -h -c \"#{pane_current_path}\"" \; select-pane -t :.2 \; resize-pane -Z' \
  'select-pane -t :.1 \; resize-pane -Z'
```

**Validation**:

- Start with single pane (pane 1)
- Press toggle key
- Verify pane 2 is created (right split, 50/50)
- Verify pane 2 is zoomed
- Verify pane 2 cwd matches pane 1 cwd
- Verify pane 2 is empty terminal (not auto-launched nvim)
- Press toggle key again
- Verify it returns to pane 1 (zoomed)

**Dependencies**: Task 2 (extends basic toggle)

**Estimated Complexity**: Medium

---

### Task 4: Add inline documentation comments to tmux config

**Description**: Document the 2-pane workflow in tmux.conf with clear comments explaining behavior and edge cases.

**Changes**:

- Edit `tmux/.tmux.conf`
- Add section header comment block
- Explain pane assignments, usage, and edge cases

**Implementation**:

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
# - 3+ panes: ignores extras, toggles between 1 and 2
# - Cross-window: applies to any window (creates pane 2 if needed)
# ============================================================================
```

**Validation**:

- Read comments in tmux.conf
- Verify they clearly explain the workflow
- Confirm edge cases are documented

**Dependencies**: Task 3 (comments describe the implemented behavior)

**Estimated Complexity**: Low

---

### Task 5: Configure Ghostty Cmd+L keybind

**Description**: Add Ghostty keybind that sends tmux command sequence for pane toggle when Cmd+L is pressed.

**Changes**:

- Edit `ghostty/.config/ghostty/config`
- Add `keybind = super+l=text:\x02<sequence>`
- Map to the tmux bind key from Task 3

**Implementation**:

First, determine the tmux bind key used in Task 3 (e.g., `L` or custom key).

Then:

```bash
# Add to ghostty config
# Cmd+L: Toggle between Claude (pane 1) and Neovim (pane 2) with zoom
keybind = super+l=text:\x02L
```

(Where `\x02` is Ctrl+B, default tmux prefix, and `L` is the bind key)

**Validation**:

- Restart Ghostty (or reload config with Cmd+Shift+,)
- Start tmux with single pane
- Press Cmd+L
- Verify pane 2 is created and zoomed
- Press Cmd+L again
- Verify it toggles back to pane 1

**Dependencies**: Task 3 (tmux toggle logic must exist)

**Estimated Complexity**: Low

---

### Task 6: Update tmux bind key to match Ghostty convention

**Description**: Ensure tmux bind key aligns with Ghostty's Cmd+L mapping (use `L` as bind key for semantic clarity).

**Changes**:

- Review tmux bind command from Task 3
- Ensure bind key is `L` (capital L, matching Cmd+L visually)
- Update if using temporary key

**Implementation**:

```bash
# Final tmux bind (replaces temp key from Task 2/3)
bind L if-shell '[ "#{pane_index}" = "1" ]' \
  'if-shell "tmux select-pane -t :.2 2>/dev/null" "" "split-window -h -c \"#{pane_current_path}\"" \; select-pane -t :.2 \; resize-pane -Z' \
  'select-pane -t :.1 \; resize-pane -Z'
```

**Validation**:

- Verify Ghostty Cmd+L triggers tmux prefix L
- Test toggle behavior end-to-end (Ghostty → tmux → pane switch)

**Dependencies**: Task 5 (Ghostty and tmux must align on key)

**Estimated Complexity**: Low

---

### Task 7: Test cross-window behavior (1 pane scenario)

**Description**: Validate Cmd+L behavior in a tmux window that starts with only 1 pane (not necessarily the workspace window).

**Changes**: None (testing task)

**Test Cases**:

1. Create a new tmux window (prefix t)
2. Verify it has only 1 pane
3. Press Cmd+L
4. Expected: Pane 2 created (right split), zoomed
5. Press Cmd+L again
6. Expected: Toggle back to pane 1, zoomed

**Validation**:

- All test cases pass
- No unexpected panes created
- Working directory inherited correctly

**Dependencies**: Task 6 (full implementation must be in place)

**Estimated Complexity**: Low (testing only)

---

### Task 8: Test cross-window behavior (3+ pane scenario)

**Description**: Validate Cmd+L does not create 3rd pane in windows that already have 2+ panes.

**Changes**: None (testing task)

**Test Cases**:

1. Create a window with 3 panes (manually split twice)
2. Focus pane 1
3. Press Cmd+L
4. Expected: Toggle to pane 2, zoom (NO pane 4 created)
5. Verify pane 3 still exists (but ignored)
6. Press Cmd+L from pane 2
7. Expected: Toggle to pane 1, zoom

**Validation**:

- Pane count remains at 3 (no 4th pane created)
- Toggle works between panes 1 and 2
- Pane 3+ ignored by toggle logic

**Dependencies**: Task 6 (full implementation must be in place)

**Estimated Complexity**: Low (testing only)

---

### Task 9: Test error recovery (manually killed panes)

**Description**: Validate auto-recovery when panes are manually killed.

**Changes**: None (testing task)

**Test Cases**:

#### Case 1: Kill pane 2

1. Start with 2 panes (1 and 2)
2. Kill pane 2 (prefix b d)
3. Press Cmd+L from pane 1
4. Expected: Pane 2 recreated, zoomed

#### Case 2: Kill pane 1

1. Start with 2 panes (1 and 2)
2. Kill pane 1 (prefix b d)
3. Pane 2 becomes pane 1 (tmux renumbers)
4. Press Cmd+L
5. Expected: Pane 2 created (right split), zoomed

**Validation**:

- Both cases recover gracefully
- No manual intervention needed
- Pane labels update correctly after recovery

**Dependencies**: Task 6 (full implementation must be in place)

**Estimated Complexity**: Low (testing only)

---

### Task 10: Test Cmd+e independence (no regression)

**Description**: Validate existing Cmd+e (nvim-integrated Claude) still works and doesn't conflict with Cmd+L.

**Changes**: None (testing task)

**Test Cases**:

1. Open Neovim in pane 2
2. Press Cmd+e
3. Expected: Neovim's Claude terminal toggles (independent behavior)
4. Verify Cmd+L still toggles panes (orthogonal to Cmd+e)
5. Test both keybinds in sequence: Cmd+L, Cmd+e, Cmd+L
6. Expected: No conflicts, both work as designed

**Validation**:

- Cmd+e toggles Neovim's integrated Claude terminal
- Cmd+L toggles between tmux panes
- No interference between the two keybinds

**Dependencies**: Task 6 (full implementation must be in place)

**Estimated Complexity**: Low (testing only)

---

### Task 11: Add inline comments to Ghostty config

**Description**: Document Cmd+L keybind in Ghostty config with clear explanation.

**Changes**:

- Edit `ghostty/.config/ghostty/config`
- Add comment explaining Cmd+L → tmux pane toggle

**Implementation**:

```bash
# Cmd+L: Toggle between Claude (pane 1) and Neovim (pane 2) with zoom
# Sends tmux prefix + L to trigger 2-pane workspace toggle
keybind = super+l=text:\x02L
```

**Validation**:

- Read comments in ghostty config
- Verify they clearly explain Cmd+L behavior

**Dependencies**: Task 5 (comments describe the implemented keybind)

**Estimated Complexity**: Low

---

### Task 12: Validate with OpenSpec

**Description**: Run OpenSpec validation to ensure the change conforms to spec requirements.

**Changes**: None (validation task)

**Commands**:

```bash
openspec validate claude-primary-workspace --strict
```

**Expected Output**:

- No validation errors
- All requirements have scenarios
- Tasks align with spec

**Validation**:

- OpenSpec validation passes
- No errors or warnings

**Dependencies**: All implementation tasks (1-11) must be complete

**Estimated Complexity**: Low (validation only)

---

### Task 13: Manual end-to-end testing

**Description**: Comprehensive manual testing of the entire workflow in real-world usage.

**Changes**: None (testing task)

**Test Scenarios**:

1. **Typical workflow**: Start Claude → Cmd+L to Neovim → open file → verify changes → Cmd+L back to Claude
2. **Lazy spawn**: Fresh session → only Claude → Cmd+L creates Neovim pane → verify cwd matches
3. **Repeated toggling**: Cmd+L 10+ times in rapid succession → no glitches
4. **Pane labels**: Unzoom panes → verify "1(ai)" and "2(nvim)" visible → zoom → verify labels hidden
5. **Multi-window**: Multiple tmux windows → Cmd+L works in each independently
6. **Error recovery**: Kill panes randomly → Cmd+L recovers → test multiple times
7. **Integration**: Use Cmd+e in Neovim pane while in 2-pane setup → no conflicts

**Validation**:

- All scenarios work smoothly
- No unexpected behavior
- Workflow feels natural

**Dependencies**: Task 12 (OpenSpec validation must pass first)

**Estimated Complexity**: Medium (comprehensive testing)

---

### Task 14: Re-stow tmux and ghostty packages

**Description**: Apply the configuration changes by re-stowing the tmux and ghostty packages.

**Changes**: None (deployment task)

**Commands**:

```bash
cd ~/workspace/dotfiles
stow -R tmux
stow -R ghostty
```

**Validation**:

- Symlinks updated: `~/.tmux.conf` → `dotfiles/tmux/.tmux.conf`
- Symlinks updated: `~/.config/ghostty/config` → `dotfiles/ghostty/.config/ghostty/config`
- Restart tmux or reload config (prefix R)
- Restart Ghostty or reload config (Cmd+Shift+,)
- Verify new keybinds and behaviors are active

**Dependencies**: Task 13 (all testing complete)

**Estimated Complexity**: Low

---

## Summary

- **Total Tasks**: 14
- **Implementation Tasks**: 6 (Tasks 1-6)
- **Documentation Tasks**: 2 (Tasks 4, 11)
- **Testing Tasks**: 5 (Tasks 7-10, 13)
- **Validation Tasks**: 1 (Task 12)
- **Deployment Tasks**: 1 (Task 14)

## Parallelization Opportunities

- Task 1 and Task 4 can be done together (both edit tmux.conf)
- Task 5 and Task 11 can be done together (both edit ghostty config)
- Tasks 7-10 (testing) can be run in any order after Task 6

## Critical Path

1. Task 1 → Task 2 → Task 3 (core tmux logic)
2. Task 4 (documentation)
3. Task 5 → Task 6 (Ghostty integration)
4. Tasks 7-11 (testing and documentation)
5. Task 12 (validation)
6. Task 13 (end-to-end testing)
7. Task 14 (deployment)
