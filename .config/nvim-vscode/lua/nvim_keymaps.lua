local opts = {
    noremap = true,
    silent = true
}
local keymap = vim.keymap.set
--
-- CORE CONFIGURATION
--

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- quit nvim
keymap('n', '<leader>qq', ':q<CR>', {
    desc = ':q<CR>'
})

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', {
    desc = 'Exit terminal mode'
})

--
-- LINES
--
-- Move lines up and down in normal mode
keymap('n', '<c-k>', ':m .-2<CR>==', {
    desc = 'Move line up'
})
keymap('n', '<c-j>', ':m .+1<CR>==', {
    desc = 'Move line down'
})

-- Move lines up and down in visual mode (multi-line support)
keymap('v', '<c-k>', ":m '<-2<CR>gv=gv", {
    desc = 'Move selected lines up'
})
keymap('v', '<c-j>', ":m '>+1<CR>gv=gv", {
    desc = 'Move selected lines down'
})

-- Go to next/previous git hunk
keymap('n', 'g;', function()
    vim.cmd('Gitsigns next_hunk')
end, {
    desc = 'Go to next git hunk'
})
keymap('n', 'g:', function()
    vim.cmd('Gitsigns prev_hunk')
end, {
    desc = 'Go to previous git hunk'
})

--
-- FILES
--

-- Keybinds to work with buffers
keymap('n', '<S-h>', ':bprev<CR>', {
    desc = 'Previous buffer'
})
keymap('n', '<S-l>', ':bnext<CR>', {
    desc = 'Next buffer'
})

keymap('n', '<leader>fp', ':silent !echo %:p | pbcopy<CR>', {
    desc = 'Copy current buffer file path'
})

-- with telescope

require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
        ['ui-select'] = {require('telescope.themes').get_dropdown()}
    }
}

-- Enable Telescope extensions if they are installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files({
        hidden = true,
        find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'}
    })
end, {
    desc = '[S]earch [F]iles'
})

--
-- BUFFER/WORKBENCH/WINDOWS CONFIGURATION
--

keymap('n', '<leader>wo', ':%bdelete|edit #|bdelete #<CR>', {
    desc = 'Close other buffers'
})

keymap('n', '<leader>wd', ':bdelete<CR>', {
    desc = 'Delete current buffer'
})

keymap('n', '<leader>,', ':Telescope buffers<CR>', {
    desc = 'Telescope active buffers'
})

keymap('n', '<leader>wv', ':vsplit<CR>', {
    desc = 'vsplit'
})

keymap('n', '<leader>ws', ':split<CR>', {
    desc = 'ssplit'
})

keymap('n', '<leader>wm', ':only<CR>', {
    desc = 'maximize current buffer'
})

-- Move focus between splits using arrow keys
keymap('n', '<Up>', '<C-w>k', {
    desc = 'Focus split up'
})
keymap('n', '<Down>', '<C-w>j', {
    desc = 'Focus split down'
})
keymap('n', '<Left>', '<C-w>h', {
    desc = 'Focus split left'
})
keymap('n', '<Right>', '<C-w>l', {
    desc = 'Focus split right'
})

--
-- netrw
--

-- Open netrw in the current file's directory
keymap('n', '\\', ':Ex<CR>', {
    desc = 'Open netrw in current directory'
})

--
-- Zen
--
vim.api.nvim_set_keymap('n', '<leader>uz', "<cmd>lua require'centerpad'.toggle{ leftpad = 30, rightpad = 30 }<cr>", opts)


--
-- Format
--
keymap("n", "<leader>cf", function()
    require("conform").format({ bufnr = 0 })
end, {
    desc = 'Format current buffer'
})