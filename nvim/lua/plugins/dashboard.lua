return {
	"nvimdev/dashboard-nvim",
	opts = {
		config = {
			center = {
				{
					action = "Telescope frecency",
					desc = " Find File",
					icon = " ",
					key = "f",
				},
				{
					action = 'lua LazyVim.pick("oldfiles")()',
					desc = " Recent Files",
					icon = " ",
					key = "r",
				},
				{
					action = "ene | startinsert",
					desc = " New File",
					icon = " ",
					key = "n",
				},
				{
					action = 'lua require("persistence").load()',
					desc = " Restore Session",
					icon = " ",
					key = "s",
				},
				{
					action = "Lazy",
					desc = " Lazy",
					icon = "󰒲 ",
					key = "l",
				},
				{
					action = function()
						vim.api.nvim_input("<cmd>qa<cr>")
					end,
					desc = " Quit",
					icon = " ",
					key = "q",
				},
			},
		},
	},
}
