return {
	{
		"LazyVim/LazyVim",
		opts = {
			-- colorscheme = "catppuccin",
			colorscheme = "tokyonight-moon",
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
		},
	},
}
