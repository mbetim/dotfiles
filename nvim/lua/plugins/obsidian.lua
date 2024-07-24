return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/dev/obsidian/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/dev/obsidian/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/dev/obsidian/flat",
			},
		},

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "journal/daily",
		},

		completion = {
			nvim_cmp = true,
		},

		templates = {
			folder = "templates",
			subdir = "templates",
		},

		new_notes_location = "",
		default_template = "templates/default.md",

		note_id_func = function(title)
			local suffix = ""
			if title ~= nil then
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end

			return tostring(os.time()) .. "-" .. suffix
		end,

		ui = {
			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
			},
		},
		attachments = {
			img_folder = "assets",
		},
	},
	keys = {
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note" },
		{ "<leader>od", "<cmd>ObsidianDailies<CR>", desc = "Search journal notes" },
		{ "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
		{ "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Templates" },
	},
}
