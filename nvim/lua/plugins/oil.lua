return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup()
	end,
	keys = {
		{ "-", "<cmd>Oil<cr>", desc = "Open oil", mode = "n" },
	},
}
