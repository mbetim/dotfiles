return {
	"saghen/blink.cmp",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			accept = {
				auto_brackets = { enabled = false },
			},
		},
		sources = {
			default = { "avante", "lsp", "path", "snippets", "buffer" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
				},
			},
		},
		keymap = {
			preset = "default",
			["<C-j>"] = { "snippet_forward", "fallback" },
			["<C-k>"] = { "snippet_backward", "fallback" },
		},
	},
}
