SBAR.bar {
	color = 0x00000000,
	border_color = 0xffffffff,
	height = 60,
	margin = 5,
	y_offset = 4,
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

local raycast_calendar_event = SBAR.add('alias', 'Raycast,raycastCalendarStatusItem', { update_freq = 60 })
local obsidian = SBAR.add(
	'alias',
	'Raycast,extension_obsidian_obsidianMenuBar__6090553e-ee96-4c89-af5c-e6c60fa551ba',
	{ position = 'left' }
)
local clock = SBAR.add('alias', 'Control Center,Clock', { position = 'left' })
local text_input_menu = SBAR.add('alias', 'TextInputMenuAgent,Item-0', { position = 'left' })
