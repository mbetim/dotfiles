local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	color_scheme = "tokyonight",
	enable_tab_bar = false,
	font_size = 13,

	font = wezterm.font_with_fallback({
		{
			family = "Fira Code",
			harfbuzz_features = { "zero", "ss01", "cv05" },
		},
	}),
	-- harfbuzz_features = { "zero", "clig", "calt", "liga" },

	macos_window_background_blur = 30,

	set_environment_variables = {
		TERM = "xterm-256color",
		LC_ALL = "en_US.UTF-8",
	},
	native_macos_fullscreen_mode = false,

	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",

	keys = {
		{
			-- Open sessionx
			key = "k",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "o" }),
			}),
		},
		{
			-- Switch to previous session
			key = "l",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "L" }),
			}),
		},
		{
			-- Find the urls on the pane
			key = "u",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "u" }),
			}),
		},
		{
			-- Create a new tmux window
			key = "t",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "c" }),
			}),
		},
		{
			-- Split the pane horizontally
			key = "e",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "-" }),
			}),
		},
		{
			-- Split the pane vertically
			key = "E",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "|" }),
			}),
		},
		{
			-- Maximize the pane
			key = "m",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "m" }),
			}),
		},
		{
			-- Maximize the pane
			key = "m",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "m" }),
			}),
		},
		{
			-- Rename current window
			key = ",",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "," }),
			}),
		},
		{
			-- Enter command mode
			key = ";",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = ":" }),
			}),
		},
		{
			-- Next window
			key = "]",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "n" }),
			}),
		},
		{
			-- Previous window
			key = "[",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "p" }),
			}),
		},
		{
			-- Selection mode in tmux
			key = "o",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "[" }),
			}),
		},
		{
			-- Close tmux pane
			key = "w",
			mods = "CMD",
			action = act.Multiple({
				act.SendKey({ mods = "CTRL", key = "a" }),
				act.SendKey({ key = "x" }),
			}),
		},
		{
			-- Close wezterm
			key = "w",
			mods = "CMD|SHIFT",
			action = act.CloseCurrentPane({ confirm = true }),
		},
	},
}

-- Tmux keybindings to navigate to the pane with CMD + number
for i = 0, 9 do
	config.keys[#config.keys + 1] = {
		key = tostring(i),
		mods = "CMD",
		action = act.Multiple({
			act.SendKey({ mods = "CTRL", key = "a" }),
			act.SendKey({ key = tostring(i) }),
		}),
	}
end

return config
