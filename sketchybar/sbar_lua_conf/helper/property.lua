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
	display = 1,
}

-- ↑ those values are default value(builtin display)

m.default_properties = {
	-- update_freq = 1,
	position = 'right',
	ignore_association = false,
	y_offset = 0,
	padding_left = 7,
	padding_right = 7,
	width = 'dynamic',
	scroll_texts = true,
	blur_radius = 25,
	align = 'center',
	background = {
		drawing = true,
		color = require('sbar_config.helper.color').get_color 'surface0',
		border_color = 0xffffffff,
		border_width = 1,
		height = 40,
		corner_radius = 10,
	},
	icon = {
		font = {
			family = 'MesloLGL Nerd Font',
			style = 'Regular',
			size = 16,
		},
	},
	label = {
		font = {
			family = 'MesloLGL Nerd Font',
			style = 'Regular',
			size = 16,
		},
		padding_left = 10,
		padding_right = 10,
	},
}

m.bar_properties = {
	color = 0x00000000,
	border_color = 0xffffffff,
	height = 56,
	margin = 4,
	y_offset = 4,
	corner_radius = 30,
	border_width = 0,
	blur_radius = 100,
	padding_left = 10,
	padding_right = 10,
	notch_width = 200,
	display = 1,
	sticky = true,
	font_smoothing = true,
	shadow = false,
}

return m
