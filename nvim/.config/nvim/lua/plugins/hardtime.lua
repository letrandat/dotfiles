return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    restricted_keys = {
      ["j"] = false,
      ["k"] = false,
    },
    disabled_keys = {
      ["<Up>"] = false, -- Allow <Up> key
      ["<Down>"] = false, -- Allow <Down> key
      ["<Left>"] = false, -- Allow <Left> key
      ["<Right>"] = false, -- Allow <Right> key
    },
  },
}
