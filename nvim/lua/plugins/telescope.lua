return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ThePrimeagen/harpoon",
		config = function()
			require("telescope").load_extension("harpoon")
		end,
	},
	keys = {
		{ "<leader>hh", "<cmd>Telescope harpoon marks<cr>", desc = "Show harpoon marks" },
	},
}
