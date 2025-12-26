return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- choose from: storm, moon, night, and day.
      style = "moon",
    },
  },
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
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
      colorscheme = "kanagawa",
    },
  },
}
