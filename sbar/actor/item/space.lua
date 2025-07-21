local palette = require 'actor.helper.color'

local yabai_spaces1 = BAR.add('item', 'yabai_spaces1', {
	width = 'dynamic',
	position = 'left',
	background = { border_color = palette.pink },
	label = GUI_INFO.space[1],
	associated_display = 1,
})
yabai_spaces1:set { label = { color = palette.pink } }

local yabai_spaces2 = BAR.add('item', 'yabai_spaces2', {
	width = 'dynamic',
	position = 'left',
	background = { border_color = palette.pink },
	label = GUI_INFO.space[2],
	associated_display = 1,
})
yabai_spaces2:set { label = { color = palette.pink } }

local yabai_spaces3 = BAR.add('item', 'yabai_spaces3', {
	width = 'dynamic',
	position = 'left',
	background = { border_color = palette.pink },
	label = GUI_INFO.space[3],
	associated_display = 2,
})
yabai_spaces3:set { label = { color = palette.pink } }

local yabai_spaces4 = BAR.add('item', 'yabai_spaces4', {
	width = 'dynamic',
	position = 'left',
	background = { border_color = palette.pink },
	label = GUI_INFO.space[4],
	associated_display = 2,
})
yabai_spaces4:set { label = { color = palette.pink } }

--  NOTE: what's make this quicker

yabai_spaces1:subscribe({ 'space_change', 'display_change' }, function(env)
	require('actor.helper.gui').update_property(env)

	if GUI_INFO.active_display ~= 1 then
		return
	elseif GUI_INFO.active_space == 1 then
		yabai_spaces1:set {
			label = { color = palette.surface0 },
			background = {
				color = palette.pink,
			},
		}
	else
		yabai_spaces1:set {
			label = { color = palette.pink },
			background = { color = palette.surface0 },
		}
	end
end)

yabai_spaces2:subscribe({ 'space_change', 'display_change' }, function(env)
	require('actor.helper.gui').update_property(env)

	if GUI_INFO.active_display ~= 1 then
		return
	elseif GUI_INFO.active_space == 2 then
		yabai_spaces2:set {
			label = { color = palette.surface0 },
			background = {
				color = palette.pink,
			},
		}
	else
		yabai_spaces2:set {
			label = { color = palette.pink },
			background = { color = palette.surface0 },
		}
	end
end)

yabai_spaces3:subscribe({ 'space_change', 'display_change' }, function(env)
	require('actor.helper.gui').update_property(env)

	if GUI_INFO.active_display ~= 2 then
		return
	elseif GUI_INFO.active_space == 3 then
		yabai_spaces3:set {
			label = { color = palette.surface0 },
			background = {
				color = palette.pink,
			},
		}
	else
		yabai_spaces3:set {
			label = { color = palette.pink },
			background = { color = palette.surface0 },
		}
	end
end)

yabai_spaces4:subscribe({ 'space_change', 'display_change' }, function(env)
	require('actor.helper.gui').update_property(env)

	if GUI_INFO.active_display ~= 2 then
		return
	elseif GUI_INFO.active_space == 4 then
		yabai_spaces4:set {
			label = { color = palette.surface0 },
			background = {
				color = palette.pink,
			},
		}
	else
		yabai_spaces4:set {
			label = { color = palette.pink },
			background = { color = palette.surface0 },
		}
	end
end)
