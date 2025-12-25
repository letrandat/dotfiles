-- Load shared configuration from options.lua
local toggle_key = vim.g.claude_toggle_key

-- Load utility functions
local claude_toggle = require("util.claude-toggle")

-- Build base plugin configuration
local plugin_config = {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    focus_after_send = true,
  },
}

-- Configure based on selected mode
if vim.g.claude_use_floating_mode then
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
    -- Normal and visual mode: focus Claude from editor
    { toggle_key, claude_toggle.focus_claude, desc = "Claude Code (focus)", mode = { "n", "x" } },
    -- Note: Terminal mode keybinding is set in autocmds.lua (Claude-specific only)
  }
end

-- Return plugin spec directly (not wrapped) for LazyVim
return plugin_config
