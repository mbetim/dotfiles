return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Move to the left tmux pane" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", mode = { "n" }, desc = "Move to the bottom tmux pane" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", mode = { "n" }, desc = "Move to the top tmux pane" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", mode = { "n" }, desc = "Move to the right tmux panw" },
	},
}
