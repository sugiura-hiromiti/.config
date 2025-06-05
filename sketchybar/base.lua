local palette = require 'helper.color'

SBAR.default {
	update_freq = 1,
	position = 'left',
	ignore_association = false,
	y_offset = 0,
	padding_left = 10,
	padding_right = 10,
	width = 'dynamic',
	scroll_texts = true,
	blur_radius = 25,
	align = 'center',
	background = {
		drawing = true,
		color = palette.get_color 'surface0',
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

SBAR.bar {
	color = 0x00000000,
	border_color = 0xffffffff,
	height = 56,
	margin = 8,
	y_offset = 8,
	corner_radius = 30,
	border_width = 0,
	blur_radius = 100,
	padding_left = 10,
	padding_right = 10,
	notch_width = 200,
	display = 'main',
	sticky = true,
	font_smoothing = true,
	shadow = false,
}
