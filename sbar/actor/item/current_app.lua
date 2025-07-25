local palette = require 'actor.helper.color'

local app_name = BAR.add('item', 'application_name', {
	width = 'dynamic',
	position = 'left',
	background = { border_color = palette.mauve },
	label = { color = palette.mauve },
})

app_name:subscribe({ 'front_app_switched' }, function(env)
	require('actor.helper.gui').update_property(env)
	if GUI_INFO.active_display == DISPLAY_INDEX then
		local label = GUI_INFO.active_app
		app_name:set { label = label }
	end
end)
