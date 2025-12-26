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

      -- Custom high-contrast diff highlights (especially DiffText)
      on_highlights = function(hl, c)
        -- DiffText: The most important - shows exact changed characters
        -- Bold + underline + high contrast background for maximum visibility
        hl.DiffText = {
          bg = c.blue, -- Bright blue background
          fg = c.bg_dark, -- Dark foreground for contrast
          bold = true,
          underline = true,
        }

        -- DiffAdd: Added lines (green, medium contrast)
        hl.DiffAdd = {
          bg = c.green1,
          fg = c.bg_dark,
        }

        -- DiffDelete: Deleted lines (red, medium contrast)
        hl.DiffDelete = {
          bg = c.red1,
          fg = c.bg_dark,
        }

        -- DiffChange: Changed lines (orange/yellow, subtle)
        hl.DiffChange = {
          bg = c.yellow,
          fg = c.bg_dark,
        }

        -- GitSigns: Match the diff colors for consistency
        hl.GitSignsAdd = { fg = c.green1 }
        hl.GitSignsChange = { fg = c.yellow }
        hl.GitSignsDelete = { fg = c.red1 }
      end,
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
      vim.o.background = "light"
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
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
    },
  },

  -- Kanagawa - Inspired by "The Great Wave off Kanagawa" painting
  -- Variants:
  --   wave (default): Blue-green tones, balanced and warm
  --   dragon: Deeper contrast, late-night coding sessions
  --   lotus: Light variant, serene and elegant
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
