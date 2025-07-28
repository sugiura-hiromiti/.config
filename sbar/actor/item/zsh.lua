local palette = require 'actor.helper.color'

local zsh = BAR.add('item', 'zsh', {
	width = 'dynamic',
	position = 'right',
	background = { border_color = palette.text, color = palette.text },
	label = { color = palette.surface0 },
	associated_display = require('actor.helper.yabai').display.external_indices()[1],
})

BAR.add('event', 'zsh_title')

zsh:subscribe('zsh_title', function(env)
	require('actor.helper.dbg').print_table(env, 'zsh_title=>env.')
	zsh:set {
		label = env.TITLE,
	}
end)
