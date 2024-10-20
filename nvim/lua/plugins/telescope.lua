return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			layout_strategy = "vertical",
			path_display = { "filename_first" },
			mappings = {
				n = {
					["d"] = require("telescope.actions").delete_buffer,
				},
			},
		},
	},
	keys = {
		{ "<leader><space>", "<cmd>Telescope frecency<cr>", desc = "Find files (CWD)" },
		{ "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
	},
}
