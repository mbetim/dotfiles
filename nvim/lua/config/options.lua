-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- TODO: try to make this use the $HOME path and fetch the latest lts version automatically
local node_bin = "/Users/matheus.betim/.nvm/versions/node/v20.10.0/bin"
vim.g.node_host_prog = node_bin .. "/node"
vim.cmd("let $PATH = '" .. node_bin .. ":' . $PATH")

vim.opt.clipboard = nil

vim.opt.spelllang = "en_us"
vim.opt.spell = true
