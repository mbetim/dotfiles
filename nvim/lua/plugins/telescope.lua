return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = vim.tbl_deep_extend("force", {
			layout_strategy = "vertical",
			path_display = { "filename_first" },
			mappings = {
				n = {
					["d"] = require("telescope.actions").delete_buffer,
				},
			},
		}, require("telescope.themes").get_ivy()),
	},
	keys = {
		-- { "<leader><space>", "<cmd>Telescope frecency theme=ivy<cr>", desc = "Find files (CWD)" },
		-- { "<leader>fr", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
	},
}
