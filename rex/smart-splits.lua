local utils = require("utils")

-- smart-splits: ctrl+h/j/k/l moves between Rex panes. When nvim is in front the
local function is_vim(ctx)
	local proc = rex.block.call(utils.terminal, "process", { block_id = ctx.block_id })
	local fg = proc and proc.foreground
	if not fg then
		return false
	end
	-- `name` is not always the executable's name, so check `argv0` too
	for _, s in ipairs({ fg.name or "", (fg.argv0 or ""):match("[^/]*$") }) do
		if s:match("^n?vim") then
			return true
		end
	end
	return false
end

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, function(ctx)
		if is_vim(ctx) then
			return false
		end
		rex.session.focus_direction({ direction = direction })
		return true
	end)
end
