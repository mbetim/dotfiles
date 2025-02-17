-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local home_dir = vim.fn.expand("~")
local node_bin = home_dir .. "/.nvm/versions/node/v20.10.0/bin"
vim.g.node_host_prog = home_dir .. "/.nvm/versions/node/v20.10.0/bin/neovim-node-host"
vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")

vim.opt.clipboard = ""

vim.opt.spelllang = "en,pt_br,es"
vim.opt.spell = true
vim.opt.spelloptions = "camel"

vim.o.termguicolors = true

vim.o.conceallevel = 2

vim.o.scrolloff = 8


vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.opt.colorcolumn = "80"
		vim.opt.textwidth = 80
	end,
})
vim.g.lazyvim_picker = "snacks"
