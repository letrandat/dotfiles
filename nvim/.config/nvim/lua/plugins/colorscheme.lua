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

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
