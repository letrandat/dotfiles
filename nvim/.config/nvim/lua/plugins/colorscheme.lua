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

      -- Custom high-contrast diff highlights for better visibility
      -- Default tokyonight has very subtle diffs that blend with background
      -- These customizations make diffs as visible as gruvbox while keeping tokyonight aesthetic
      on_highlights = function(hl, c)
        -- DiffText: MOST IMPORTANT - highlights exact changed characters within a modified line
        -- Default: Very subtle, hard to spot what actually changed
        -- Custom: Bold + underline + bright background for instant visibility
        -- Use case: When you modify "const x = 1" to "const x = 2", only the "2" is highlighted
        hl.DiffText = {
          bg = c.blue, -- Bright blue background (default uses subtle blue1)
          fg = c.bg_dark, -- Dark foreground for strong contrast (default uses fg)
          bold = true, -- Make it stand out (default: not bold)
          underline = true, -- Extra visual cue (default: no underline)
        }
        -- Adjustment options:
        --   Less intense: c.blue1 or c.blue2 instead of c.blue
        --   Remove underline: delete the underline line
        --   Less bold: set bold = false

        -- DiffAdd: Entire lines that were added (new lines in git diff)
        -- Default: Very faint green tint
        -- Custom: Solid green background for clear visibility
        hl.DiffAdd = {
          bg = c.green1, -- Medium green (default uses dark_green which is too subtle)
          fg = c.bg_dark, -- Dark text on green background (default uses normal fg)
        }

        -- DiffDelete: Entire lines that were deleted (removed lines in git diff)
        -- Default: Very faint red tint
        -- Custom: Solid red background for clear visibility
        hl.DiffDelete = {
          bg = c.red1, -- Medium red (default uses dark_red which is too subtle)
          fg = c.bg_dark, -- Dark text on red background (default uses normal fg)
        }

        -- DiffChange: Entire lines that were modified (but not the exact change)
        -- Default: Very faint yellow/orange tint
        -- Custom: Subtle yellow background - less intense than DiffText
        -- Note: DiffText appears inside DiffChange regions to show exact changes
        hl.DiffChange = {
          bg = c.yellow, -- Yellow background for changed lines (default uses dark_yellow)
          fg = c.bg_dark, -- Dark text on yellow (default uses normal fg)
        }

        -- GitSigns: Gutter indicators (+ - ~) shown by gitsigns.nvim plugin
        -- Default: Uses tokyonight's default git colors (more muted)
        -- Custom: Match the diff colors above for visual consistency
        -- These appear in the left gutter when editing files with git changes
        hl.GitSignsAdd = { fg = c.green1 } -- Green + for added lines
        hl.GitSignsChange = { fg = c.yellow } -- Yellow ~ for changed lines
        hl.GitSignsDelete = { fg = c.red1 } -- Red - for deleted lines
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
