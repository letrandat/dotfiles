return {
  {
    "letrandat/nvim-workspaces",
    config = function()
      require("nvim-workspaces").setup({
        auto_restore = true,
        auto_load_code_workspace = true,
      })
    end,
    cmd = "Workspaces",
    event = "VeryLazy",
  },
}
