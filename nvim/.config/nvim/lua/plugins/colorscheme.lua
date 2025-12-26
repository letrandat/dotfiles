return {
  -- Tokyo Night - Clean, dark theme celebrating Tokyo's downtown lights
  -- Variants:
  --   storm (default): Medium-dark blue (#24283b), balanced contrast
  --   moon: Purple-blue (#222436), unique accent colors
  --   night: Darkest blue (#1a1b26), highest contrast, best for OLED
  --   day: Light variant for daytime use
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm", -- storm, moon, night, day
    },
  },

  -- Gruvbox - Retro groove color scheme with warm, earthy tones
  -- Variants (controlled by vim.o.background):
  --   light: Warm light background, retro aesthetic
  --   dark: Warm dark background with medium contrast
  -- Contrast options: "hard" (more contrast), "soft" (less contrast), "" (default)
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "", -- hard, soft, or empty string
      })
    end,
  },

  -- Catppuccin - Soothing pastel theme with four flavours
  -- Variants:
  --   latte: Light theme, soft pastels
  --   frappe: Medium-dark, balanced pastels
  --   macchiato: Dark with purple tones, warm feel
  --   mocha: Darkest variant, deepest pastels
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        auto_integrations = true,
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
