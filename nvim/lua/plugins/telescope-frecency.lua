return {
	"nvim-telescope/telescope-frecency.nvim",
	config = function()
		require("telescope").setup({
			extensions = {
				frecency = {
					show_scores = true,
					show_filter_column = false,
					default_workspace = "CWD",
					path_display = { "filename_first" },
					db_safe_mode = false,
				},
			},
		})
		require("telescope").load_extension("frecency")
	end,
	keys = {
		{
			"<leader>sv",
			"<cmd>FrecencyValidate!<CR>",
			desc = "Validate Frecency",
		},
	},
}
