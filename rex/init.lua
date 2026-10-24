local utils = require("utils")
require("smart-splits")

rex.bind("ctrl+a>ctrl+a", "pane.send_key", { key = "ctrl+a" })

-- Sessions
rex.bind("cmd+k", "session.switch")
rex.bind("cmd+[", "session.previous")
rex.bind("cmd+]", "session.next")
rex.bind("ctrl+shift+,", "session.rename")
rex.bind("ctrl+a>x", "session.close")

-- Tabs
rex.bind("cmd+t", "client.tab.new")
rex.bind("ctrl+,", "client.tab.rename")
rex.bind("cmd+shift+[", "client.tab.previous")
rex.bind("cmd+shift+]", "client.tab.next")
rex.bind("cmd+shift+ctrl+[", "client.tab.move.backward")
rex.bind("cmd+shift+ctrl+]", "client.tab.move.forward")
for i = 1, 9 do
	rex.bind("ctrl+" .. i, "client.tab.goto", { index = i })
end

-- Panes
rex.bind("cmd+e", "pane.split", { direction = "down" })
rex.bind("cmd+shift+e", "pane.split", { direction = "right" })
rex.bind("ctrl+m", "pane.zoom")

rex.bind("cmd+;", "client.palette.toggle")

rex.action({
	name = "lazygit_pane",
	title = "Open Lazygit",
	run = function(ctx)
		utils.open_zoomed(ctx, { "lazygit" })
	end,
})
rex.bind("ctrl+a>ctrl+g", "lazygit_pane")
