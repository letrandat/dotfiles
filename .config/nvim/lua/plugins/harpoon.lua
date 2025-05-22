return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("harpoon"):setup()
    end,
    keys = {
        -- Add your desired keybindings here
        -- For example:
        { "<leader>a", function() require("harpoon.mark").add() end, desc = "Harpoon: Add file" },
        { "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: Toggle Quick Menu" },
        { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon: Go to file 1" },
        { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon: Go to file 2" },
        { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon: Go to file 3" },
        { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon: Go to file 4" },
    },
}
