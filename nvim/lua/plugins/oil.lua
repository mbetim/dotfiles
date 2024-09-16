return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name, _)
				return name == ".." or name == ".git"
			end,
		},
		win_options = {
			wrap = true,
		},
		keymaps = {
			["q"] = "actions.close",
			["<leader>e"] = "actions.close",
		},
	},
	-- keys = {
	-- 	{ "-", "<cmd>Oil<cr>", desc = "Open oil", mode = "n" },
	-- },
}
