local palette = require 'helper.color'

SBAR.add('event', 'keyboard_input_change', 'AppleSelectedInputSourcesChangedNotification')

local keyboard_input = SBAR.add('item', 'keyboard', {
	width = 40,
	padding_right = 10,
	label = {
		padding_right = 10,
	},
	background = { border_color = palette.get_color 'blue', padding_right = 10 },
})

keyboard_input:subscribe({ 'keyboard_input_change', 'system_woke', 'forced' }, function(env)
	local en_input = SBAR.exec(
		'defaults read com.apple.HIToolbox.plist AppleSelectedInputSources | rg ABC',
		function(rslt, exit_code)
			local label = 'ja'
			if rslt:find 'ABC' then
				label = 'en'
			end
			keyboard_input:set {
				label = label,
			}
		end
	)
end)
