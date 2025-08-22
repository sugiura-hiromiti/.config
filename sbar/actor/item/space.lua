BAR.add('event', 'display_changed')
BAR.add('event', 'space_changed')
BAR.add('event', 'space_created')
BAR.add('event', 'space_destroyed')

local palette = require 'actor.helper.color'
local yabai = require 'actor.helper.yabai'

---@param space_info space_info
---@return table
local prop_of_item = function(space_info)
	local prop = {}
	if space_info['is-visible'] then
		if space_info['has-focus'] then
			prop = {
				label = {
					color = palette.surface0,
				},
				background = {
					color = palette.mauve,
				},
			}
		else
			prop = {
				label = {
					color = palette.mauve,
				},
				background = {
					color = palette.surface2,
				},
			}
		end
	else
		prop = {
			label = {
				color = palette.mauve,
			},
			background = {
				color = palette.surface0,
			},
		}
	end

	return prop
end

local item_register = function()
	local space_infos = yabai.space.all()
	local is_first_fullscreen = true

	for _, space_info in ipairs(space_infos) do
		local label = '' .. space_info.index
		local builtin_display = yabai.display.builtin()
		local external_display1 = yabai.display.external()[1]

		if space_info.display == builtin_display.index then
			if space_info.index == builtin_display.spaces[1] then
				label = 'L'
			end
		elseif space_info.display == external_display1.index then
			if space_info.index == external_display1.spaces[2] then
				label = 'K'
			elseif space_info.index == external_display1.spaces[1] then
				label = 'J'
			end
		end

		local ty = space_info.type

		if space_info['is-native-fullscreen'] then
			ty = 'full'
		end

		label = label .. ':' .. ty

		if space_info['s-native-fullscree'] and is_first_fullscreen then
			label = 'H'
			is_first_fullscreen = false
		end

		local space = BAR.add('item', 'yabai_space' .. space_info.index, {
			width = 'dynamic',
			position = 'left',
			background = {
				border_color = palette.mauve,
			},
			label = label,
			associated_display = space_info.display,
		})

		space:set(prop_of_item(space_info))

		space:subscribe({ 'space_changed', 'display_changed' }, function(env)
			local space_index = assert(tonumber(space:query().name:sub(-1, -1)), 'failed to detect space_index')
			local this_space_info = yabai.space.with_index(space_index)
			space:set(prop_of_item(this_space_info))
		end)
	end
end

item_register()

local event_listener = BAR.add('item', 'event_listener', { drawing = false })

event_listener:subscribe({ 'space_created', 'space_destroyed' }, function(env)
	item_register()
end)
