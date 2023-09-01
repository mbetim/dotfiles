return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local keymap = vim.keymap

		keymap.set(
			"n",
			"<leader>hm",
			"<cmd>lua require('harpoon.mark').add_file()<cr>",
			{ desc = "Mark file with harpoon" }
		)
		keymap.set(
			"n",
			"<leader>hn",
			"<cmd>lua require('harpoon.ui').nav_next()<cr>",
			{ desc = "Go to next harpoon mark" }
		)
		keymap.set(
			"n",
			"<leader>hp",
			"<cmd>lua require('harpoon.ui').nav_prev()<cr>",
			{ desc = "Go to previous harpoon mark" }
		)
		keymap.set(
			"n",
			"<leader>hf",
			"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
			{ desc = "Open harpoon quick menu" }
		)

		for i = 1, 4, 1 do
			keymap.set(
				"n",
				string.format("<leader>%s", i),
				string.format("<cmd>lua require('harpoon.ui').nav_file(%s)<cr>", i),
				{ desc = string.format("Go to harpoon %s", i) }
			)
		end
	end,
}
