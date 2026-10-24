local terminal = "com.superlogical.terminal"

local function block_cwd(block_id)
	local proc = rex.block.call(terminal, "process", { block_id = block_id })
	if proc and proc.foreground and proc.foreground.cwd then
		return proc.foreground.cwd
	end
	local pwd = rex.block.call(terminal, "pwd", { block_id = block_id })
	if pwd and pwd.pwd then
		local path = pwd.pwd:gsub("^file://[^/]*", "")
		return (path:gsub("%%(%x%x)", function(h)
			return string.char(tonumber(h, 16))
		end))
	end
end

local M = {
	terminal = terminal,
	open_zoomed = function(ctx, command)
		local split, err = rex.session.new_split({
			anchor_id = ctx.block_id,
			direction = "horizontal",
			side = "after",
			focus = true,
			layout = rex.layout.block({
				flavor = terminal .. ".shell",
				options = { command = command, cwd = block_cwd(ctx.block_id) },
			}),
		})

		if err ~= nil then
			error(err, 0)
		end

		rex.session.zoom_block({ block_id = split.block_ids[1], zoom = true })
	end,
}

return M
