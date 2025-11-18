--🫠
local wz = require 'wezterm'
local act = wz.action

local function get_appearance()
	if wz.gui then
		return wz.gui.get_appearance()
	end
	return 'Light'
end

local function scheme_for_appearance(appearance)
	if appearance:find 'Light' then
		return 'Catppuccin Latte'
	else
		return 'Catppuccin Mocha'
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

wz.on('opacity', function(window, _)
	local overrides = window:get_config_overrides() or {}
	local hndl = assert(io.open('/tmp/wz_nvim.txt', 'r'), 'could not opened wz_nvim.txt')
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.65
		overrides.text_background_opacity = 0.6
		if wz.gui.get_appearance():find 'Light' then
			overrides.color_scheme = 'Nova (base16)'
			hndl:write 'dark'
		end
	else
		overrides.window_background_opacity = nil
		overrides.text_background_opacity = nil
		if wz.gui.get_appearance():find 'Light' then
			overrides.color_scheme = 'Alabaster'
			hndl:write 'light'
		end
	end
	hndl:close()
	window:set_config_overrides(overrides)
end)

return {
	animation_fps = 60,
	check_for_updates = false,
	cell_width = 0.9,
	color_scheme = scheme_for_appearance(get_appearance()),
	disable_default_key_bindings = true,
	--dpi = 36,
	-- enable_csi_u_key_encoding=false,
	font = wz.font { family = 'PlemolJP Console NF' },
	font_size = 17,
	foreground_text_hsb = { saturation = 1.1, brightness = 1.1 },
	--freetype_load_target = 'HorizontalLcd',
	front_end = 'WebGpu',
	hide_tab_bar_if_only_one_tab = true,
	-- this does not take effects on macOS: ime_preedit_rendering = 'System',
	line_height = 0.95,
	keys = {
		--		{ key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
		--		{ key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
		{ key = 'o', mods = 'CMD', action = act.EmitEvent 'opacity' },
		{ key = 'c', mods = 'SHIFT|CMD', action = act.ActivateCopyMode },
		{ key = '[', mods = 'CMD', action = act.ActivatePaneDirection 'Prev' },
		{ key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
		{ key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
		{ key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
		{ key = 'w', mods = 'CMD', action = act.CloseCurrentPane { confirm = false } },
		{ key = 'b', mods = 'CMD', action = act.EmitEvent 'bg' },
		{ key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },
		{ key = 'q', mods = 'CMD', action = act.QuitApplication },
		{ key = 'r', mods = 'CMD', action = act.ReloadConfiguration },
		{ key = 'f', mods = 'CMD', action = act.Search { CaseSensitiveString = '' } },
		{ key = 't', mods = 'CMD', action = act.SpawnTab 'DefaultDomain' },
		{ key = 'n', mods = 'CMD', action = act.SpawnWindow },
		{
			key = 'd',
			mods = 'CMD|SHIFT',
			action = act.SplitHorizontal {},
		},
		{
			key = 'd',
			mods = 'CMD',
			action = act.SplitVertical {},
		},
		{ key = 'f', mods = 'CTRL|CMD', action = act.ToggleFullScreen },
	},
	key_tables = { copy_mode = cp_mode },
	max_fps = 120,
	--native_macos_fullscreen_mode = false,
	pane_focus_follows_mouse = true,
	prefer_to_spawn_tabs = true,
	scrollback_lines = 400,
	tab_bar_at_bottom = true,
	use_ime = true,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_decorations = 'NONE',
	window_close_confirmation = 'NeverPrompt',
	--mocos_window_background_blur=5,
	--window_background_image='/path/to/img.jpg' png, gif also vaild extensiton
}
