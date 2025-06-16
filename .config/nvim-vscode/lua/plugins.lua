return {
	{
		"chrisgrieser/nvim-various-textobjs",
		event = "VeryLazy",
		opts = {
			keymaps = {
				useDefaults = true,
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			restricted_keys = {
				["j"] = false,
				["k"] = false,
			},
			disabled_keys = {
				["<Up>"] = false, -- Allow <Up> key
				["<Down>"] = false, -- Allow <Down> key
				["<Left>"] = false, -- Allow <Left> key
				["<Right>"] = false, -- Allow <Right> key
			},
		},
	},
	{
		"chrisgrieser/nvim-spider",
		lazy = true,
	},
}
