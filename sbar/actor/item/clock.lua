local palette = require 'actor.helper.color'

local clock = BAR.add('item', 'clock', {
	update_freq = 1,
	width = 'dynamic',
	position = 'right',
	label = {
		color = palette.flamingo,
	},
	background = {
		border_color = palette.flamingo,
	},
	associated_display = require('actor.helper.yabai').display.builtin().index,
})

clock:subscribe({ 'system_woke', 'routine' }, function(env)
	clock:set { label = os.date '%y%m%d %H%M %a' }
end)
