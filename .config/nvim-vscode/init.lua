local hascode = vim.g.vscode

--
-- [[ Basic Configuration ]]
--

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- allowing more breathing room when using vim keybindings
vim.opt.timeoutlen = 3000

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

if hascode then
    -- set vscode.notify as default notify function.
    vim.notify = require('vscode').notify
else
    -- Set to true if you have a Nerd Font installed and selected in the terminal
    vim.g.have_nerd_font = true

    -- Make line numbers default
    vim.o.number = true

    -- You can also add relative line numbers, to help with jumping.
    --  Experiment for yourself to see if you like it!
    vim.o.relativenumber = true
end

--
-- [[ Basic Autocommands ]]
--
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {
        clear = true
    }),
    callback = function()
        vim.hl.on_yank()
    end
})

--
-- [[ Install `lazy.nvim` plugin manager ]]
--
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system {'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath}
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({{
    import = "code_plugins",
    cond = hascode
}, {
    import = "plugins",
    cond = true
}, {
    import = "nocode_plugins",
    cond = not hascode
}})

--
-- [[ Keymaps ]]
--
if hascode then
    require('code_keymaps').setup()
else
    require('nvim_keymaps').setup()
end
