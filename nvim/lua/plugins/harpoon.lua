return {
	"ThePrimeagen/harpoon",
	keys = function()
		local keys = {
			{
				"<leader>hm",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Mark file with harpoon",
			},
			{
				"<leader>hf",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
			},
			{ "<leader>h", false },
		}

		for i = 1, 5 do
			table.insert(keys, {
				"<leader>" .. i,
				function()
					require("harpoon"):list():select(i)
				end,
				desc = "Harpoon to File " .. i,
			})
		end

		return keys
	end,
}
