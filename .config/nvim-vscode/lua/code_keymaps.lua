local vscode = require("vscode")
local vscode_async = require("vscode").action
local opts = {
	noremap = true,
	silent = true,
}
local keymap = vim.keymap.set

-- the rendering is handle by vscode, so we need this func to simulate zz
local function vscode_zz()
	local curline = vim.fn.line(".")
	vscode.call("revealLine", {
		args = {
			lineNumber = curline,
			at = "center",
		},
	})
end

--
-- CORE CONFIGURATION
--

--
-- Center cursor on ctrl-u and ctrl-d
--
keymap("n", "<c-d>", function()
	local jump_size = math.floor(vim.fn.winheight(0) / 2)
	vim.cmd(":norm! " .. jump_size .. "j")
	vscode_zz()
end, opts)

keymap("n", "<c-u>", function()
	local jump_size = math.floor(vim.fn.winheight(0) / 2)
	vim.cmd(":norm! " .. jump_size .. "k")
	vscode_zz()
end, opts)

--
-- Center cursor on search
--
keymap("n", "*", function()
	vim.cmd(":norm! *")
	vscode_zz()
end, opts)

keymap("n", "n", function()
	vim.cmd(":norm! n")
	vscode_zz()
end, opts)

keymap("n", "N", function()
	vim.cmd(":norm! N")
	vscode_zz()
end, opts)

-- Use Space to open Which Key
keymap({ "n", "v" }, "<Space>", function()
	vscode.call("whichkey.show")
end, opts)

-- Fix % in visual mode to keep the cursor centered, only happens with vscode-neovim
keymap("v", "%", "%zz", opts)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap("n", "<Esc>", function()
	vim.cmd("nohlsearch")
	vscode.call("notifications.clearAll")
end, {
	desc = "Clear highlights and notifications",
})

-- `p` in visual mode delete the selected text to the black hole register (`"_d`), then put (`P`) the contents of the default register
keymap("x", "p", '"_dP', {
	desc = "Paste without yanking replaced text",
})

-- Undo
keymap("n", "u", function()
	vscode.call("undo")
end, {
	desc = "Undo",
})

-- Redo
keymap("n", "<C-r>", function()
	vscode.call("redo")
end, {
	desc = "Redo",
})

keymap("n", "s", function()
	-- do nothing
end, {
	desc = "Redo",
})

--
-- replace with gs
-- Copy word under cursor to clipboard and trigger cmd with search/replace
keymap("n", "gs", function()
	-- Get the word under cursor
	local word = vim.fn.expand("<cword>")
	local replace = "%s/\\<" .. word .. "\\>/" .. word .. "/gI"
	-- Open command line with the replace command
	vim.api.nvim_feedkeys(":" .. replace .. "", "n", false)
end, {
	desc = "Copy word to clipboard and trigger search/replace",
})

--
-- mark current file as executable
-- usually i will map <leader>x to this but since I use whichkey, I will use gx
keymap("n", "gx", "<cmd>!chmod +x %<CR>", { silent = true })

--
-- LINES
--

-- Move lines up and down in normal mode
keymap("n", "<c-k>", ":m .-2<CR>==", {
	desc = "Move line up",
})
keymap("n", "<c-j>", ":m .+1<CR>==", {
	desc = "Move line down",
})

-- Move lines up and down in visual mode (multi-line support)
keymap("v", "<c-k>", ":m '<-2<CR>gv=gv", {
	desc = "Move selected lines up",
})
keymap("v", "<c-j>", ":m '>+1<CR>gv=gv", {
	desc = "Move selected lines down",
})

-- g; (go to next change)
keymap("n", "g;", function()
	vscode.call("workbench.action.editor.nextChange")
	vscode.call("workbench.action.compareEditor.nextChange")
	vscode.call("chatEditor.action.navigateNext")
end, {
	desc = "Go to next change",
})
-- g: (go to previous change)
keymap("n", "g:", function()
	vscode.call("workbench.action.editor.previousChange")
	vscode.call("workbench.action.compareEditor.previousChange")
	vscode.call("chatEditor.action.navigatePrevious")
end, {
	desc = "Go to previous change",
})

-- Move to next and previous editor in group with 'L' and 'H'
keymap("n", "L", function()
	vscode.call("workbench.action.nextEditorInGroup")
end, {
	desc = "Next editor in group",
})
keymap("n", "H", function()
	vscode.call("workbench.action.previousEditorInGroup")
end, {
	desc = "Previous editor in group",
})

--
-- LSP support
--

-- gr (go to references)
keymap("n", "gr", function()
	vscode.call("editor.action.referenceSearch.trigger")
end, {
	desc = "Go to references",
})

-- gD (go to source definition)
keymap("n", "gD", function()
	local lang = vim.bo.filetype
	if string.find(lang, "typescript") ~= nil then
		vscode.call("typescript.goToSourceDefinition")
	else
		vscode.call("editor.action.revealDefinition")
	end
end, {
	desc = "Go to source definition",
})

-- gI (peek Implementation)
keymap("n", "gI", function()
	vscode.call("editor.action.peekImplementation")
end, {
	desc = "Peek implementation",
})

-- gA (go to [A]ll implementations)
keymap("n", "gA", function()
	vscode.call("references-view.findImplementations")
end, {
	desc = "Find all implementations",
})

-- gf (alias for gd)
keymap("n", "gf", "gd", {
	remap = true,
	desc = "Go to definition (alias)",
})

-- gy (go to t[y]pe definition)
keymap("n", "gy", function()
	vscode.call("editor.action.goToTypeDefinition")
end, {
	desc = "Go to type definition",
})

-- gY (peak t[y]pe definition)
keymap("n", "gY", function()
	vscode.call("editor.action.peekTypeDefinition")
end, {
	desc = "Peek type definition",
})

-- gK (go to params hint)
keymap("n", "gK", function()
	vscode.call("editor.action.triggerParameterHints")
end, {
	desc = "Trigger parameter hints",
})

-- gh (go to [H]ierarchy)
-- gh is already used for show hover
keymap("n", "gH", function()
	vscode.call("editor.showCallHierarchy")
end, {
	desc = "Show call hierarchy",
})

-- go to previous [W]arning
keymap("n", "gW", function()
	vscode.call("editor.action.marker.prevInFiles")
end, {
	desc = "Go to previous warning",
})

-- go to next [w]arning
keymap("n", "gw", function()
	vscode.call("editor.action.marker.nextInFiles")
end, {
	desc = "Go to next warning",
})

-- toggle test file
keymap("n", "gt", function()
	local lang = vim.bo.filetype
	if lang == "go" then
		vscode.call("go.toggle.test.file")
	else
		vim.notify(string.format('Toggle test file is not supported for file type "%s"', lang))
	end
end, {
	desc = "Toggle test file",
})

-- toggle test coverage
keymap("n", "gC", function()
	local lang = vim.bo.filetype
	if lang == "go" then
		vim.notify(string.format('Toggle test coverage for "%s"', lang))
		vscode_async("go.test.coverage")
	else
		vim.notify(string.format('Toggle test coverage is not supported for file type "%s"', lang))
	end
end, {
	desc = "Toggle test coverage",
})

-- Use arrow keys to move between editor groups (splits)
keymap("n", "<Up>", function()
	vscode.call("workbench.action.focusAboveGroup")
end, {
	desc = "Move to split above",
})
keymap("n", "<Down>", function()
	vscode.call("workbench.action.focusBelowGroup")
end, {
	desc = "Move to split below",
})
keymap("n", "<Left>", function()
	vscode.call("workbench.action.focusLeftGroup")
end, {
	desc = "Move to split left",
})
keymap("n", "<Right>", function()
	vscode.call("workbench.action.focusRightGroup")
end, {
	desc = "Move to split right",
})

--
-- BOOKMARKS PLUGINS CONFIGURATION
--
-- Map 'm' as a WhichKey prefix using whichkey.triggerKey
keymap({ "n", "v" }, "m", function()
	vscode.call("whichkey.show")
	vscode.call("whichkey.triggerKey", {
		args = { "m" },
	})
end, {
	desc = "WhichKey: bookmarks",
})

--
-- FOLD
--
-- Map 'z' as a WhichKey prefix using whichkey.triggerKey
keymap("n", "z", function()
	vscode.call("whichkey.show")
	vscode.call("whichkey.triggerKey", {
		args = { "z" },
	})
end, {
	desc = "WhichKey: fold",
})

-- For faster access to toggle fold
keymap("n", "za", function()
	vscode.call("editor.toggleFold")
end, {
	desc = "Toggle fold",
})

--
-- vsnetrw
--

-- Open vsnetrw with "-" (like netrw in Vim)
-- https://marketplace.visualstudio.com/items?itemName=danprince.vsnetrw
keymap("n", "\\", function()
	if vim.bo.filetype ~= "vsnetrw" then
		vscode.call("vsnetrw.open")
	end
end, {
	desc = "Open vsnetrw",
})

--
-- debugprint
--
-- reset debug prints counter
keymap("n", "gprc", function()
	vim.cmd("ResetDebugPrintsCounter")
end, {
	desc = "Reset Debug Prints Counter",
})

-- delete debug prints
keymap("n", "gpdd", function()
	vim.cmd("DeleteDebugPrints")
end, {
	desc = "Delete Debug Prints",
})

--
-- search in project
--
keymap({ "n", "v" }, "sg", function()
	hasSelection = vim.fn.mode() == "v" or vim.fn.mode() == "V"
	if hasSelection then
		vscode.call("editor.action.addSelectionToNextFindMatch")
		vscode.call("workbench.action.findInFiles")
		vscode.call("search.action.focusSearchList")
	else
		vscode.call("search.action.clearSearchResults")
		vscode.call("workbench.action.findInFiles")
	end
end, {
	desc = "Search in project",
})
