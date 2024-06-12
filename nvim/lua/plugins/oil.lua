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
	keys = function()
		local cwd = vim.uv.cwd()

		return {
			{ "-", "<cmd>Oil<cr>", desc = "Open oil", mode = "n" },
			{ "<leader>e", "<cmd>Oil " .. cwd .. "<cr>", desc = "Open oil", mode = "n" },
		}
	end,
}
