local toggle_key = "<M-e>" -- Alt + e

-- Helper function to toggle between Claude Code window and last window with zoom
-- Mimics the tmux Cmd+L behavior: toggle between AI pane and main pane with zoom
local function toggle_claude_zoom()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  -- Check if we're in a Claude Code terminal
  local is_claude_term = bufname:match("term://.*claude") ~= nil

  if is_claude_term then
    -- In Claude terminal, go back to previous window and maximize it
    vim.cmd("wincmd p")
    vim.cmd("wincmd |") -- Maximize width
    vim.cmd("wincmd _") -- Maximize height
  else
    -- Not in Claude terminal, focus it and maximize
    vim.cmd("ClaudeCodeFocus")
    vim.defer_fn(function()
      vim.cmd("wincmd |") -- Maximize width
      vim.cmd("wincmd _") -- Maximize height
    end, 50)
  end
end

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      -- Normal and visual mode: toggle with zoom
      { toggle_key, toggle_claude_zoom, desc = "Claude Code (toggle/zoom)", mode = { "n", "x" } },
      -- Terminal mode: exit terminal mode first, then toggle with zoom
      {
        toggle_key,
        function()
          vim.cmd("stopinsert")
          vim.defer_fn(toggle_claude_zoom, 10)
        end,
        desc = "Claude Code (toggle/zoom)",
        mode = "t",
      },
    },
    opts = {},
  },
}
