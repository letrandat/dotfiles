local M = {}

function M.setup()
    local vscode = require('vscode')
    --
    -- CORE CONFIGURATION
    --

    -- Clear highlights on search when pressing <Esc> in normal mode
    --  See `:help hlsearch`
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

    -- `p` in visual mode delete the selected text to the black hole register (`"_d`), then put (`P`) the contents of the default register
    vim.keymap.set('x', 'p', '"_dP', {
        desc = 'Paste without yanking replaced text'
    })

    -- Undo
    vim.keymap.set('n', 'u', function()
        vscode.call('undo')
    end, {
        desc = 'Undo'
    })

    -- Redo
    vim.keymap.set('n', '<C-r>', function()
        vscode.call('redo')
    end, {
        desc = 'Redo'
    })

    -- Move lines up and down in normal mode with `J` and `K`
    vim.keymap.set('n', 'K', function()
        vscode.call('editor.action.moveLinesUpAction')
    end, {
        desc = 'Move line up'
    })
    vim.keymap.set('n', 'J', function()
        vscode.call('editor.action.moveLinesDownAction')
    end, {
        desc = 'Move line down'
    })

    vim.keymap.set("n", "<leader>ff", function()
        vscode.call("workbench.action.quickOpen")
    end, {
        desc = "VSCode Quick Open"
    })

    -- Move to next and previous editor in group with 'L' and 'H'
    vim.keymap.set('n', 'L', function()
        vscode.call('workbench.action.nextEditorInGroup')
    end, {
        desc = 'Next editor in group'
    })
    vim.keymap.set('n', 'H', function()
        vscode.call('workbench.action.previousEditorInGroup')
    end, {
        desc = 'Previous editor in group'
    })

    --
    -- CODE ACTIONS
    --

    -- Rename symbol
    vim.keymap.set({'n', 'v'}, '<leader>cr', function()
        vscode.call('editor.action.rename')
    end, {
        desc = 'Rename symbol'
    })

    -- Refactor
    vim.keymap.set({'n', 'v'}, '<leader>ca', function()
        vscode.call('editor.action.refactor')
    end, {
        desc = 'Refactor'
    })

    -- Source action (refactor at source level)
    vim.keymap.set({'n', 'v'}, '<leader>cA', function()
        vscode.call('editor.action.sourceAction')
    end, {
        desc = 'Source action'
    })

    --
    -- Vim UI Configuration
    --
    -- [u]i toggle [w]rap
    vim.keymap.set('n', '<leader>uw', function()
        vscode.call('editor.action.toggleWordWrap')
    end, {
        desc = 'Toggle word wrap'
    })

    -- [u]i toggle [s]tatus menu
    vim.keymap.set('n', '<leader>us', function()
        vscode.call('workbench.action.toggleStatusbarVisibility')
    end, {
        desc = 'Toggle status bar visibility'
    })

    -- [u]i toggle [z]en mode (centered layout)
    vim.keymap.set('n', '<leader>uz', function()
        vscode.call('workbench.action.toggleCenteredLayout')
    end, {
        desc = 'Toggle centered layout (Zen mode)'
    })

    --
    -- SEARCH CONFIGURATION
    --
    vim.keymap.set('n', '<leader>sk', function()
        vscode.call('workbench.action.openGlobalKeybindings')
    end, {
        desc = 'Open Global Keybindings'
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

    --
    -- GIT CONFIGURATION
    --
    vim.keymap.set('v', '<leader>gr', function()
        vscode.call('git.revertSelectedRanges')
    end, {
        desc = 'Git: Revert selected ranges'
    })

    vim.keymap.set('v', '<leader>gs', function()
        vscode.call('git.stageSelectedRanges')
    end, {
        desc = 'Git: Stage selected ranges'
    })

    vim.keymap.set('v', '<leader>gu', function()
        vscode.call('git.unstageSelectedRanges')
    end, {
        desc = 'Git: Unstage selected ranges'
    })

end

return M
