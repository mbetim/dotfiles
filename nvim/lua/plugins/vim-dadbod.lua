return {
	"tpope/vim-dadbod",
	lazy = true,
	config = function()
		local function db_completion()
			require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
		end

		vim.g.db_ui_save_location = vim.fn.stdpath("config") .. require("plenary.path").path.sep .. "db_ui"

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
			},
			command = [[setlocal omnifunc=vim_dadbod_completion#omni]],
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"sql",
				"mysql",
				"plsql",
			},
			callback = function()
				vim.schedule(db_completion)
			end,
		})
	end,
	cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
	dependencies = {
		{
			"kristijanhusak/vim-dadbod-ui",
			lazy = true,
			init = function()
				vim.g.db_ui_use_nerd_fonts = 1
				vim.g.db_ui_execute_on_save = false
			end,
			keys = function()
				return {
					{
						"<leader>rq",
						":normal vip<CR><PLUG>(DBUI_ExecuteQuery)<CR>",
						desc = "Execute query under cursor",
						mode = "n",
						silent = true,
					},
					{
						"<leader>re",
						"<CMD>DBUIToggle<CR>",
						desc = "Toggle DBUI",
						mode = "n",
						silent = true,
					},
				}
			end,
		},
		{ "kristijanhusak/vim-dadbod-completion", lazy = true },
	},
}
