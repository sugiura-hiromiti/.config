local palette = require 'actor.helper.color'

local window_title = BAR.add('item', 'window_title', {
	width = 'dynamic',
	position = require('actor.helper.yabai').position 'left',
	background = { border_color = palette.lavender },
	label = { color = palette.lavender },
})

BAR.add('event', 'window_title_changed')
BAR.add('event', 'window_focused')

window_title:subscribe({ 'window_focused', 'window_title_changed' }, function(env)
	require('actor.helper.gui').update_property(env)
	if GUI_INFO.active_display == DISPLAY_INDEX then
		BAR.exec('yabai -m query --windows | jq \'.[] | select(.["has-focus"] == true).title\'', function(rslt, exit_code)
			local label = rslt:gsub('\\"', "'"):gsub('"', ''):gsub('\\', ''):gsub('\n', '')

			window_title:set { label = label }
		end)
	end
end)
