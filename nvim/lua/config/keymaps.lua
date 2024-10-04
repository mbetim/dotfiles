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

-- Buffer navigation
local telescope_buffer = "<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<cr>"
vim.keymap.set("n", "<S-h>", telescope_buffer, { desc = "Open telescope buffers" })
vim.keymap.set("n", "<S-l>", telescope_buffer, { desc = "Open telescope buffers" })

-- use gh to move to the beginning of the line
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Go to the beginning of the line" })
-- use gl to move to the end of the line
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "Go to the end of the line" })

-- Restart LSP
vim.keymap.set("n", "<leader>cL", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })

-- Delete current file
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

-- Paste a github link and add it in this format
-- [folke/noice.nvim](https://github.com/folke/noice.nvim){:target="\_blank"}
vim.keymap.set("i", "<C-g>", function()
	-- Insert the text in the desired format
	vim.cmd("normal! a[]()")
	vim.cmd("normal! F(pv2F/lyF[p")
	-- Leave me in normal mode or command mode
	vim.cmd("stopinsert")
end, { desc = "Paste Github link" })

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

-- Remove brackets from a checkbox item
vim.keymap.set("n", "<leader>cH", function()
	local target_line = vim.api.nvim_win_get_cursor(0)[1]
	local line_content = vim.api.nvim_buf_get_lines(0, target_line - 1, target_line, false)[1]

	if line_content then
		local new_content = line_content:gsub("%[[ x]%]%s?", "")
		vim.api.nvim_buf_set_lines(0, target_line - 1, target_line, false, { new_content })
	end
end, { desc = "Remove Checkbox Below" })

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

-- Copy markdown content without line length rule
vim.keymap.set("v", "<leader>Y", function()
	local line_start = vim.fn.line("v")
	local line_end = vim.fn.line(".")

	-- Swap the values if the selection started from the bottom up
	if line_start > line_end then
		local temp = line_start
		line_start = line_end
		line_end = temp
	end

	local lines = vim.fn.getline(line_start, line_end)

	local paragraphs = vim.split(table.concat(lines, "\n"), "\n\n")
	local new_paragraphs = {}

	for _, paragraph in ipairs(paragraphs) do
		table.insert(new_paragraphs, paragraph:gsub("\n", " "))
	end

	-- Join paragraphs with double newlines
	local content = table.concat(new_paragraphs, "\n\n")

	-- Copy to clipboard
	vim.fn.setreg("+", content)

	-- Display a message
	vim.api.nvim_echo({ { "Content copied to clipboard with paragraphs preserved!", "Normal" } }, false, {})
end, { desc = "Copy markdown content" })
