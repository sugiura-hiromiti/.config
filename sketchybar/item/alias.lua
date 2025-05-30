-- local text_input_menu =
SBAR.add('alias', 'TextInputMenuAgent,Item-0', { position = 'left', width = 'dynamic' })
local raycast_calendar_event =
	SBAR.add('alias', 'Raycast,raycastCalendarStatusItem', { y_offset = 0, width = 'dynamic' })

local raycast_calendar_width = raycast_calendar_event:query().geometry.width
if raycast_calendar_width < 50 then
	SBAR.remove 'Raycast,raycastCalendarStatusItem'
end

-- local space = SBAR.add('space', '0', { position = 'left', width = 'dynamic' })

-- local clock =
SBAR.add('alias', 'Control Center,Clock', { position = 'left', width = 'dynamic' })

--  TODO: replace clock with following date command
--  ❯ date '+%y%m%d %H%M %a'

-- local obsidian =
-- 	SBAR.add('alias', 'Raycast,extension_obsidian_obsidianMenuBar__6090553e-ee96-4c89-af5c-e6c60fa551ba', {})
