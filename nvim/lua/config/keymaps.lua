-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of the line" })
vim.keymap.set("n", "vv", "v$", { desc = "Select to the end of the line" })

-- Keep cursor in the middle of the screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Buffer navigation
vim.keymap.set("n", "<leader><cr>", function()
	local Snacks = require("snacks")
	Snacks.picker.buffers()
end, { desc = "Open telescope buffers" })

-- Switch back to the previous buffer
vim.keymap.set("n", "<leader>j", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- use gh to move to the beginning of the line
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Go to the beginning of the line" })
-- use gl to move to the end of the line
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })

-- Restart LSP
vim.keymap.set("n", "<leader>cL", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- Delete current file
vim.keymap.set("n", "<leader>fd", function()
	local current_file = vim.fn.expand("%:p")
	if current_file and current_file ~= "" then
		if vim.fn.executable("trash") == 0 then
			vim.api.nvim_echo({
				{ "- Trash utility is not installed", "ErrorMsg" },
			}, false, {})
			return
		end

		vim.ui.input({
			prompt = "Delete file '" .. current_file .. "'? (y/n)",
		}, function(input)
			if string.lower(input) == "y" then
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

-- Copy current full file path to the clipboard
vim.keymap.set("n", "<leader>fp", function()
	local filepath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filepath)
	print("File path copied to clipboard: " .. filepath)
end, { desc = "Copy full file path to clipboard" })

-- Copy current relative file path to the clipboard
vim.keymap.set("n", "<leader>fP", function()
	local filepath = vim.fn.expand("%:.")
	vim.fn.setreg("+", filepath)
	print("Relative file path copied to clipboard: " .. filepath)
end, { desc = "Copy relative file path to clipboard" })

-- Open current file in Finder
vim.keymap.set("n", "<leader>fO", function()
	local file_path = vim.fn.expand("%:p")
	if file_path ~= "" then
		local command = "open -R " .. vim.fn.shellescape(file_path)
		vim.fn.system(command)
		print("Opened file in Finder: " .. file_path)
	else
		print("No file to open")
	end
end, { desc = "Open current file in Finder" })

-- Copy to system clipboard regardless of the file type
vim.keymap.set("v", "<leader>Y", '"+y')

-- Copy markdown content without line length rule
vim.keymap.set("v", "<leader>y", function()
	-- Check if the current buffer's filetype is markdown
	if vim.bo.filetype ~= "markdown" then
		-- Not a Markdown file, copy the selection to the system clipboard
		vim.cmd('normal! "+y')
		-- -- Optionally, notify the user
		-- vim.notify("Yanked to system clipboard", vim.log.levels.INFO)
		return
	end

	-- Yank the selected text into register 'z' without affecting the unnamed register
	vim.cmd('silent! normal! "zy')
	-- Get the yanked text from register 'z'
	local text = vim.fn.getreg("z")
	-- Path to a temporary file (uses a unique temporary file name)
	local temp_file = vim.fn.tempname() .. ".md"
	-- Write the selected text to the temporary file
	local file = io.open(temp_file, "w")
	if file == nil then
		vim.notify("Error: Cannot write to temporary file.", vim.log.levels.ERROR)
		return
	end

	file:write(text)
	file:close()

	-- Run Prettier on the temporary file to format it
	local cmd = 'prettier --prose-wrap never --write "' .. temp_file .. '"'
	local result = os.execute(cmd)

	if result ~= 0 then
		vim.notify("Error: Prettier formatting failed.", vim.log.levels.ERROR)
		os.remove(temp_file)
		return
	end

	-- Read the formatted text from the temporary file
	file = io.open(temp_file, "r")
	if file == nil then
		vim.notify("Error: Cannot read from temporary file.", vim.log.levels.ERROR)
		os.remove(temp_file)
		return
	end

	local formatted_text = file:read("*all")
	file:close()

	-- Copy the formatted text to the system clipboard
	vim.fn.setreg("+", formatted_text)
	-- Delete the temporary file
	os.remove(temp_file)
end, { desc = "Copy markdown content" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "dbui" },
	callback = function()
		if vim.fn.mapcheck("<leader>e") ~= "" then
			vim.keymap.del("n", "<leader>e")
		end

		vim.keymap.set("n", "<leader>e", "<cmd>DBUIToggle<cr>", { buffer = true, desc = "Toggle DBUI" })
	end,
})
