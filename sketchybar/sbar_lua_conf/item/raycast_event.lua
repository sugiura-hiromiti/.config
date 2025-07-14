return function(bar_name, bar)
	local palette = require 'sbar_lua_conf.helper.color'
	local raycast_calendar_event = bar.add('alias', 'Raycast,raycastCalendarStatusItem', {
		width = 'dynamic',
		position = 'right',
		label = {
			color = palette.get_color 'yellow',
		},
		background = {
			border_color = palette.get_color 'yellow',
		},
	})
end
