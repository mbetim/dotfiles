-- https://github.com/HakonHarnes/img-clip.nvim

return {
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	opts = {
		-- add options here
		-- or leave it empty to use the default settings
		default = {
			prompt_for_file_name = false, ---@type boolean
			file_name = "%Y-%m-%d-at-%H-%M-%S", ---@type string
			-- extension = "avif", ---@type string
			-- process_cmd = "convert - -quality 75 avif:-", ---@type string

			-- extension = "webp", ---@type string
			-- process_cmd = "convert - -quality 75 webp:-", ---@type string

			-- extension = "png", ---@type string
			-- process_cmd = "convert - -quality 75 png:-", ---@type string

			-- extension = "jpg", ---@type string
			-- process_cmd = "convert - -quality 75 jpg:-", ---@type string
		},

		-- filetype specific options
		filetypes = {
			markdown = {
				-- template = "![$CURSOR]($FILE_PATH)", ---@type string
				--
				-- -- This will just statically type "Image" in the alternative text
				-- template = "![Image]($FILE_PATH)", ---@type string
				template = "![$FILE_NAME]($FILE_PATH)", ---@type string
			},
		},
	},
	keys = {
		{ "<leader>iv", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
	},
}
