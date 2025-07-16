---@param display_index integer
return function(display_index)
	local yabai = require 'sbar_lua_conf.helper.yabai'
	local builtin_display_index = yabai.builtin_display_index()
	local m = {}

	local padding = {
		dflt = 7,
		label = 10,
	}
	local background = {
		height = 40,
	}
	local font = {
		size = 16,
	}

	local bar = {
		height = 56,
		margin = 4,
		y_offset = 4,
		padding = 10,
		notch_width = 200,
		display = builtin_display_index,
		position = 'top',
	}

	if display_index ~= builtin_display_index then
		padding = {
			dflt = 2,
			label = 4,
		}
		background = {
			height = 24,
		}
		font = { size = 10 }
		bar = {
			height = 30,
			margin = 0,
			y_offset = 0,
			padding = 0,
			notch_width = 0,
			display = display_index,
			position = 'bottom',
		}
	end

	-- ↑ those values are default value(builtin display)

	m.default_properties = {
		-- update_freq = 1,
		position = 'right',
		ignore_association = false,
		y_offset = 0,
		padding_left = padding.dflt,
		padding_right = padding.dflt,
		width = 'dynamic',
		scroll_texts = true,
		blur_radius = 25,
		align = 'center',
		background = {
			drawing = true,
			color = require('sbar_config.helper.color').get_color 'surface0',
			border_color = 0xffffffff,
			border_width = 1,
			height = background.height,
			corner_radius = 10,
		},
		icon = {
			font = {
				family = 'MesloLGL Nerd Font',
				style = 'Regular',
				size = font.size,
			},
		},
		label = {
			font = {
				family = 'MesloLGL Nerd Font',
				style = 'Regular',
				size = font.size,
			},
			padding_left = padding.label,
			padding_right = padding.label,
		},
	}

	m.bar_properties = {
		color = 0x00000000,
		border_color = 0xffffffff,
		height = bar.height,
		margin = bar.margin,
		y_offset = bar.y_offset,
		corner_radius = 30,
		border_width = 0,
		blur_radius = 100,
		padding_left = bar.padding,
		padding_right = bar.padding,
		notch_width = bar.notch_width,
		display = bar.display,
		sticky = true,
		font_smoothing = true,
		shadow = false,
		position = bar.position,
	}

	return m
end
