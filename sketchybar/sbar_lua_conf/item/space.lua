---@param display_index integer
---@param bar table bar object
return function(display_index, bar)
	local palette = require 'sbar_lua_conf.helper.color'
	local yabai_spaces = bar.add('item', 'yabai_spaces', {
		width = 'dynamic',
		position = 'left',
		background = { border_color = palette.get_color 'pink' },
		label = { color = palette.get_color 'pink' },
	})
	bar.add('event', 'space_changed')
	bar.add('event', 'display_changed')
	yabai_spaces:subscribe({ 'space_changed', 'display_changed' }, function()
		bar.exec('yabai -m query --spaces | jq \'.[] | select(.["has-focus"] == true).label\'', function(rslt, exit_code)
			local label = rslt:gsub('\\"', "'"):gsub('"', ''):gsub('\\', '')
			yabai_spaces:set { label = label }
		end)
	end)
end
