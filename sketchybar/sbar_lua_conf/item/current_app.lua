---@param display_index integer
---@param bar table bar object
return function(display_index, bar)
	local palette = require 'sbar_lua_conf.helper.color'

	local app_name = bar.add('item', 'application_name', {
		width = 'dynamic',
		position = 'left',
		background = { border_color = palette.get_color 'mauve' },
		label = { color = palette.get_color 'mauve' },
	})
	bar.add('event', 'application_front_switched')
	app_name:subscribe('application_front_switched', function()
		bar.exec('yabai -m query --windows | jq \'.[] | select(.["has-focus"] == true).app\'', function(rslt, exit_code)
			local label = rslt:gsub('\\"', "'"):gsub('"', ''):gsub('\\', '')
			if label == '' then
				label = 'Finder'
			end
			app_name:set { label = label }
		end)
	end)
end
