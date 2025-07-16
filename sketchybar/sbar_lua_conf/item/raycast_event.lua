---@param display_index integer
---@param bar table bar object
return function(display_index, bar)
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
