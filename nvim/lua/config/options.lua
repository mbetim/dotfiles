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

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.md" },
	callback = function()
		vim.opt.colorcolumn = "80"
		vim.opt.textwidth = 80
	end,
})

vim.cmd(string.format([[highlight WinBar1 guifg=%s]], "#04d1f9"))
vim.cmd(string.format([[highlight WinBar2 guifg=%s]], "#37f499"))
-- Function to get the full path and replace the home directory with ~
local function get_winbar_path()
	local full_path = vim.fn.expand("%:p")
	return full_path:gsub(vim.fn.expand("$HOME"), "~")
end
-- Function to get the number of open buffers using the :ls command
local function get_buffer_count()
	local buffers = vim.fn.execute("ls")
	local count = 0
	-- Match only lines that represent buffers, typically starting with a number followed by a space
	for line in string.gmatch(buffers, "[^\r\n]+") do
		if string.match(line, "^%s*%d+") then
			count = count + 1
		end
	end
	return count
end
-- Function to update the winbar
local function update_winbar()
	local home_replaced = get_winbar_path()
	local buffer_count = get_buffer_count()
	vim.opt.winbar = "%#WinBar1#%m "
		.. "%#WinBar2#("
		.. buffer_count
		.. ") "
		.. "%#WinBar1#"
		.. home_replaced
		.. "%*%=%#WinBar2#"
		.. vim.fn.systemlist("hostname")[1]
end
-- Autocmd to update the winbar on BufEnter and WinEnter events
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	callback = update_winbar,
})
