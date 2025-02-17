return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		scroll = { enabled = false },
		image = {
			doc = {
				inline = false,
			},
		},
		picker = {
			hidden = true,
			matcher = {
				frecency = true,
			},
			formatters = {
				file = {
					filename_first = true,
				},
			},
			debug = {
				scores = false,
			},
			win = {
				input = {
					keys = {
						["<CR>"] = { "confirm", mode = { "i", "n" } },
						["<C-y>"] = { "confirm", mode = { "i", "n" } },
						["J"] = { "preview_scroll_down", mode = { "n" } },
						["K"] = { "preview_scroll_up", mode = { "n" } },
						["H"] = { "preview_scroll_left", mode = { "n" } },
						["L"] = { "preview_scroll_right", mode = { "n" } },
						["M"] = { "toggle_hidden", mode = { "n" } },
					},
				},
			},
		},
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
				{
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					cwd = true,
					indent = 2,
					padding = 1,
				},
				{ section = "startup" },
			},
		},
	},
	keys = {
		{
			"<leader><space>",
			function()
				require("snacks").picker.files()
			end,
			desc = "Find Files (Root Dir)",
		},
		{
			"<leader>sx",
			function()
				require("snacks").picker.resume()
			end,
			desc = "Resume picker",
		},
	},
}
