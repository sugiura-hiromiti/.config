local palette = require 'actor.helper.color'

local keyboard_input = BAR.add('item', 'keyboard', {
	-- width = 40,
	width = 'dynamic',
	position = 'right',
	background = { border_color = palette.sky },
	associated_display = require('actor.helper.yabai').display.builtin().index,
})

BAR.add('event', 'keyboard_input_change', 'AppleSelectedInputSourcesChangedNotification')

keyboard_input:subscribe({ 'keyboard_input_change', 'system_woke', 'forced' }, function(env)
	BAR.exec('defaults read com.apple.HIToolbox.plist AppleSelectedInputSources | rg ABC', function(rslt, exit_code)
		local label = 'ja'
		if rslt:find 'ABC' then
			label = 'en'
		end
		keyboard_input:set {
			label = label,
		}
	end)
end)
