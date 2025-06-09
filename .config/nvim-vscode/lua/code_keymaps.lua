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

-- Use Space to open Which Key
keymap({'n', 'v'}, '<Space>', function()
    vscode.call('whichkey.show')
end, opts)

-- Fix % in visual mode to keep the cursor centered, only happens with vscode-neovim
keymap('v', '%', '%zz', opts)

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

keymap('n', 's', function()
    -- do nothing
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
-- Map 'm' as a WhichKey prefix using whichkey.triggerKey
keymap('n', 'm', function()
    vscode.call('whichkey.show')
    vscode.call('whichkey.triggerKey', {
        args = {'m'}
    })
end, {
    desc = 'WhichKey: bookmarks'
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
