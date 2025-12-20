-- vim-matchup provides linkedEditing-like functionality
-- Extends % motion and provides highlight of matching pairs
return {
  "andymass/vim-matchup",
  event = "VeryLazy",
  config = function()
    vim.g.matchup_matchparen_offscreen = { method = "popup" }
  end,
}
