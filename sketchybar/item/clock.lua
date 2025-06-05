local palette = require 'helper.color'

-- local text_input_menu = SBAR.add('alias', 'TextInputMenuAgent,Item-0', { position = 'right', width = 'dynamic' })

--  TODO: switch to subscribe event
-- local raycast_calendar_width = raycast_calendar_event:query().geometry.width
-- if raycast_calendar_width < 50 then
-- 	SBAR.remove 'Raycast,raycastCalendarStatusItem'
-- end

local clock = SBAR.add('item', {
	position = 'left',
	width = 'dynamic',
	padding_left = 20,
	label = {
		color = palette.get_color 'green',
	},
	background = {
		border_color = palette.get_color 'green',
	},
})

clock:subscribe({ 'forced', 'routine', 'system_woke' }, function(_)
	clock:set { label = os.date '%y%m%d %H%M %a' }
end)
