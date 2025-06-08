local M = {}

function M.setup()
    local vscode = require('vscode')
    local vscode_async = require('vscode').action
    local opts = {
        noremap = true,
        silent = true
    }
    local keymap = vim.keymap.set

    --
    -- CORE CONFIGURATION
    --

    -- Better Scrolling
    keymap('n', '<C-d>', '12jzz', opts)
    keymap('n', '<C-u>', '12kzz', opts)
    keymap('n', '<C-f>', '24jzz', opts)
    keymap('n', '<C-b>', '24kzz', opts)

    -- Clear highlights on search when pressing <Esc> in normal mode
    --  See `:help hlsearch`
    keymap('n', '<Esc>', function()
        vim.cmd('nohlsearch')
        vscode.call('notifications.clearAll')
    end, {
        desc = 'Clear highlights and notifications'
    })

    -- `p` in visual mode delete the selected text to the black hole register (`"_d`), then put (`P`) the contents of the default register
    keymap('x', 'p', '"_dP', {
        desc = 'Paste without yanking replaced text'
    })

    -- Undo
    keymap('n', 'u', function()
        vscode.call('undo')
    end, {
        desc = 'Undo'
    })

    -- Redo
    keymap('n', '<C-r>', function()
        vscode.call('redo')
    end, {
        desc = 'Redo'
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

    -- g; (go to next change)
    keymap('n', 'g;', function()
        vscode.call('workbench.action.editor.nextChange')
        vscode.call('workbench.action.compareEditor.nextChange')
        vscode.call('chatEditor.action.navigateNext')
    end, {
        desc = 'Go to next change'
    })
    -- g: (go to previous change)
    keymap('n', 'g:', function()
        vscode.call('workbench.action.editor.previousChange')
        vscode.call('workbench.action.compareEditor.previousChange')
        vscode.call('chatEditor.action.navigatePrevious')
    end, {
        desc = 'Go to previous change'
    })

    keymap('n', 'za', function()
        vscode.call('editor.toggleFold')
    end, {
        desc = 'Toggle fold code'
    })

    --
    -- FILES
    --
    -- List [f]ile
    keymap("n", "<leader>ff", function()
        vscode.call("workbench.action.quickOpen")
    end, {
        desc = "VSCode Quick Open"
    })

    -- Copy [f]ile [p]ath (relative)
    keymap("n", "<leader>fp", function()
        vscode.call("copyRelativeFilePath")
    end, {
        desc = "Copy relative file path"
    })

    -- Copy [f]ile [P]ath (absolute)
    keymap("n", "<leader>fP", function()
        vscode.call("copyFilePath")
    end, {
        desc = "Copy absolute file path"
    })

    -- Move to next and previous editor in group with 'L' and 'H'
    keymap('n', 'L', function()
        vscode.call('workbench.action.nextEditorInGroup')
    end, {
        desc = 'Next editor in group'
    })
    keymap('n', 'H', function()
        vscode.call('workbench.action.previousEditorInGroup')
    end, {
        desc = 'Previous editor in group'
    })

    --
    -- SEARCH
    -- with find-it-faster

    keymap('n', '<leader>sf', function()
        vscode.call('find-it-faster.findFiles')
    end, {
        desc = 'Find Files'
    })

    keymap('n', '<leader>sg', function()
        vscode.call('find-it-faster.findWithinFiles')
    end, {
        desc = 'Find Within Files'
    })

    keymap('n', '<leader>sG', function()
        vscode.call('find-it-faster.findWithinFilesWithType')
    end, {
        desc = 'Find Within Files With Type'
    })

    keymap('n', '<leader>sr', function()
        vscode.call('find-it-faster.resumeSearch')
    end, {
        desc = '[S]earch [R]esume'
    })

    --
    -- LSP support
    --

    -- gr (go to references)
    keymap('n', 'gr', function()
        vscode.call('editor.action.referenceSearch.trigger')
    end, {
        desc = 'Go to references'
    })

    -- gD (go to source definition)
    keymap('n', 'gD', function()
        vscode.call('typescript.goToSourceDefinition')
    end, {
        desc = 'Go to source definition'
    })

    -- gI (go to Implementation)
    keymap('n', 'gI', function()
        vscode.call('editor.action.goToImplementation')
    end, {
        desc = 'Go to implementation'
    })

    -- gA (go to [A]ll implementations)
    keymap('n', 'gA', function()
        vscode.call('references-view.findImplementations')
    end, {
        desc = 'Find all implementations'
    })

    -- gf (alias for gd)
    keymap('n', 'gf', 'gd', {
        remap = true,
        desc = 'Go to definition (alias)'
    })

    -- gy (go to t[y]pe definition)
    keymap('n', 'gy', function()
        vscode.call('editor.action.goToTypeDefinition')
    end, {
        desc = 'Go to type definition'
    })

    -- gK (go to params hint)
    keymap('n', 'gK', function()
        vscode.call('editor.action.triggerParameterHints')
    end, {
        desc = 'Trigger parameter hints'
    })

    -- gch (go to [c]all [h]ierarchy)
    keymap('n', 'gch', function()
        vscode.call('editor.showCallHierarchy')
    end, {
        desc = 'Show call hierarchy'
    })

    -- go to previous [W]arning
    keymap('n', 'gW', function()
        vscode.call('editor.action.marker.prevInFiles')
    end, {
        desc = 'Go to previous warning'
    })

    -- go to next [w]arning
    keymap('n', 'gw', function()
        vscode.call('editor.action.marker.nextInFiles')
    end, {
        desc = 'Go to next warning'
    })

    -- go to [s]ymbol in file
    keymap('n', '<leader>ss', function()
        vscode.call('workbench.action.gotoSymbol')
    end, {
        desc = 'Go to symbol in file'
    })

    -- go to [S]ymbol in workspace
    keymap('n', '<leader>sS', function()
        vscode.call('workbench.action.showAllSymbols')
    end, {
        desc = 'Go to symbol in workspace'
    })

    --
    -- CODE ACTIONS
    --

    -- Rename symbol
    keymap({'n', 'v'}, '<leader>cr', function()
        vscode.call('editor.action.rename')
    end, {
        desc = 'Rename symbol'
    })

    -- Refactor
    keymap({'n', 'v'}, '<leader>ca', function()
        vscode.call('editor.action.refactor')
    end, {
        desc = 'Refactor'
    })

    -- Source action (refactor at source level)
    keymap({'n', 'v'}, '<leader>cA', function()
        vscode.call('editor.action.sourceAction')
    end, {
        desc = 'Source action'
    })

    -- [f]ormat code
    keymap('n', '<leader>cf', function()
        vscode.call('editor.action.formatDocument')
    end, {
        desc = 'Format document'
    })

    -- [o]rganize imports
    keymap('n', '<leader>co', function()
        vscode.call('editor.action.organizeImports')
    end, {
        desc = 'Organize imports'
    })

    --
    -- UI Configuration
    --
    -- [u]i toggle [w]rap
    keymap('n', '<leader>uw', function()
        vscode.call('editor.action.toggleWordWrap')
    end, {
        desc = 'Toggle word wrap'
    })

    -- [u]i toggle [s]tatus menu
    keymap('n', '<leader>us', function()
        vscode.call('workbench.action.toggleStatusbarVisibility')
    end, {
        desc = 'Toggle status bar visibility'
    })

    -- [u]i toggle [z]en mode (centered layout)
    keymap('n', '<leader>uz', function()
        vscode.call('workbench.action.toggleCenteredLayout')
    end, {
        desc = 'Toggle centered layout (Zen mode)'
    })

    -- [u]i [v]iew markdown preview to the side
    keymap('n', '<leader>uv', function()
        if vim.bo.filetype == "markdown" then
            vscode.call('markdown.showPreviewToSide')
        end
    end, {
        desc = 'Markdown: Show preview to side'
    })

    -- [u]i [V]iew (BIGGER) markdown preview
    keymap('n', '<leader>uV', function()
        if vim.bo.filetype == "markdown" then
            vscode.call('markdown.showPreview')
        end
    end, {
        desc = 'Markdown: Show preview'
    })

    --
    -- SEARCH CONFIGURATION
    --
    --
    keymap('n', '<leader>sk', function()
        vscode.call('workbench.action.openGlobalKeybindings')
    end, {
        desc = 'Open Global Keybindings'
    })

    keymap('n', '<leader>sK', function()
        vscode.call('workbench.action.openDefaultKeybindingsFile')
    end, {
        desc = 'Open Default Global Keybindings (JSON)'
    })

    --
    -- BUFFER/WORKBENCH/WINDOWS CONFIGURATION
    --

    keymap('n', '<leader>wo', function()
        vscode.call('workbench.action.closeOtherEditors')
    end, {
        desc = 'Close other editors'
    })

    keymap('n', '<leader>wd', function()
        vscode.call('workbench.action.closeActiveEditor')
        vscode.call('workbench.action.focusFirstEditorGroup')
    end, {
        desc = 'Delete current buffer/window'
    })

    keymap('n', '<leader>,', function()
        vscode.call('workbench.action.showAllEditorsByMostRecentlyUsed')
    end, {
        desc = 'Show all editors by MRU'
    })

    keymap('n', '<leader>wv', function()
        vscode.call('workbench.action.splitEditorRight')
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Vertical split right, stay focused'
    })

    keymap('n', '<leader>wV', function()
        vscode.call('workbench.action.splitEditorRight')
    end, {
        desc = 'Vertical split right, move focus'
    })
    keymap('n', '<leader>ws', function()
        vscode.call('workbench.action.splitEditorDown')
        vscode.call('workbench.action.focusAboveGroup')
    end, {
        desc = 'Split down, stay focused'
    })
    keymap('n', '<leader>wS', function()
        vscode.call('workbench.action.splitEditorDown')
    end, {
        desc = 'Split down, move focus'
    })
    keymap('n', '<leader>wm', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
    end, {
        desc = 'Maximize active editor'
    })

    -- Use arrow keys to move between editor groups (splits)
    keymap('n', '<Up>', function()
        vscode.call('workbench.action.focusAboveGroup')
    end, {
        desc = 'Move to split above'
    })
    keymap('n', '<Down>', function()
        vscode.call('workbench.action.focusBelowGroup')
    end, {
        desc = 'Move to split below'
    })
    keymap('n', '<Left>', function()
        vscode.call('workbench.action.focusLeftGroup')
    end, {
        desc = 'Move to split left'
    })
    keymap('n', '<Right>', function()
        vscode.call('workbench.action.focusRightGroup')
    end, {
        desc = 'Move to split right'
    })

    --
    -- BOOKMARKS PLUGINS CONFIGURATION
    --
    keymap('n', 'mm', function()
        vscode.call('bookmarks.toggle')
    end, {
        desc = 'Toggle bookmark'
    })
    keymap('n', 'mf', function()
        vscode.call('bookmarks.jumpToNext')
    end, {
        desc = 'Jump to next bookmark'
    })
    keymap('n', 'mF', function()
        vscode.call('bookmarks.jumpToPrevious')
    end, {
        desc = 'Jump to previous bookmark'
    })
    keymap('n', 'ml', function()
        vscode.call('bookmarks.listFromAllFiles')
    end, {
        desc = 'List bookmarks from all files'
    })
    keymap('n', 'mc', function()
        vscode.call('bookmarks.clearFromAllFiles')
    end, {
        desc = 'Clear all bookmarks'
    })

    --
    -- HARPOON CONFIGURATION
    --

    keymap('n', '<leader>h1', function()
        vscode.call('extension.multiCommand.maximizeAndFocusFirstEditorGroup')
        vscode.call('vscode-harpoon.gotoEditor1')
        vscode.call('workbench.action.closeOtherEditors')
    end, {
        desc = 'Maximize, go to Harpoon 1, close others'
    })

    keymap('n', '<leader>h2', function()
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
    keymap('n', '<leader>h3', function()
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
    keymap('n', '<leader>h4', function()
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

    keymap('v', '<leader>gr', function()
        vscode.call('git.revertSelectedRanges')
    end, {
        desc = 'Git: Revert selected ranges'
    })

    keymap('v', '<leader>gs', function()
        vscode.call('git.stageSelectedRanges')
    end, {
        desc = 'Git: Stage selected ranges'
    })

    keymap('v', '<leader>gu', function()
        vscode.call('git.unstageSelectedRanges')
    end, {
        desc = 'Git: Unstage selected ranges'
    })

    -- [g]it [o] open change
    keymap('n', '<leader>go', function()
        vscode.call('git.openChange')
        vscode.call('workbench.action.focusFirstEditorGroup')
    end, {
        desc = 'Git: Open change and focus first editor group'
    })

    -- [g]it [O] open all changes
    keymap('n', '<leader>gO', function()
        vscode.call('git.viewChanges')
    end, {
        desc = 'Git: View all changes'
    })

    -- [g]it view [S]tage changes
    keymap('n', '<leader>gS', function()
        vscode.call('git.viewStagedChanges')
        vscode.call('workbench.action.focusFirstEditorGroup')
    end, {
        desc = 'Git: View staged changes and focus first editor group'
    })

    -- gitlens: [g]it [b]lame
    keymap('n', '<leader>gb', function()
        vscode.call('gitlens.toggleLineBlame')
    end, {
        desc = 'GitLens: Toggle line blame'
    })

    -- gitlens: [g]it file [B]lame
    keymap('n', '<leader>gB', function()
        vscode.call('gitlens.toggleFileBlame')
    end, {
        desc = 'GitLens: Toggle file blame'
    })

    --
    -- vsnetrw
    --

    -- Open vsnetrw with "-" (like netrw in Vim)
    -- https://marketplace.visualstudio.com/items?itemName=danprince.vsnetrw
    keymap('n', '-', function()
        if vim.bo.filetype ~= "vsnetrw" then
            vscode.call('vsnetrw.open')
        end
    end, {
        desc = 'Open vsnetrw'
    })

    --
    -- GO LANG CONFIGURATION
    --
    keymap('n', '<leader><leader>gc', function()
        if vim.bo.filetype == "go" then
            vscode.notify('Running Go package coverage...')
            vscode_async('go.test.coverage')
        end
    end, {
        desc = 'Go: Run package coverage'
    })

    keymap('n', '<leader><leader>gf', function()
        if vim.bo.filetype == "go" then
            vscode.call('go.toggle.test.file')
        end
    end, {
        desc = 'Go: Toggle test file'
    })

end

return M
