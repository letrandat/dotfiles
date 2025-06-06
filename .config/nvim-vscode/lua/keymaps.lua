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

    -- g; (go to next change)
    vim.keymap.set('n', 'g;', function()
        vscode.call('workbench.action.editor.nextChange')
        vscode.call('workbench.action.compareEditor.nextChange')
        vscode.call('chatEditor.action.navigateNext')
    end, {
        desc = 'Go to next change'
    })
    -- g: (go to previous change)
    vim.keymap.set('n', 'g:', function()
        vscode.call('workbench.action.editor.previousChange')
        vscode.call('workbench.action.compareEditor.previousChange')
        vscode.call('chatEditor.action.navigatePrevious')
    end, {
        desc = 'Go to previous change'
    })

    --
    -- FILES
    --
    -- List [f]ile
    vim.keymap.set("n", "<leader>ff", function()
        vscode.call("workbench.action.quickOpen")
    end, {
        desc = "VSCode Quick Open"
    })

    -- Copy [f]ile [p]ath (relative)
    vim.keymap.set("n", "<leader>fp", function()
        vscode.call("copyRelativeFilePath")
    end, {
        desc = "Copy relative file path"
    })

    -- Copy [f]ile [P]ath (absolute)
    vim.keymap.set("n", "<leader>fP", function()
        vscode.call("copyFilePath")
    end, {
        desc = "Copy absolute file path"
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
    -- LSP support
    --

    -- gr (go to references)
    vim.keymap.set('n', 'gr', function()
        vscode.call('editor.action.referenceSearch.trigger')
    end, {
        desc = 'Go to references'
    })

    -- gD (go to source definition)
    vim.keymap.set('n', 'gD', function()
        vscode.call('typescript.goToSourceDefinition')
    end, {
        desc = 'Go to source definition'
    })

    -- gI (go to Implementation)
    vim.keymap.set('n', 'gI', function()
        vscode.call('editor.action.goToImplementation')
    end, {
        desc = 'Go to implementation'
    })

    -- gA (go to [A]ll implementations)
    vim.keymap.set('n', 'gA', function()
        vscode.call('references-view.findImplementations')
    end, {
        desc = 'Find all implementations'
    })

    -- gf (alias for gd)
    vim.keymap.set('n', 'gf', 'gd', {
        remap = true,
        desc = 'Go to definition (alias)'
    })

    -- gy (go to t[y]pe definition)
    vim.keymap.set('n', 'gy', function()
        vscode.call('editor.action.goToTypeDefinition')
    end, {
        desc = 'Go to type definition'
    })

    -- gK (go to params hint)
    vim.keymap.set('n', 'gK', function()
        vscode.call('editor.action.triggerParameterHints')
    end, {
        desc = 'Trigger parameter hints'
    })

    -- gch (go to [c]all [h]ierarchy)
    vim.keymap.set('n', 'gch', function()
        vscode.call('editor.showCallHierarchy')
    end, {
        desc = 'Show call hierarchy'
    })

    -- go to previous [W]arning
    vim.keymap.set('n', 'gW', function()
        vscode.call('editor.action.marker.prevInFiles')
    end, {
        desc = 'Go to previous warning'
    })

    -- go to next [w]arning
    vim.keymap.set('n', 'gw', function()
        vscode.call('editor.action.marker.nextInFiles')
    end, {
        desc = 'Go to next warning'
    })

    -- go to [s]ymbol in file
    vim.keymap.set('n', '<leader>ss', function()
        vscode.call('workbench.action.gotoSymbol')
    end, {
        desc = 'Go to symbol in file'
    })

    -- go to [S]ymbol in workspace
    vim.keymap.set('n', '<leader>sS', function()
        vscode.call('workbench.action.showAllSymbols')
    end, {
        desc = 'Go to symbol in workspace'
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

    -- [f]ormat code
    vim.keymap.set('n', '<leader>cf', function()
        vscode.call('editor.action.formatDocument')
    end, {
        desc = 'Format document'
    })

    -- [o]rganize imports
    vim.keymap.set('n', '<leader>o', function()
        vscode.call('editor.action.organizeImports')
    end, {
        desc = 'Organize imports'
    })

    --
    -- UI Configuration
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

    -- [u]i [v]iew markdown preview to the side
    vim.keymap.set('n', '<leader>uv', function()
        if vim.bo.filetype == "markdown" then
            vscode.call('markdown.showPreviewToSide')
        end
    end, {
        desc = 'Markdown: Show preview to side'
    })

    -- [u]i [V]iew (BIGGER) markdown preview
    vim.keymap.set('n', '<leader>uV', function()
        if vim.bo.filetype == "markdown" then
            vscode.call('markdown.showPreview')
        end
    end, {
        desc = 'Markdown: Show preview'
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

    -- Use arrow keys to move between editor groups (splits)
    vim.keymap.set('n', '<Up>', function()
        vscode.call('workbench.action.focusAboveGroup')
    end, {
        desc = 'Move to split above'
    })
    vim.keymap.set('n', '<Down>', function()
        vscode.call('workbench.action.focusBelowGroup')
    end, {
        desc = 'Move to split below'
    })
    vim.keymap.set('n', '<Left>', function()
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Move to split left'
    })
    vim.keymap.set('n', '<Right>', function()
        vscode.call('workbench.action.focusRightGroup')
    end, {
        desc = 'Move to split right'
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

    --
    -- HARPOON CONFIGURATION
    --

    vim.keymap.set('n', '<leader>h1', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
        vscode.call('vscode-harpoon.gotoEditor1')
        vscode.call('workbench.action.closeOtherEditors')
    end, {
        desc = 'Maximize, go to Harpoon 1, close others'
    })

    vim.keymap.set('n', '<leader>h2', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
        vscode.call('vscode-harpoon.gotoEditor1')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('vscode-harpoon.gotoEditor2')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Split: Harpoon 1 (left-focus), 2 (right)'
    })

    -- Create split windows with left, mid, and right as harpoon 1, 2, and 3, focus middle
    vim.keymap.set('n', '<leader>h3', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
        vscode.call('vscode-harpoon.gotoEditor1')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('vscode-harpoon.gotoEditor2')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('vscode-harpoon.gotoEditor3')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Split: Harpoon 1, 2, 3 (left, mid-focus, right)'
    })

    -- Create split windows with left, mid, right (top/bottom) as harpoon 1, 2, 3, and 4, focus middle
    vim.keymap.set('n', '<leader>h4', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
        vscode.call('vscode-harpoon.gotoEditor1')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('vscode-harpoon.gotoEditor2')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('vscode-harpoon.gotoEditor3')
        vscode.call('workbench.action.closeOtherEditors')
        vscode.call('workbench.action.splitEditorDown')
        vscode.call('vscode-harpoon.gotoEditor4')
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Split: Harpoon 1, 2, 3, 4 (left, mid-focus, right, bottom)'
    })

    --
    -- GIT/LAZYGIT/GITLENS CONFIGURATION
    --

    -- [g]it [o] open change
    vim.keymap.set('n', '<leader>go', function()
        vscode.call('git.openChange')
        vscode.call('workbench.action.focusFirstEditorGroup')
    end, {
        desc = 'Git: Open change and focus first editor group'
    })

    -- [g]it [O] open all changes
    vim.keymap.set('n', '<leader>gO', function()
        vscode.call('git.viewChanges')
    end, {
        desc = 'Git: View all changes'
    })

    -- [g]it view [S]tage changes
    vim.keymap.set('n', '<leader>gS', function()
        vscode.call('git.viewStagedChanges')
        vscode.call('workbench.action.focusFirstEditorGroup')
    end, {
        desc = 'Git: View staged changes and focus first editor group'
    })

    -- gitlens: [g]it [b]lame
    vim.keymap.set('n', '<leader>gb', function()
        vscode.call('gitlens.toggleLineBlame')
    end, {
        desc = 'GitLens: Toggle line blame'
    })

    -- gitlens: [g]it file [B]lame
    vim.keymap.set('n', '<leader>gB', function()
        vscode.call('gitlens.toggleFileBlame')
    end, {
        desc = 'GitLens: Toggle file blame'
    })

end

return M
