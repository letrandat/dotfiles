local toggle_key = "<M-e>" -- Alt + e
return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
    },
    opts = {
      -- terminal = {
      --   snacks_win_opts = {
      --     position = "float",
      --     width = 0.9,
      --     height = 0.9,
      --     border = "rounded",
      --     keys = {
      --       claude_hide = {
      --         toggle_key,
      --         function(self)
      --           self:hide()
      --         end,
      --         mode = "t",
      --         desc = "Hide",
      --       },
      --     },
      --   },
      -- },

      -- Diff Integration
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
        keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      },
    },
  },
}
