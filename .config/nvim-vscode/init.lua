local vscode = require('vscode')

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

-- set vscode.notify as default notify function.
vim.notify = vscode.notify

--
-- [[ Keymaps ]]
--
require('keymaps').setup()

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
    import = "plugins"
}})

-- Default oil.code keymaps
if vim.g.vscode then
    local vscode = require('vscode')
    local map = vim.keymap.set
    vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
        pattern = {"*"},
        callback = function()
            map("n", "-", function()
                vscode.action('oil-code.open')
            end)
        end
    })

    vim.api.nvim_create_autocmd({'FileType'}, {
        pattern = {"oil"},
        callback = function()
            map("n", "-", function()
                vscode.action('oil-code.openParent')
            end)
            map("n", "p", function()
                vscode.action('oil-code.preview')
            end)
            map("n", "<CR>", function()
                vscode.action('oil-code.select')
            end)
            map("n", "<C-l>", function()
                vscode.action('oil-code.refresh')
            end)
            map("n", "q", function()
                vscode.action('oil-code.close')
            end)
        end
    })
end
