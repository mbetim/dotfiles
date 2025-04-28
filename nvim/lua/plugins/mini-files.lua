return {
	"echasnovski/mini.files",
	opts = {
		mappings = {
			close = "q",
			-- Use this if you want to open several files
			go_in = "l",
			-- This opens the file, but quits out of mini.files (default L)
			go_in_plus = "<CR>",
			-- go_out: shows you all the items to the right
			go_out = "H",
			-- go_out_plus: when you go out, it shows you only 1 item to the right
			go_out_plus = "h",
			-- Default <BS>
			-- reset = ",",
			-- Default @
			reveal_cwd = ".",
			show_help = "g?",
			-- Default =
			synchronize = "s",
			trim_left = "<",
			trim_right = ">",
		},
		windows = {
			width_focus = 40,
			width_preview = 60,
		},
	},
	options = {
		-- Whether to use for editing directories
		-- Disabled by default in LazyVim because neo-tree is used for that
		use_as_default_explorer = true,
	},
	keys = {
		{
			"<leader>e",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (Directory of Current File)",
		},
		{
			"-",
			function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
			end,
			desc = "Open mini.files (Directory of Current File)",
		},
		{
			"<leader>E",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
			desc = "Open mini.files (cwd)",
		},
	},
}
