-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

-- Copy from vim
vim.keymap.set("n", "<C-y>", '"+y')
vim.keymap.set("v", "<C-y>", '"+y')

vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })
vim.keymap.set("n", "vv", "v$", { desc = "Select to the end of the line" })

-- Keep cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Find files (telescope)
vim.keymap.set("n", "<C-p>", Util.telescope("files"), { desc = "Find files", silent = true, noremap = true })

-- Resume last telescope window
vim.keymap.set(
	"n",
	"<leader>sx",
	require("telescope.builtin").resume,
	{ desc = "Resume", silent = true, noremap = true }
)

-- Use TmuxNaivagetor to navigate between tmux panes
vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>")
