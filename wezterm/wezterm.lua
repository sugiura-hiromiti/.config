local wz = require 'wezterm'
local act = wz.action

return {
	--  font
	font_size = 13,
	line_height = 0.85,

	-- key assignments
	disable_default_key_bindings = true,
	keys = {
		{ key = 'LeftArrow', mods = 'CTRL|CMD', action = act.AdjustPaneSize { 'Left', 1 } },
		{ key = 'RightArrow', mods = 'CTRL|CMD', action = act.AdjustPaneSize { 'Right', 1 } },
		{ key = 'UpArrow', mods = 'CTRL|CMD', action = act.AdjustPaneSize { 'Up', 1 } },
		{ key = 'DownArrow', mods = 'CTRL|CMD', action = act.AdjustPaneSize { 'Down', 1 } },
		{ key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
		{ key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false } },
		{ key = '[', mods = 'CMD', action = act.PaneSelect },
		{ key = 'q', mods = 'CMD', action = act.QuitApplication },
		{ key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
		{
			key = 'd',
			mods = 'CMD',
			action = act.SplitHorizontal {},
		},
		{
			key = 'd',
			mods = 'CMD|SHIFT',
			action = act.SplitVertical {},
		},
		{ key = 'f', mods = 'CTRL|CMD', action = act.ToggleFullScreen },
	},
}
