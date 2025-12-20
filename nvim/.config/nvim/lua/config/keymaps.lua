-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- [S]how [F]iles - Sidebar file explorer (like GUI editors)
map("n", "<leader>sf", function()
  Snacks.explorer()
end, { desc = "Show Files (sidebar explorer)" })

-- [S]how [E]xplorer - netrw-like buffer editing (mini.files)
map("n", "<leader>se", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Show Explorer (mini.files)" })
