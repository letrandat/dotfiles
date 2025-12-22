# Quick File Reference Shortcut Design

**Date:** 2025-12-22
**Status:** Implemented

## Problem

The existing `<leader>fp` keybinding in visual mode copies file path with line range, but requires multiple keystrokes. For frequent AI chat interactions, a quicker shortcut is needed.

## Solution

Added `gy` as a quick visual mode shortcut that copies file references in the format `@path#LX-Y`.

## Implementation

### Keybinding

- **Trigger:** `gy` in visual mode
- **Action:** Copy relative file path with line range to clipboard
- **Format:** `@nvim/.config/nvim/lua/config/keymaps.lua#L59-70`

### Location

`nvim/.config/nvim/lua/config/keymaps.lua:59-70`

### Behavior

1. User selects text in visual mode
2. User presses `gy`
3. File reference copied to system clipboard
4. Notification shows what was copied
5. User manually switches to chat pane (Cmd+L)
6. User pastes reference (Cmd+V)

## Design Decisions

### Why `gy`?

- **Quick to type:** Only 2 characters, no modifier keys needed
- **Mnemonic:** "get yank" or "git yank" (since format uses `@` like git references)
- **No conflicts:** Checked visual mode - `gy` was unmapped
- **Consistent:** Follows Vim's `g` prefix convention for extended commands

### Why not automatic pane switching?

- **Simplicity:** Keeps the mapping focused on one task
- **Flexibility:** User controls when to switch context
- **Reliability:** No dependency on tmux command execution
- **Separation of concerns:** Copy and navigation are independent actions

### Relationship to Existing Keybindings

| Keybinding | Mode | Action | Use Case |
|------------|------|--------|----------|
| `<leader>fp` | Normal | Copy relative path | File reference without line numbers |
| `<leader>fp` | Visual | Copy path + line range | Code section reference (verbose) |
| `<leader>fP` | Normal/Visual | Copy absolute path | Full system path |
| **`gy`** | **Visual** | **Copy path + line range** | **Quick code reference for AI chat** |

## Testing

```bash
# In Neovim
:source ~/.config/nvim/lua/config/keymaps.lua

# Or restart Neovim
```

**Test steps:**
1. Open a file in Neovim
2. Enter visual mode (v or V)
3. Select some lines
4. Press `gy`
5. Verify clipboard contains `@relative/path#LX-Y` format
6. Verify notification appears

## Future Considerations

- Could extract shared logic into a function if more variants are needed
- Could add normal mode version for current line (e.g., `gyy`)
- Format is compatible with GitHub/GitLab markdown link syntax
