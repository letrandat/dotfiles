# Change: Claude-Primary 2-Pane Workspace

## Why

The current dotfiles lack an optimized workflow for using Claude Code as the primary development tool with Neovim as a secondary quick-reference editor. Users who have shifted to an AI-first workflow face friction: no quick keybind to switch to Neovim for file verification, manual pane management required, and no spatial consistency for panes. This change implements a tmux 2-pane workspace that inverts the traditional editor-first model (mirroring the old 2-pane setup from commit 960d7a4 but with Claude as primary instead of Neovim).

## What Changes

- Add Ghostty keybind: Cmd+L sends tmux command sequence for pane toggle
- Add tmux pane toggle logic: Smart toggle between panes 1 (Claude/AI) and 2 (Neovim/editor) with automatic zoom
- Implement lazy pane creation: Pane 2 only created when first accessed via Cmd+L
- Add pane border formatting: Automatic visual labels "1(ai)" and "2(nvim)" in tmux pane borders
- Add cross-window behavior: Handle Cmd+L in windows with 0, 1, or 2+ panes (strict 2-pane model, don't create 3rd pane)
- Add error recovery: Auto-recreate panes if manually killed
- Add inline documentation: Clear comments in tmux.conf and ghostty config explaining behavior
- Preserve existing workflows: No changes to existing Cmd+e integrated Claude toggle or other keybinds

## Impact

- Affected specs: `tmux-pane-workflow` (new capability)
- Affected code:
  - `tmux/.tmux.conf`: Add pane border format, toggle keybind logic
  - `ghostty/.config/ghostty/config`: Add Cmd+L keybind mapping
