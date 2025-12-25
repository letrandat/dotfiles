# Claude Code Neovim Layout and Real-Time Diff Design

**Date:** 2025-12-24
**Status:** Approved

## Overview

Configure claudecode.nvim to provide a Windsurf-like experience with a 50% right split terminal and automatic diff viewing for every file change.

## Requirements

1. Claude Code terminal takes 50% of Neovim window width
2. Terminal positioned on right side as a persistent split
3. Automatic diff opening for every edit Claude proposes
4. Diffs remain visible after acceptance for review

## Current State

- Terminal configuration commented out (using plugin defaults)
- Diff auto-opening already enabled via `diff_opts`
- `auto_close_on_accept = true` closes diffs immediately after save

## Design Decisions

### Terminal Layout: Right Split at 50%

**Chosen Approach:** Persistent right split using `split_side` and `split_width_percentage`

**Rationale:**
- Predictable, stable positioning
- Integrates with Neovim's native window management
- Side-by-side with code/diff pane on left
- More reliable than floating windows which can cover content

**Rejected Alternatives:**
- Left split: Less conventional for terminal placement
- Floating window: Can obstruct code, less stable

### Diff Behavior: Auto-Open with Persistent View

**Chosen Approach:** Change `auto_close_on_accept` to `false`

**Rationale:**
- With 50% layout, there's room for persistent diff view
- Allows reviewing what was just changed
- More similar to Windsurf's continuous visual feedback
- User maintains control with manual close (`:q`)

**Existing Config (preserved):**
- `vertical_split = true`: Side-by-side comparison
- `open_in_current_tab = true`: Immediate display
- `keep_terminal_focus = false`: Focus on diff for review

## Implementation

### Configuration Changes

File: `nvim/.config/nvim/lua/plugins/extend-claudecode.lua`

```lua
local toggle_key = "<M-e>" -- Alt + e
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
    },
    opts = {
      -- Terminal as right split at 50% width
      terminal = {
        split_side = "right",
        split_width_percentage = 0.5,
      },

      -- Auto-opening diff behavior
      diff_opts = {
        auto_close_on_accept = false,  -- Changed from true
        vertical_split = true,
        open_in_current_tab = true,
        keep_terminal_focus = false,
      },
    },
  },
}
```

### Expected Workflow

1. User presses `Alt+e` → Claude terminal opens on right (50% width)
2. User asks Claude to edit a file → Diff automatically opens in left pane
3. User reviews changes → Accept (`:w` or `<leader>aa`) or reject (`:q` or `<leader>ad`)
4. Diff remains open after acceptance → User closes manually when ready
5. Process repeats for subsequent edits

### Layout Diagram

```
┌─────────────────┬─────────────────┐
│  Your Code/Diff │  Claude Code    │
│      (50%)      │   Terminal      │
│                 │      (50%)      │
└─────────────────┴─────────────────┘
```

## Testing Approach

1. Restart Neovim after configuration change
2. Open Claude Code terminal with `Alt+e`
3. Verify terminal appears on right at 50% width
4. Request Claude to edit a file
5. Verify diff opens automatically in left pane
6. Accept change and verify diff stays open
7. Manually close diff with `:q`

## Future Considerations

- If 50% feels too wide/narrow, adjust `split_width_percentage` (e.g., 0.4 for 40%)
- If persistent diffs become cluttered, revert `auto_close_on_accept` to `true`
- Consider adding custom keybindings for faster diff navigation if needed
