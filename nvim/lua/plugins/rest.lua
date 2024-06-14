return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
			require("telescope").load_extension("rest")
		end,
		keys = {
			{
				"<leader>rn",
				"<cmd>Rest run<cr>",
				desc = "Run request under the cursor",
			},
			{
				"<leader>rl",
				"<cmd>Rest run last<cr>",
				desc = "Run last request",
			},
			{
				"<leader>re",
				"<cmd>Telescope rest select_env<cr>",
				desc = "Select rest.nvim env",
			},
		},
	},
}
