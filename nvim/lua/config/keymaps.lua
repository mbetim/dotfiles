-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy from vim
vim.keymap.set({ "n", "v" }, "<C-y>", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })

vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })
vim.keymap.set("n", "vv", "v$", { desc = "Select to the end of the line" })

-- Keep cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Resume last telescope window
vim.keymap.set(
	"n",
	"<leader>sx",
	require("telescope.builtin").resume,
	{ desc = "Resume", silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>fD", function()
	local current_file = vim.fn.expand("%:p")
	if current_file and current_file ~= "" then
		if vim.fn.executable("trash") == 0 then
			vim.api.nvim_echo({
				{ "- Trash utility is not installed", "ErrorMsg" },
			}, false, {})
			return
		end

		vim.ui.input({
			prompt = "Type 'yes' to delete the file '" .. current_file .. "': ",
		}, function(input)
			if input == "yes" then
				local success, _ = pcall(function()
					vim.fn.system({ "trash", vim.fn.fnameescape(current_file) })
				end)

				if success then
					vim.api.nvim_echo({
						{ "File delete from disk", "Normal" },
						{ current_file, "Normal" },
					}, false, {})
					vim.cmd("bd!")
				else
					vim.api.nvim_echo({
						{ "Failed to delete file", "ErrorMsg" },
						{ current_file, "ErrorMsg" },
					}, false, {})
				end
			else
				vim.api.nvim_echo({
					{ "File deletion canceled", "Normal" },
				}, false, {})
			end
		end)
	else
		vim.api.nvim_echo({
			{ "No file to delete", "WarningMsg" },
		}, false, {})
	end
end, {
	desc = "Delete file",
})

-- Paste a github link and add it in this format
-- [folke/noice.nvim](https://github.com/folke/noice.nvim){:target="\_blank"}
vim.keymap.set("i", "<C-g>", function()
	-- Insert the text in the desired format
	vim.cmd("normal! a[]()")
	vim.cmd("normal! F(pv2F/lyF[p")
	-- Leave me in normal mode or command mode
	vim.cmd("stopinsert")
end, { desc = "Paste Github link" })
