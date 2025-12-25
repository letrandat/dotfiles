local toggle_key = "<M-e>" -- Alt + e (cmd+e from ghostty)
local USE_FLOATING_MODE = false -- true = floating window, false = split with zoom

-- Helper function to toggle between Claude Code window and last window with zoom
-- Mimics the tmux Cmd+L behavior: toggle between AI pane and main pane with zoom
local function toggle_claude_zoom()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  -- Check if we're in a Claude Code terminal
  local is_claude_term = bufname:match("term://.*claude") ~= nil

  if is_claude_term then
    -- In Claude terminal, go back to previous window
    local current_win = vim.fn.winnr()
    vim.cmd("wincmd p")

    -- Check if wincmd p actually moved us
    if vim.fn.winnr() == current_win then
      -- Still in same window - Claude is the only window
      -- Create vsplit with new empty buffer on the left, Claude stays on right
      vim.cmd("leftabove vnew")
    else
      -- Successfully moved to another window - maximize it
      local Snacks = require("snacks")
      Snacks.zen.zoom()
    end
  else
    -- Not in Claude terminal, focus it and maximize
    vim.cmd("ClaudeCodeFocus")
    vim.defer_fn(function()
      local Snacks = require("snacks")
      Snacks.zen.zoom()
    end, 50)
  end
end

-- Build base plugin configuration
local plugin_config = {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    focus_after_send = true,
  },
}

-- Configure based on selected mode
if USE_FLOATING_MODE then
  -- Mode 1: Floating window overlay
  plugin_config.opts.terminal = {
    snacks_win_opts = {
      position = "float",
      width = 0.9,
      height = 0.9,
      border = "rounded",
      keys = {
        claude_hide = {
          toggle_key,
          function(self)
            self:hide()
          end,
          mode = "t",
          desc = "Hide",
        },
      },
    },
  }
  -- Global keybindings for floating mode (show/hide/focus)
  plugin_config.keys = {
    { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code (toggle)", mode = { "n", "x" } },
    {
      toggle_key,
      function()
        vim.cmd("stopinsert")
        vim.defer_fn(function()
          vim.cmd("ClaudeCodeFocus")
        end, 10)
      end,
      desc = "Claude Code (toggle)",
      mode = "t",
    },
  }
else
  -- Mode 2: Split with LazyVim-style zoom
  plugin_config.keys = {
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
  }
end

return { plugin_config }
