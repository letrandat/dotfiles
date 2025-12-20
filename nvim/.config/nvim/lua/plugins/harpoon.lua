return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local harpoon = require("harpoon")

      return {
        -- Harpoon (A-m to add, A-o to edit menu, A-p for telescope)
        { "<A-m>", function() harpoon:list():add() end, desc = "Harpoon: Add File" },
        { "<A-o>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon: Quick Menu" },

        -- Navigation (j, k, l, ;)
        { "<A-j>", function() harpoon:list():select(1) end, desc = "Harpoon: Select 1" },
        { "<A-k>", function() harpoon:list():select(2) end, desc = "Harpoon: Select 2" },
        { "<A-l>", function() harpoon:list():select(3) end, desc = "Harpoon: Select 3" },
        { "<A-;>", function() harpoon:list():select(4) end, desc = "Harpoon: Select 4" },

        -- Replace Slot (leader h + j/k/l/;)
        { "<leader>hj", function() harpoon:list():replace_at(1) end, desc = "Harpoon: Replace Slot 1" },
        { "<leader>hk", function() harpoon:list():replace_at(2) end, desc = "Harpoon: Replace Slot 2" },
        { "<leader>hl", function() harpoon:list():replace_at(3) end, desc = "Harpoon: Replace Slot 3" },
        { "<leader>h;", function() harpoon:list():replace_at(4) end, desc = "Harpoon: Replace Slot 4" },
      }
    end,
  },
}
