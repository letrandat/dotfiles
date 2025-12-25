-- Utility functions for Claude Code toggle behavior
-- Shared between plugin config and autocmds

local M = {}

-- Function to return from Claude terminal to editor with zoom
-- Only should be called when already in Claude Code terminal
function M.return_to_editor()
  -- Exit terminal mode first
  vim.cmd("stopinsert")

  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  -- Defensive check: only run if we're actually in Claude terminal
  local is_claude_term = bufname:match("term://.*claude") ~= nil
  if not is_claude_term then
    return
  end

  local zen = require("snacks.zen")
  local current_win = vim.fn.winnr()

  -- Search for a non-Claude window
  local found_editor = false
  for i = 1, vim.fn.winnr("$") do
    if i ~= current_win then
      vim.cmd(i .. "wincmd w")
      local buf = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
      if not buf:match("term://.*claude") then
        found_editor = true
        break
      end
    end
  end

  if not found_editor then
    -- No non-Claude window found, go back to original
    vim.cmd(current_win .. "wincmd w")
    vim.notify("No editor window found to return to", vim.log.levels.WARN)
    return
  end

  -- Successfully moved to non-Claude buffer - zoom it
  local Snacks = require("snacks")

  -- Close existing zoom on Claude Code terminal before creating new zoom on editor
  -- (zen.win is global state - we're moving the zoom from Claude window to editor window)
  if zen.win and zen.win:valid() then
    zen.win:close()
  end

  Snacks.zen.zoom()
end

-- Function to focus Claude Code terminal from editor with zoom
-- Called from normal/visual mode when in editor
function M.focus_claude()
  -- Close existing zoom BEFORE switching to Claude (from current editor context)
  local zen = require("snacks.zen")
  if zen.win and zen.win:valid() then
    zen.win:close()
  end

  vim.cmd("ClaudeCodeFocus")
  vim.defer_fn(function()
    local Snacks = require("snacks")
    Snacks.zen.zoom()
  end, 50)
end

return M
