-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Exit terminal mode keybindings (in Claude Code terminal buffers only)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*claude*", -- Only match Claude Code terminals
  callback = function()
    -- Set keybindings for Claude terminal
    vim.keymap.set("t", "<C-u>", "<C-\\><C-n>", { buffer = 0, desc = "Exit terminal mode" })
    -- Skip keymap setup if using floating mode (handled in plugin config)
    if vim.g.claude_use_floating_mode then
      return
    end

    -- Try to load split mode module first
    local ok, split_mode = pcall(require, "util.claude-split-mode")
    if not ok then
      vim.notify("Failed to load util.claude-split-mode module for Claude Code keybindings", vim.log.levels.WARN)
      return
    end

    vim.keymap.set("t", "<M-e>", function()
      vim.defer_fn(split_mode.return_to_editor, 10)
    end, { buffer = 0, desc = "Return to editor" })
  end,
})
