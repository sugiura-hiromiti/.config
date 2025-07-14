return function(bar_name, bar)
	local palette = require 'sbar_lua_conf.helper.color'
	local window_title = bar.add('item', 'window_title', {
		width = 'dynamic',
		position = 'left',
		background = { border_color = palette.get_color 'lavender' },
		label = { color = palette.get_color 'lavender' },
	})
	bar.add('event', 'window_title_changed')
	bar.add('event', 'window_focused')
	window_title:subscribe({ 'window_focused', 'window_title_changed' }, function()
		bar.exec('yabai -m query --windows | jq \'.[] | select(.["has-focus"] == true).title\'', function(rslt, exit_code)
			local label = rslt:gsub('\\"', "'"):gsub('"', ''):gsub('\\', '')
			window_title:set { label = label }
		end)
	end)
end
