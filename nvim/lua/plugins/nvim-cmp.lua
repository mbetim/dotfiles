local function removeItem(list, item)
	for i = #list, 1, -1 do -- Iterate backwards to avoid skipping items
		if list[i].name == item.name then
			table.remove(list, i) -- Remove the item at index i
			break -- Exit the loop since the item has been found and removed
		end
	end
end

return {
	"hrsh7th/nvim-cmp",
	---@param opts cmp.ConfigSchema
	opts = function(_, opts)
		local cmp = require("cmp")
		local sources = opts.sources
		removeItem(sources, { name = "buffer" })
		opts.sources = cmp.config.sources(sources)
	end,
}
