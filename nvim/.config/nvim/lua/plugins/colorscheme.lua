return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon", -- storm, moon, night, and day.
    },
  },
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "", -- hard, soft, or empty string
      })
      vim.o.background = "light"
    end,
  },
  {
    "catppuccin/nvim",
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
    },
  },

  {
    "rebelot/kanagawa.nvim",
    opts = {
      theme = "dragon", -- wave, dragon, lotus
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
