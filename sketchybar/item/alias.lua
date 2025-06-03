local palette = require 'color'

-- local text_input_menu =
SBAR.add('alias', 'TextInputMenuAgent,Item-0', { position = 'left', width = 'dynamic' })
local raycast_calendar_event =
	SBAR.add('alias', 'Raycast,raycastCalendarStatusItem', { y_offset = 0, width = 'dynamic' })

--  TODO: switch to subscribe event
-- local raycast_calendar_width = raycast_calendar_event:query().geometry.width
-- if raycast_calendar_width < 50 then
-- 	SBAR.remove 'Raycast,raycastCalendarStatusItem'
-- end

local clock = SBAR.add('item', {
	position = 'left',
	width = 'dynamic',
	label = {
		padding_left = 10,
		padding_right = 10,
		color = palette.green,
	},
})

clock:subscribe({ 'forced', 'routine', 'system_woke' }, function(_)
	clock:set { label = os.date '%y%m%d %H%M %a' }
end)
