return {
	"andrewferrier/debugprint.nvim",
	opts = {
		keymaps = {
			normal = {
				plain_below = "gpp",
				plain_above = "gpP",
				variable_below = "gpv",
				variable_above = "gpV",
				variable_below_alwaysprompt = "",
				variable_above_alwaysprompt = "",
				surround_plain = "gpsp",
				surround_variable = "gpsv",
				surround_variable_alwaysprompt = "",
				textobj_below = "gpo",
				textobj_above = "gpO",
				textobj_surround = "gpso",
				toggle_comment_debug_prints = "",
				delete_debug_prints = "",
			},
			insert = {
				plain = "",
				variable = "",
			},
			visual = {
				variable_below = "gpv",
				variable_above = "gpV",
			},
		},
	},

	dependencies = {},

	lazy = false, -- Required to make line highlighting work before debugprint is first used
	version = "*", -- Remove if you DON'T want to use the stable version
}
