return {
	"neovim/nvim-lspconfig",
	opts = {
		inlay_hints = {
			enabled = false,
		},
	},
	init = function()
		local keys = require("lazyvim.plugins.lsp.keymaps").get()
		-- Disable the "Signature help" keymap
		keys[#keys + 1] = { "<c-k>", false, mode = "i" }
	end,
}
