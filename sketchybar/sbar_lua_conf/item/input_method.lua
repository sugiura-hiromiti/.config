---@param display_index integer
---@param bar table bar object
return function(display_index, bar)
	local palette = require 'sbar_lua_conf.helper.color'

	bar.add('event', 'keyboard_input_change', 'AppleSelectedInputSourcesChangedNotification')

	local keyboard_input = bar.add('item', 'keyboard', {
		-- width = 40,
		width = 'dynamic',
		position = 'right',
		background = { border_color = palette.get_color 'blue' },
	})

	keyboard_input:subscribe({ 'keyboard_input_change', 'system_woke', 'forced' }, function(env)
		bar.exec('defaults read com.apple.HIToolbox.plist AppleSelectedInputSources | rg ABC', function(rslt, exit_code)
			local label = 'ja'
			if rslt:find 'ABC' then
				label = 'en'
			end
			keyboard_input:set {
				label = label,
			}
		end)
	end)
end
