# LazyVim Relative Line Numbers, Harpoon, and Marks Cheatsheet Design

**Date:** 2025-12-22

## Overview

Add relative line numbers, clarify harpoon configuration strategy, and create a fuzzy-searchable cheatsheet for nvim keybindings (marks, harpoon, and other LazyVim shortcuts).

## Requirements

1. Enable relative line numbers for better vim motion efficiency
2. Optimize harpoon configuration (remove redundant opts)
3. Use native vim marks for bookmarks (no additional plugins)
4. Create interactive cheatsheet script similar to tmux-cheatsheet

## Implementation

### 1. Relative Line Numbers

**Status:** ✅ Complete (user implemented)

Added to `nvim/.config/nvim/lua/config/options.lua`:
```lua
vim.opt.relativenumber = true
```

**Benefits:**
- Shows distance to lines above/below cursor
- Enables efficient vim motions (e.g., `5j` to jump 5 lines)
- Works alongside absolute line number for current line

### 2. Harpoon Configuration

**Strategy:** Hybrid approach
- LazyVim's `harpoon2` extra (in `lazyvim.json`) provides base plugin setup
- Custom `lua/plugins/harpoon.lua` overrides keybindings only
- Removed redundant `opts` block (LazyVim extras already provide same settings)

**Simplified harpoon.lua:**
```lua
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    keys = function()
      -- Custom keybindings only
    end,
  },
}
```

**Custom Keybindings:**
- `Alt+m` - Add file to harpoon
- `Alt+o` - Quick menu
- `Alt+j/k/l/;` - Jump to slots 1-4
- `<leader>hj/k/l/;` - Replace slots 1-4

**LazyVim Default Settings (inherited from extra):**
- Menu width: `vim.api.nvim_win_get_width(0) - 4`
- Save on toggle: `true`

### 3. Bookmarks - Native Vim Marks

**Decision:** Use vim's native marks (no plugins)

**Essential Commands:**

| Command | Action |
|---------|--------|
| `m{a-z}` | Set local mark |
| `'{a-z}` | Jump to mark line |
| `` `{a-z} `` | Jump to exact mark position |
| `<leader>sm` | Search all marks (LazyVim picker) |
| `:marks` | View all marks |
| `:delmarks {marks}` | Delete marks |
| `:delmarks!` | Delete all lowercase marks |

**Special Marks:**
- `''` - Jump to last position
- `'.` - Jump to last change
- `'^` - Jump to last insert position

### 4. Interactive Cheatsheet Script

**File:** `bin/.local/dotfiles-bin/nvim-cheatsheet`

**Features:**
- Fuzzy search with fzf
- Organized by categories (Marks, Harpoon, Files, Navigation, Editing, etc.)
- Action types: `[info]` (display) and `[exec]` (execute command)
- Dynamic leader key substitution

**Categories Included:**
- **Marks:** All vim marks commands
- **Harpoon:** Custom keybindings
- **Files:** Path copying, explorers
- **Navigation:** Split/window navigation, git hunks
- **Editing:** Line movement, search/replace
- **System:** Command palette, working memory
- **Config:** Quick access to view/edit config files

**Usage:**
```bash
nvim-cheatsheet
```

## Files Changed

1. ✅ `nvim/.config/nvim/lua/config/options.lua` - Added `relativenumber`
2. ✅ `nvim/.config/nvim/lua/plugins/harpoon.lua` - Removed redundant opts
3. ✅ `bin/.local/dotfiles-bin/nvim-cheatsheet` - New cheatsheet script

## Testing Checklist

- [x] Relative line numbers enabled
- [x] Harpoon keybindings work (Alt+m, Alt+o, etc.)
- [x] Vim marks functional (`ma` to set, `'a` to jump)
- [x] LazyVim mark search works (`<leader>sm`)
- [x] nvim-cheatsheet script executable and searchable

## Benefits

1. **Simpler Config:** Removed 8 lines of redundant harpoon configuration
2. **Better Discoverability:** Interactive cheatsheet makes learning keybindings easier
3. **Consistent Pattern:** Follows dotfiles-bin convention and tmux-cheatsheet style
4. **Native Tools:** Uses vim marks instead of adding plugin complexity
5. **Efficient Navigation:** Relative line numbers improve vim motion speed

## References

- [LazyVim Keymaps](http://www.lazyvim.org/keymaps)
- [LazyVim Harpoon2 Extra](https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/harpoon2.lua)
- [Vim Marks Documentation](https://www.tutorialspoint.com/vim/vim_markers.htm)
