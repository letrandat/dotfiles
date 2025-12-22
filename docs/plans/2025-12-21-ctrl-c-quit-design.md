# Ctrl+C + Ctrl+C Quit Design

**Date:** 2025-12-21
**Scope:** Main nvim config only (`nvim/.config/nvim`)
**Status:** Approved

## Overview

Add a double Ctrl+C keybinding to quit nvim with smart behavior - exit if no unsaved changes, otherwise warn (like `:qa`).

## Requirements

- Press Ctrl+C twice within 1 second to quit entire nvim instance
- Smart quit behavior: exit if clean, warn if unsaved changes
- Visual feedback on first press
- Works in all modes (normal, insert, visual)

## Technical Architecture

### Core Mechanism

The implementation uses a Lua-based state machine with a timer to track Ctrl+C presses:

1. **State Variable**: A module-level variable tracks whether we're in the "waiting for second press" state
2. **Timer Object**: When first Ctrl+C is pressed, we start a 1-second timer using `vim.defer_fn()`
3. **Keymap Handler**: The Ctrl+C mapping calls a function that:
   - Checks if we're already waiting for the second press
   - If yes → executes `:qa` (smart quit entire instance)
   - If no → sets the waiting state, shows notification, starts timer
4. **Timer Callback**: After 1 second, resets the state back to initial

### Integration Point

- **File**: `/Users/dat/workspace/dotfiles/nvim/.config/nvim/lua/config/keymaps.lua`
- **Location**: After existing keymaps (after line 114)
- **Notification**: Uses LazyVim's existing `vim.notify()` system

### Keymap Registration

Map `<C-c>` in normal, insert, and visual modes to ensure consistent behavior across all modes.

## User Interaction Flow

### Normal Usage

1. **First Ctrl+C Press:**
   - User presses `Ctrl+C` anywhere in nvim (any mode)
   - Notification appears: "Press Ctrl+C again to quit" (info level)
   - 1-second countdown begins silently in background
   - Editor remains fully functional

2. **Second Ctrl+C Press (within 1 second):**
   - User presses `Ctrl+C` again
   - Nvim executes `:qa` command
   - If no unsaved changes: nvim exits immediately
   - If unsaved changes exist: Standard vim warning appears
   - User can then save (`:wqa`) or force quit (`:qa!`)

3. **Timeout Scenario:**
   - User presses `Ctrl+C` once
   - Waits more than 1 second
   - Timer expires, state resets silently
   - Next `Ctrl+C` press starts sequence over

### Visual Feedback

- Uses LazyVim's notification system (same style as file path copy notifications)
- Non-intrusive, appears briefly in corner
- No persistent UI changes

## Implementation Details

### Code Structure

```lua
-- Ctrl+C + Ctrl+C to quit
local ctrl_c_state = {
  waiting_for_second_press = false,
  timer = nil
}

local function handle_ctrl_c()
  if ctrl_c_state.waiting_for_second_press then
    -- Second press: quit
    vim.cmd('qa')
  else
    -- First press: notify and start timer
    ctrl_c_state.waiting_for_second_press = true
    vim.notify("Press Ctrl+C again to quit", vim.log.levels.INFO)

    -- Reset after 1 second
    ctrl_c_state.timer = vim.defer_fn(function()
      ctrl_c_state.waiting_for_second_press = false
    end, 1000)
  end
end

-- Map in all modes
map("n", "<C-c>", handle_ctrl_c, { desc = "Quit nvim (press twice)" })
map("i", "<C-c>", handle_ctrl_c, { desc = "Quit nvim (press twice)" })
map("v", "<C-c>", handle_ctrl_c, { desc = "Quit nvim (press twice)" })
```

## Edge Cases & Error Handling

### Handled Cases

1. **Rapid Multiple Presses:**
   - Second press triggers `:qa`, subsequent presses ignored
   - State already transitioning to quit, no conflicts

2. **Timer Cleanup:**
   - Timer callback executes harmlessly if quit already initiated
   - No memory leaks or lingering timers

3. **Unsaved Changes:**
   - `:qa` respects Vim's built-in protection
   - Standard warning shown, doesn't override safety

4. **Different Modes:**
   - Consistent behavior in normal, insert, visual modes
   - Doesn't interrupt current mode on first press

## Testing Approach

### Manual Testing Checklist

1. **Basic Happy Path:**
   - Press Ctrl+C → notification appears
   - Press Ctrl+C again → nvim quits

2. **Timeout Behavior:**
   - Press Ctrl+C → notification appears
   - Wait 2 seconds
   - Press Ctrl+C → notification appears again (not quit)

3. **Unsaved Changes:**
   - Make changes without saving
   - Press Ctrl+C twice
   - Verify warning appears, nvim doesn't quit

4. **Multi-Mode:**
   - Test in normal, insert, visual modes
   - All show consistent behavior

5. **Multiple Windows:**
   - Open splits
   - Press Ctrl+C twice
   - All windows close (entire instance quits)

## Design Decisions

- **1-second timeout**: Balance between convenience and safety
- **`:qa` not `:qa!`**: Respect unsaved changes for safety
- **All modes**: Consistent behavior improves UX
- **LazyVim notifications**: Match existing UI patterns
- **No timer cancellation**: Simpler code, timer callback is harmless
