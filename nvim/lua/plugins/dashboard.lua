return {
	"folke/snacks.nvim",
	opts = {
		scroll = { enabled = false },
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":Telescope frecency" },
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
}
