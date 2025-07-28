local palette = require 'actor.helper.color'
local yabai = require 'actor.helper.yabai'

local app_name = BAR.add('item', 'application_name', {
	width = 'dynamic',
	position = 'left',
	background = { border_color = palette.lavender },
	label = { color = palette.lavender },
})

app_name:subscribe({ 'front_app_switched' }, function(env)
	if yabai.display.focused().index == DISPLAY_INDEX then
		local label = yabai.window.focused().app
		app_name:set { label = label }
	end
end)
