-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map Ctrl+q to quit all
vim.keymap.set("n", "<C-q>", "<cmd>qa<cr>", { desc = "Quit all" })
