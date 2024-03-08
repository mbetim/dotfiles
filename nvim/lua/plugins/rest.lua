return {
	"rest-nvim/rest.nvim",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	ft = "http",
	config = function()
		require("rest-nvim").setup()
	end,
	keys = {
		{
			"<leader>rn",
			function()
				require("rest-nvim").run()
			end,
			desc = "Run request under the cursor",
		},
		{
			"<leader>rl",
			function()
				require("rest-nvim").last()
			end,
			desc = "Run last request",
		},
	},
}
