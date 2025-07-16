---@param display_index integer
---@param bar table bar object
return function(display_index, bar)
	local palette = require 'sbar_lua_conf.helper.color'
	local clock = bar.add('item', {
		width = 'dynamic',
		position = 'right',
		label = {
			color = palette.get_color 'flamingo',
		},
		background = {
			border_color = palette.get_color 'flamingo',
		},
	})

	clock:subscribe({ 'forced', 'routine', 'system_woke' }, function(_)
		clock:set { label = os.date '%y%m%d %H%M %a' }
	end)
end
