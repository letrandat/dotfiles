return {
  "snacks.nvim",
  opts = function(_, opts)
    -- Add a custom option to the dashboard "Select Session"
    table.insert(
      opts.dashboard.preset.keys,
      7,
      { icon = "S", key = "S", desc = "Select Session", action = require("persistence").select }
    )

    -- Configure explorer to show hidden/ignored files ut exclude some from search
    opts.picker = opts.picker or {}
    opts.picker.hidden = true
    opts.picker.ignored = true
    opts.picker.exclude = { "node_modules", ".git" }
  end,
}
