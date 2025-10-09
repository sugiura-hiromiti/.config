local m = {}

local padding = {
	dflt = 4,
	label = 10,
}
local background = {
	height = 40,
	corner_radius = 10,
}
local font = {
	size = 16,
}

local bar = {
	position = 'top',
	height = 56,
	sticky = true,
	shadow = false,
	font_smoothing = false,
	show_in_fullscreen = true,
	margin = 0,
	color = 0x00000000,
	y_offset = 5,
	padding_left = 2,
	padding_right = 2,
	display = DISPLAY_INDEX,
	-- blur_radius = 0,
	-- drawing = true,
	-- topmost = true,
	topmost = true,
	-- hidden = false,
	-- border_color = 0x00000000,
	-- border_width = 0,
	-- corner_radius = 0,
	-- clip = 0,
}

if DISPLAY_INDEX ~= require('actor.helper.yabai').display.builtin().index then
	padding = {
		dflt = 0,
		label = 4,
	}
	background = {
		height = 18,
		corner_radius = 5,
	}
	font = { size = 14 }
	bar.position = 'bottom'
	bar.height = 18
	bar.y_offset = 0
	bar.display = DISPLAY_INDEX
end

-- ↑ those values are default value(builtin display)

m.default_properties = {
	update_freq = 'when_shown',
	position = 'left',
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
		color = require('actor.helper.color').surface0,
		border_color = 0xffffffff,
		border_width = 0,
		height = background.height,
		corner_radius = background.corner_radius,
	},
	icon = {
		font = {
			family = 'PlemolJP Console NF',
			-- style = 'Regular',
			size = font.size,
		},
	},
	label = {
		font = {
			family = 'PlemolJP Console NF',
			-- style = 'Regular',
			size = font.size,
		},
		padding_left = padding.label,
		padding_right = padding.label,
	},
}

m.bar_properties = bar

return m
