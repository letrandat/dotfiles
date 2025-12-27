return {
  {
    dir = "~/workspace/nvim-workspaces",
    name = "nvim-workspaces",
    config = function()
      require("nvim-workspaces").setup({
        auto_restore = true,
        auto_load_code_workspace = true,
      })
    end,
    keys = {
      { "<leader>W", group = "workspaces" },
      { "<leader>Wa", "<cmd>Workspaces add<cr>", desc = "Add Workspace Folder" },
      { "<leader>Wr", "<cmd>Workspaces remove<cr>", desc = "Remove Workspace Folder" },
      { "<leader>Wl", "<cmd>Workspaces load<cr>", desc = "Load Workspace" },
      { "<leader>Ws", "<cmd>Workspaces save<cr>", desc = "Save Workspace" },
      { "<leader>WL", "<cmd>Workspaces list<cr>", desc = "List Workspace Folders" },
      { "<leader>Wc", "<cmd>Workspaces clear<cr>", desc = "Clear Workspace" },
      { "<leader>Wd", "<cmd>Workspaces delete<cr>", desc = "Delete Saved Workspace" },
      { "<leader>Wf", "<cmd>Workspaces find<cr>", desc = "Find Files in Workspace" },
    },
  },
}
