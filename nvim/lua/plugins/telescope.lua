return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"ThePrimeagen/harpoon",
		"ThePrimeagen/git-worktree.nvim",
		config = function()
			require("telescope").load_extension("harpoon")
			require("telescope").load_extension("git_worktree")
		end,
	},
	keys = {
		{ "<leader>hh", "<cmd>Telescope harpoon marks<cr>", desc = "Show harpoon marks" },
		{
			"<leader>gta",
			"<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
			desc = "Add git worktree",
		},
		{
			"<leader>gts",
			"<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
			desc = "Show git worktrees",
		},
	},
}
