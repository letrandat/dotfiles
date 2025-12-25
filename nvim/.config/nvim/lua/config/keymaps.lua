-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- [S]how [F]iles - Sidebar file explorer (like GUI editors)
map("n", "<leader>sf", function()
  Snacks.explorer()
end, { desc = "Show Files (sidebar explorer)" })

-- [S]how [E]xplorer - oil.nvim
map("n", "<leader>se", ":Oil<CR>", { desc = "Show Explorer (netrw)" })

-- Command Palette (similar to VS Code Ctrl+Shift+P)
map("n", "<leader><leader>", function()
  Snacks.picker.commands()
end, { desc = "Command Palette" })

-- Open working memory file
map("n", "<A-8>", function()
  vim.cmd.edit("~/workspace/working_memory.txt")
end, { desc = "Working Memory" })

-- ============================================================================
-- Line Movement (VS Code style)
-- ============================================================================
-- Move lines up and down in normal mode
map("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })

-- Move lines up and down in visual mode (multi-line support)
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })

-- ============================================================================
-- File Path Copying
-- ============================================================================
-- Copy relative path with line range in visual mode
map("v", "Y", function()
  local path = vim.fn.expand("%:.")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local ref = "@" .. path .. "#L" .. start_line .. "-" .. end_line
  vim.fn.setreg("+", ref)
  vim.notify("Copied: " .. ref, vim.log.levels.INFO)
end, { desc = "Copy relative file path with line range" })

-- ============================================================================
-- Search and Replace
-- ============================================================================
-- Normal mode: replace word under cursor
map("n", "gs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Visual mode: replace selected text
map("v", "gs", [["zy:%s/<C-r>z/<C-r>z/gI<Left><Left><Left>]], { desc = "Replace selected text" })

-- ============================================================================
-- Split Navigation (Arrow Keys)
-- ============================================================================
map("n", "<Up>", "<C-w>k", { desc = "Focus split up" })
map("n", "<Down>", "<C-w>j", { desc = "Focus split down" })
map("n", "<Left>", "<C-w>h", { desc = "Focus split left" })
map("n", "<Right>", "<C-w>l", { desc = "Focus split right" })

-- ============================================================================
-- Git Hunk Navigation (Alternative to ]h/[h)
-- ============================================================================
map("n", "g;", function()
  if vim.wo.diff then
    vim.cmd.normal({ "g;", bang = true })
  else
    ---@diagnostic disable-next-line: param-type-mismatch
    require("gitsigns").nav_hunk("next")
  end
end, { desc = "Next hunk" })

map("n", "g:", function()
  if vim.wo.diff then
    vim.cmd.normal({ "g:", bang = true })
  else
    ---@diagnostic disable-next-line: param-type-mismatch
    require("gitsigns").nav_hunk("prev")
  end
end, { desc = "Previous hunk" })

-- ============================================================================
-- Git Diff Shortcut
-- ============================================================================
-- <leader>go -> <leader>ghd (git diff this)
map("n", "<leader>go", function()
  require("gitsigns").diffthis()
end, { desc = "Diff This (git)" })

-- <leader>gr -> <leader>ghr (git hunk reset)
map("v", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })

-- <leader>gs -> <leader>ghs (git hunk stage)
map("v", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
