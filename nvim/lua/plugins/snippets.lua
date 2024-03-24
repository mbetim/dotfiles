return {
	{
		"rafamadriz/friendly-snippets",
		opts = {
			require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/snippets" } }),
		},
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			local ls = require("luasnip")

			return {
				{
					"<c-j>",
					function()
						if ls.expand_or_jumpable() then
							ls.expand_or_jump()
						end
					end,
					-- expr = true,
					silent = true,
					mode = { "i", "s" },
				},
				{
					"<c-k>",
					function()
						if ls.jumpable(-1) then
							ls.jump(-1)
						end
					end,
					desc = "Jump to previous snippet",
					silent = true,
					mode = { "i", "s" },
				},
				{
					"<c-l>",
					function()
						if ls.choice_active() then
							ls.change_choice(1)
						end
					end,
					mode = { "i" },
				},
			}
		end,
	},
}
