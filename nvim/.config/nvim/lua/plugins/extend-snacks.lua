-- Extend Snacks.picker to show hidden files
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = false, -- set to true if you also want gitignored files
        },
      },
    },
  },
}
