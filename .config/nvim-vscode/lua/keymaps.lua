local M = {}

function M.setup()
    -- Clear highlights on search when pressing <Esc> in normal mode
    --  See `:help hlsearch`
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    local vscode = require('vscode')
    vim.keymap.set("n", "<leader>ff", function()
        vscode.call("workbench.action.quickOpen")
    end, {
        desc = "VSCode Quick Open"
    })

    --
    -- BUFFER/WORKBENCH/WINDOWS CONFIGURATION
    --
    vim.keymap.set('n', '<leader>wo', function()
        vscode.call('workbench.action.closeOtherEditors')
    end, {
        desc = 'Close other editors'
    })
    vim.keymap.set('n', '<leader>wd', function()
        vscode.call('workbench.action.closeActiveEditor')
        vscode.call('workbench.action.focusFirstEditorGroup')
    end, {
        desc = 'Delete current buffer/window'
    })
    vim.keymap.set('n', '<leader>,', function()
        vscode.call('workbench.action.showAllEditorsByMostRecentlyUsed')
    end, {
        desc = 'Show all editors by MRU'
    })
    vim.keymap.set('n', '<leader>wv', function()
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Vertical split right, stay focused'
    })
    vim.keymap.set('n', '<leader>wV', function()
        vscode.call('workbench.action.splitEditorRight')
    end, {
        desc = 'Vertical split right, move focus'
    })
    vim.keymap.set('n', '<leader>ws', function()
        vscode.call('workbench.action.splitEditorDown')
        vscode.call('workbench.action.focusAboveGroup')
    end, {
        desc = 'Split down, stay focused'
    })
    vim.keymap.set('n', '<leader>wS', function()
        vscode.call('workbench.action.splitEditorDown')
    end, {
        desc = 'Split down, move focus'
    })
    vim.keymap.set('n', '<leader>wm', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
    end, {
        desc = 'Maximize active editor'
    })

    --
    -- BOOKMARKS PLUGINS CONFIGURATION
    --
    vim.keymap.set('n', 'mm', function()
        vscode.call('bookmarks.toggle')
    end, {
        desc = 'Toggle bookmark'
    })
    vim.keymap.set('n', 'mf', function()
        vscode.call('bookmarks.jumpToNext')
    end, {
        desc = 'Jump to next bookmark'
    })
    vim.keymap.set('n', 'mF', function()
        vscode.call('bookmarks.jumpToPrevious')
    end, {
        desc = 'Jump to previous bookmark'
    })
    vim.keymap.set('n', 'ml', function()
        vscode.call('bookmarks.listFromAllFiles')
    end, {
        desc = 'List bookmarks from all files'
    })

end

return M
