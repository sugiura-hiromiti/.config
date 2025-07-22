local palette = require 'actor.helper.color'

local raycast_calendar_event = BAR.add('alias', 'Raycast,raycastCalendarStatusItem', {
	width = 'dynamic',
	position = 'right',
	-- label = {
	-- 	color = palette.yellow,
	-- },
	background = {
		border_color = palette.yellow,
	},
	associated_display = GUI_INFO.builtin_display_index,
})
