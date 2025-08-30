local palette = require 'actor.helper.color'

local window_title = BAR.add('item', 'window_title', {
	width = 'dynamic',
	position = 'right',
	background = { border_color = palette.blue },
	label = { color = palette.blue },
})

BAR.add('event', 'window_title_changed')
BAR.add('event', 'window_focused')

local yabai = require 'actor.helper.yabai'
window_title:subscribe({ 'window_focused', 'window_title_changed' }, function(env)
	if yabai.display.focused().index == DISPLAY_INDEX then
		local focused_window_title = yabai.window.focused().title
		window_title:set { label = focused_window_title }
	end
end)
