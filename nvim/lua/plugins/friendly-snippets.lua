return {
	"rafamadriz/friendly-snippets",
	opts = {
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/lua/snippets" } }),
	},
}
