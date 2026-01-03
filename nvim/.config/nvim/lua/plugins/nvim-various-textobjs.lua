return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
  opts = {
    keymaps = {
      useDefaults = true,
    },
  },
  config = function(_, opts)
    require("various-textobjs").setup(opts)

    local keymap = vim.keymap.set
    local keyopts = { silent = true, noremap = true }

    -- ae (select entire buffer) similar to vscodevim
    keymap({ "o", "x" }, "ae", function()
      require("various-textobjs").entireBuffer()
    end, keyopts)

    -- O (go to next closing bracket)
    keymap({ "o", "x" }, "O", function()
      require("various-textobjs").toNextClosingBracket()
    end, keyopts)
  end,
}
