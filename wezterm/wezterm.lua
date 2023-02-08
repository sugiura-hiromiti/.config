--🫠
local wz = require 'wezterm'
local act = wz.action

local function theme_selector(app)
	--local time = tonumber(os.date '%H')

	if app:find 'Dark' then
		return 'Nova (base16)'
	else
		return 'Alabaster'
	end
end

local cp_mode
if wz.gui then
	cp_mode = wz.gui.default_key_tables().copy_mode
	local meta_ops = {
		{ key = 'LeftArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Left', 1 } },
		{ key = 'RightArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Right', 1 } },
		{ key = 'UpArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Up', 1 } },
		{ key = 'DownArrow', mods = 'NONE', action = act.AdjustPaneSize { 'Down', 1 } },
	}

	for i = 1, 4 do
		table.insert(cp_mode, meta_ops[i])
	end
end

wz.on('window-config-reloaded', function(window, _)
	window:toast_notification('wezterm', 'reloaded config', nil, 3000)
end)

wz.on('opacity', function(window, _)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.4
		overrides.text_background_opacity = 0.2
	else
		overrides.window_background_opacity = nil
		overrides.text_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

return {
	--meta
	show_update_window = true,
	--  font
	font_size = 13,
	freetype_load_target = 'HorizontalLcd',
	line_height = 0.9,

	-- key assignments
	disable_default_key_bindings = true,
	keys = {
		{ key = 'c', mods = 'SHIFT|CMD', action = act.ActivateCopyMode },
		{ key = '[', mods = 'CMD', action = act.ActivatePaneDirection 'Prev' },
		{ key = ']', mods = 'CMD', action = act.ActivatePaneDirection 'Next' },
		{ key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
		{ key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
		{ key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false } },
		{ key = 'o', mods = 'CMD', action = act.EmitEvent 'opacity' },
		{ key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
		{ key = 'q', mods = 'CMD', action = act.QuitApplication },
		{ key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
		{ key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
		{ key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
		{ key = 't', mods = 'CMD', action = act.SpawnTab 'DefaultDomain' },
		{ key = 'n', mods = 'CMD', action = act.SpawnWindow },
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
	color_scheme = theme_selector(wz.gui.get_appearance()),
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	--window_background_opacity = 0.5,
	--text_background_opacity = 0.5,
	--window_background_image='/path/to/img.jpg' png, gif also vaild extensiton
}
