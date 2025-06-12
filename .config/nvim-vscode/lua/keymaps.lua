local opts = {
    noremap = true,
    silent = true
}
local keymap = vim.keymap.set
-- ae (select entire buffer) similar to vscodevim
keymap({'o', 'x'}, "ae", function()
    require("various-textobjs").entireBuffer()
end, opts)

-- O (go to next closing bracket)
keymap({'o', 'x'}, "O", function()
    require("various-textobjs").toNextClosingBracket()
end, opts)