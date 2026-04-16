local wezterm = require("wezterm")
local act = wezterm.action

-- Plugins
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")

-- Open GitHub for current pane's working directory
local function open_github()
	return wezterm.action_callback(function(win, pane)
		local cwd_uri = pane:get_current_working_dir()
		if not cwd_uri then
			return
		end
		local cwd = cwd_uri.file_path
		local success, stdout = wezterm.run_child_process({ "git", "-C", cwd, "remote", "get-url", "origin" })
		if not success then
			return
		end
		local url = stdout:gsub("%s+$", "")
		if url:find("github.com") then
			if url:match("^git@") then
				url = url:gsub("^git@", "")
				url = url:gsub(":", "/", 1)
				url = "https://" .. url
			end
			url = url:gsub("%.git$", "")
			wezterm.run_child_process({ "open", url })
		end
	end)
end

-- Configs
local config = wezterm.config_builder()

-- General
config.front_end = "OpenGL"
config.max_fps = 120
config.audible_bell = "Disabled"
config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"
config.native_macos_fullscreen_mode = false

-- Use left option for accents (right option as Alt)
config.send_composed_key_when_left_alt_is_pressed = true

-- Font
config.font_size = 12
config.line_height = 1.2
config.font = wezterm.font_with_fallback({
	"Fira Code",
	{ family = "Symbols Nerd Font Mono" },
})

config.color_scheme = "tokyonight_night"

-- Set PATH for homebrew installed tools
config.set_environment_variables = {
	PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
}

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false

config.colors = {
	tab_bar = {
		background = "#16161e",
		active_tab = {
			bg_color = "#3b4261",
			fg_color = "#7aa2f7",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#16161e",
			fg_color = "#a9b1d6",
		},
		inactive_tab_hover = {
			bg_color = "#3b4261",
			fg_color = "#7aa2f7",
		},
	},
}

-- Window styling (dim inactive panes like tmux)
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.6,
}

-- Default workspace
config.default_workspace = "~"

-- Mouse bindings (needed because disable_default_key_bindings disables these too)
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.Nop,
	},
}

-- Tab bar: show workspace name + tab index:title (like tmux status line)
wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	local title = tab.tab_title
	if not title or #title == 0 then
		title = tab.active_pane.title
	end
	local index = tab.tab_index + 1
	local zoomed = ""
	for _, p in ipairs(tab.panes) do
		if p.is_zoomed then
			zoomed = " "
			break
		end
	end
	return " " .. index .. ":" .. title .. zoomed .. " "
end)

wezterm.on("update-right-status", function(window, pane)
	local workspace = window:active_workspace()
	window:set_left_status(wezterm.format({
		{ Background = { Color = "#7aa2f7" } },
		{ Foreground = { Color = "#15161e" } },
		{ Attribute = { Intensity = "Bold" } },
		{ Text = " " .. workspace .. " " },
		{ Background = { Color = "#16161e" } },
		{ Foreground = { Color = "#7aa2f7" } },
		{ Text = "" },
	}))
end)

-- Keybindings
config.disable_default_key_bindings = true

config.leader = { key = "a", mods = "CTRL" }
config.keys = {
	-- Default essentials
	{ key = "q", mods = "CMD", action = act.QuitApplication },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "+", mods = "CMD|SHIFT", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },

	-- Shell editing
	{ key = "Backspace", mods = "CMD", action = act.SendString("\x15") }, -- delete line
	{ key = "Backspace", mods = "ALT", action = act.SendString("\x17") }, -- delete word

	-- Splits
	{ key = "e", mods = "CMD", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "E", mods = "CMD|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Tabs
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "W", mods = "CMD|SHIFT", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "[", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "{", mods = "CMD|SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "CMD|SHIFT|CTRL", action = act.MoveTabRelative(1) },

	-- Pane zoom
	{ key = "m", mods = "CTRL", action = act.TogglePaneZoomState },

	-- Pane swap/move (select pane UI)
	{ key = "s", mods = "LEADER|CTRL", action = act.PaneSelect({ mode = "SwapWithActive" }) },

	-- Rename tab
	{
		key = ",",
		mods = "CTRL",
		action = act.PromptInputLine({
			description = "Enter new tab title",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- Rename workspace
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new workspace name",
			action = wezterm.action_callback(function(window, pane, line)
				if line and #line > 0 then
					wezterm.mux.rename_workspace(window:active_workspace(), line)
				end
			end),
		}),
	},

	-- Copy/selection mode
	{ key = "o", mods = "CMD", action = act.ActivateCopyMode },

	-- Command palette (replaces tmux command mode)
	{ key = "p", mods = "CMD|SHIFT", action = act.ActivateCommandPalette },

	-- Last tab toggle
	{ key = "j", mods = "CMD", action = act.ActivateLastTab },
	{ key = "Tab", mods = "CTRL", action = act.ActivateLastTab },

	-- Quick select finder
	{
		key = "p",
		mods = "CMD",
		action = act.QuickSelectArgs,
	},

	-- URL finder
	{
		key = "u",
		mods = "CMD",
		action = act.QuickSelectArgs({
			label = "open url",
			patterns = { "https?://\\S+" },
			action = wezterm.action_callback(function(window, pane)
				local url = window:get_selection_text_for_pane(pane)
				if url then
					wezterm.run_child_process({ "open", url })
				end
			end),
		}),
	},

	{
		key = "x",
		mods = "CMD|SHIFT",
		action = wezterm.action.ToggleAlwaysOnTop,
	},
	-- Open GitHub
	{ key = "g", mods = "LEADER", action = open_github() },

	-- Session/workspace management
	{ key = "k", mods = "CMD", action = workspace_switcher.switch_workspace() },
	{ key = "l", mods = "CMD", action = workspace_switcher.switch_to_prev_workspace() },

	-- Quick-jump workspaces
	{
		key = "h",
		mods = "LEADER|CTRL",
		action = act.SwitchToWorkspace({ name = "dotfiles", spawn = { cwd = wezterm.home_dir .. "/dev/dotfiles" } }),
	},
	{
		key = "j",
		mods = "LEADER|CTRL",
		action = act.SwitchToWorkspace({
			name = "medifeed",
			spawn = { cwd = wezterm.home_dir .. "/dev/mvst/medifeed" },
		}),
	},
	{
		key = "k",
		mods = "LEADER|CTRL",
		action = act.SwitchToWorkspace({ name = "ecrf", spawn = { cwd = wezterm.home_dir .. "/dev/ecrf" } }),
	},
	{
		key = "o",
		mods = "LEADER|CTRL",
		action = act.SwitchToWorkspace({ name = "notes", spawn = { cwd = wezterm.home_dir .. "/dev/notes" } }),
	},
	{
		key = "d",
		mods = "LEADER|CTRL",
		action = act.SwitchToWorkspace({ name = "files", spawn = { cwd = wezterm.home_dir .. "/dev/files" } }),
	},
	{
		key = "t",
		mods = "LEADER|CTRL",
		action = act.SwitchToWorkspace({ name = "temp", spawn = { cwd = wezterm.home_dir .. "/dev/temp" } }),
	},

	-- Lazygit popup (opens in new tab, auto-closes on exit)
	{
		key = "g",
		mods = "LEADER|CTRL",
		action = act.SpawnCommandInNewTab({
			args = { "lazygit" },
			domain = "CurrentPaneDomain",
		}),
	},

	-- Node REPL popup
	{
		key = "n",
		mods = "LEADER",
		action = act.SpawnCommandInNewTab({
			args = { "node" },
			domain = "CurrentPaneDomain",
		}),
	},

	-- Pane resizing
	{ key = "h", mods = "CMD|CTRL", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "j", mods = "CMD|CTRL", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "k", mods = "CMD|CTRL", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "l", mods = "CMD|CTRL", action = act.AdjustPaneSize({ "Right", 5 }) },
}

-- Tab number switching: Ctrl+1-9
for i = 1, 9 do
	config.keys[#config.keys + 1] = {
		key = tostring(i),
		mods = "CTRL",
		action = act.ActivateTab(i - 1),
	}
end

-- Plugins setup
-- workspace_switcher
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

smart_splits.apply_to_config(config)

-- Copy mode: customize ESC (clear selection) and Enter (exit copy mode)
if wezterm.gui then
	local copy_mode = wezterm.gui.default_key_tables().copy_mode
	-- Remove default ESC and Enter bindings
	for i = #copy_mode, 1, -1 do
		local k = copy_mode[i]
		if (k.key == "Escape" or k.key == "Enter") and (k.mods == "NONE" or not k.mods) then
			table.remove(copy_mode, i)
		end
	end
	-- ESC: clear visual selection, stay in copy mode
	table.insert(copy_mode, { key = "Escape", mods = "NONE", action = act.CopyMode("ClearSelectionMode") })
	-- Enter: scroll to bottom and exit copy mode
	table.insert(copy_mode, {
		key = "Enter",
		mods = "NONE",
		action = act.Multiple({
			act.ScrollToBottom,
			act.CopyMode("Close"),
		}),
	})
	config.key_tables = { copy_mode = copy_mode }
end

return config
