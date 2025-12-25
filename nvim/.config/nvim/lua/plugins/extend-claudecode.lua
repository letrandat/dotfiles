local toggle_key = "<M-e>" -- Alt + e (cmd+e from ghostty)
local USE_FLOATING_MODE = false -- true = floating window, false = split with zoom
local toggle_count = 0 -- Counter for debugging

-- Helper function to toggle between Claude Code window and last window with zoom
-- Mimics the tmux Cmd+L behavior: toggle between AI pane and main pane with zoom
local function toggle_claude_vsplit_term()
  toggle_count = toggle_count + 1
  print("[DEBUG] ========== Toggle #" .. toggle_count .. " ==========")
  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  -- Check if we're in a Claude Code terminal
  local is_claude_term = bufname:match("term://.*claude") ~= nil

  if is_claude_term then
    -- In Claude terminal, find a non-Claude window
    print("[DEBUG] In Claude terminal, checking zoom state...")
    local zen = require("snacks.zen")
    print("[DEBUG] Zoom active BEFORE search?", zen.win and zen.win:valid() or false)

    local current_win = vim.fn.winnr()
    print("[DEBUG] Current window number:", current_win)
    print("[DEBUG] Total windows:", vim.fn.winnr('$'))

    -- Search for a non-Claude window
    local found_editor = false
    for i = 1, vim.fn.winnr('$') do
      if i ~= current_win then
        vim.cmd(i .. "wincmd w")
        local buf = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
        if not buf:match("term://.*claude") then
          print("[DEBUG] Found non-Claude window:", i, "buffer:", buf:match("[^/]+$") or buf)
          found_editor = true
          break
        end
      end
    end

    if not found_editor then
      -- No non-Claude window found, go back to original
      vim.cmd(current_win .. "wincmd w")
      print("[DEBUG] No non-Claude window found, staying in Claude")
    end

    print("[DEBUG] After search - Current window:", vim.fn.winnr())

    if found_editor then
      -- Successfully moved to non-Claude buffer - zoom it
      print("[DEBUG] Moved to non-Claude buffer - zooming")
      local Snacks = require("snacks")

      -- Close existing zoom first to prevent window explosion
      if zen.win and zen.win:valid() then
        print("[DEBUG] Closing existing zoom before creating new one")
        zen.win:close()
        print("[DEBUG] Zoom closed, current window:", vim.fn.winnr())
      end

      print("[DEBUG] About to call Snacks.zen.zoom()")
      Snacks.zen.zoom()
      print("[DEBUG] Snacks.zen.zoom() completed")
    else
      -- Still in Claude buffer - do nothing
      print("[DEBUG] Still in Claude buffer after wincmd p - doing nothing")
    end
  else
    -- Not in Claude terminal, focus it and maximize
    vim.cmd("ClaudeCodeFocus")
    vim.defer_fn(function()
      local Snacks = require("snacks")
      local zen = require("snacks.zen")

      -- CRITICAL: Close existing zoom first to prevent window explosion!
      if zen.win and zen.win:valid() then
        print("[DEBUG] Closing existing zoom before focusing Claude")
        zen.win:close()
        print("[DEBUG] Zoom closed, current window:", vim.fn.winnr())
      end

      print("[DEBUG] About to call Snacks.zen.zoom() on Claude")
      Snacks.zen.zoom()
      print("[DEBUG] Snacks.zen.zoom() completed on Claude")
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
    { toggle_key, toggle_claude_vsplit_term, desc = "Claude Code (toggle/zoom)", mode = { "n", "x" } },
    -- Terminal mode: exit terminal mode first, then toggle with zoom
    {
      toggle_key,
      function()
        vim.cmd("stopinsert")
        vim.defer_fn(toggle_claude_vsplit_term, 10)
      end,
      desc = "Claude Code (toggle/zoom)",
      mode = "t",
    },
  }
end

return { plugin_config }
