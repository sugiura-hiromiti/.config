--🫠
local wz = require 'wezterm'
local act = wz.action

local function theme_selector()
	local time = tonumber(os.date '%H')
	if time > 18 or time < 6 then
		return 'OneHalfDark'
	else
		return 'OneHalfLight'
	end
end

local cp_mode
if wz.gui then
	cp_mode = wz.gui.default_key_tables().copy_mode
	local arrow_list = {
		{ key = 'LeftArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Left', 1 } },
		{ key = 'RightArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Right', 1 } },
		{ key = 'UpArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Up', 1 } },
		{ key = 'DownArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Down', 1 } },
	}

	for i = 1, 4 do
		table.insert(cp_mode, arrow_list[i])
	end
end

return {
	--  font
	font_size = 13,
	line_height = 0.9,
	freetype_load_target = 'HorizontalLcd',

	-- key assignments
	disable_default_key_bindings = true,
	keys = {
		{ key = 'c', mods = 'SHIFT|CMD', action = act.ActivateCopyMode },
		{ key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
		{ key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false } },
		{ key = '[', mods = 'CMD', action = act.PaneSelect },
		{ key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
		{ key = 'q', mods = 'CMD', action = act.QuitApplication },
		{ key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
		{ key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
		{ key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
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
	key_tables = { copy_mode = cp_mode },

	--appearance
	color_scheme = theme_selector(),
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	--window_background_opacity = 0.5,
	--text_background_opacity = 0.5,
	--window_background_image='/path/to/img.jpg' png, gif also vaild extensiton
}
