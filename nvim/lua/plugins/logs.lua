return {
	"chrisgrieser/nvim-chainsaw",
	event = "VeryLazy",
	opts = {}, -- required even if left empty
	keys = {
		{
			"<leader>ll",
			function()
				require("chainsaw").variableLog()
			end,
			desc = "Log var",
		},
		{
			"<leader>lr",
			function()
				require("chainsaw").removeLogs()
			end,
			desc = "Remove all logs",
		},
	},
}
