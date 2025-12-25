-- Utility functions for Claude Code toggle behavior
-- Shared between plugin config and autocmds

local M = {}

local DEBUG = false -- Set to true to enable debug logging
local toggle_count = 0 -- Counter for debugging

-- Debug print function
local function debug_print(...)
  if DEBUG then
    print(...)
  end
end

-- Function to return from Claude terminal to editor with zoom
-- Only should be called when already in Claude Code terminal
function M.return_to_editor()
  -- Exit terminal mode first
  vim.cmd("stopinsert")

  toggle_count = toggle_count + 1
  debug_print("[DEBUG] ========== Return to Editor #" .. toggle_count .. " ==========")

  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  -- Defensive check: only run if we're actually in Claude terminal
  local is_claude_term = bufname:match("term://.*claude") ~= nil
  if not is_claude_term then
    debug_print("[DEBUG] ERROR: return_to_editor() called from non-Claude buffer:", bufname)
    return
  end

  debug_print("[DEBUG] In Claude terminal, searching for editor window...")
  local zen = require("snacks.zen")
  debug_print("[DEBUG] Zoom active BEFORE search?", zen.win and zen.win:valid() or false)

  local current_win = vim.fn.winnr()
  debug_print("[DEBUG] Current window number:", current_win)
  debug_print("[DEBUG] Total windows:", vim.fn.winnr('$'))

  -- Search for a non-Claude window
  local found_editor = false
  for i = 1, vim.fn.winnr('$') do
    if i ~= current_win then
      vim.cmd(i .. "wincmd w")
      local buf = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      if not buf:match("term://.*claude") then
        debug_print("[DEBUG] Found non-Claude window:", i, "buffer:", buf:match("[^/]+$") or buf)
        found_editor = true
        break
      end
    end
  end

  if not found_editor then
    -- No non-Claude window found, go back to original
    vim.cmd(current_win .. "wincmd w")
    debug_print("[DEBUG] No non-Claude window found, staying in Claude")
    return
  end

  debug_print("[DEBUG] After search - Current window:", vim.fn.winnr())

  -- Successfully moved to non-Claude buffer - zoom it
  debug_print("[DEBUG] Moved to non-Claude buffer - zooming")
  local Snacks = require("snacks")

  -- Close existing zoom first to prevent window explosion
  if zen.win and zen.win:valid() then
    debug_print("[DEBUG] Closing existing zoom before creating new one")
    zen.win:close()
    debug_print("[DEBUG] Zoom closed, current window:", vim.fn.winnr())
  end

  debug_print("[DEBUG] About to call Snacks.zen.zoom()")
  Snacks.zen.zoom()
  debug_print("[DEBUG] Snacks.zen.zoom() completed")
end

-- Function to focus Claude Code terminal from editor with zoom
-- Called from normal/visual mode when in editor
function M.focus_claude()
  toggle_count = toggle_count + 1
  debug_print("[DEBUG] ========== Focus Claude #" .. toggle_count .. " ==========")

  debug_print("[DEBUG] Focusing Claude Code terminal...")
  vim.cmd("ClaudeCodeFocus")
  vim.defer_fn(function()
    local Snacks = require("snacks")
    local zen = require("snacks.zen")

    -- Close existing zoom first to prevent window explosion
    if zen.win and zen.win:valid() then
      debug_print("[DEBUG] Closing existing zoom before focusing Claude")
      zen.win:close()
      debug_print("[DEBUG] Zoom closed, current window:", vim.fn.winnr())
    end

    debug_print("[DEBUG] About to call Snacks.zen.zoom() on Claude")
    Snacks.zen.zoom()
    debug_print("[DEBUG] Snacks.zen.zoom() completed on Claude")
  end, 50)
end

return M
