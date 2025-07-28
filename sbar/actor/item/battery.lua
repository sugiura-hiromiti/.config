local battery = BAR.add('item', 'battery', {
	width = 'dynamic',
	position = 'right',
	associated_display = require('actor.helper.yabai').display.builtin().index,
})

local icons = require 'actor.helper.icon'
local palette = require 'actor.helper.color'

battery:subscribe({ 'routine', 'power_source_change', 'system_woke' }, function()
	BAR.exec('pmset -g batt', function(batt_info)
		local icon = '!'
		local label = '?'

		local found, _, charge = batt_info:find '(%d+)%%'
		if found then
			label = charge
			charge = tonumber(charge)
		end

		local color = palette.yellow
		if charge >= 80 then
			color = palette.blue
		elseif charge <= 20 then
			color = palette.red
		end

		local charging, _, _ = batt_info:find 'AC Power'

		if charging then
			icon = icons.battery.charging
		else
			if found then
				if charge >= 95 then
					icon = icons.battery._100
					color = palette.blue
				elseif charge >= 85 then
					icon = icons.battery._90
					color = palette.sapphire
				elseif charge >= 75 then
					icon = icons.battery._80
					color = palette.sky
				elseif charge >= 65 then
					icon = icons.battery._70
					color = palette.teal
				elseif charge >= 55 then
					icon = icons.battery._60
					color = palette.green
				elseif charge >= 45 then
					icon = icons.battery._50
					color = palette.yellow
				elseif charge >= 35 then
					icon = icons.battery._40
					color = palette.peach
				elseif charge >= 25 then
					icon = icons.battery._30
					color = palette.maroon
				elseif charge >= 15 then
					icon = icons.battery._20
					color = palette.red
				elseif charge >= 5 then
					icon = icons.battery._10
					color = palette.red
				else
					icon = icons.error
					color = palette.red
				end
			end
		end

		local lead = ''
		if found and charge < 10 then
			lead = '0'
		end

		battery:set {
			icon = {
				string = icon,
				color = color,
				padding_left = 10,
			},
			label = {
				string = lead .. label,
				color = color,
				padding_right = 10,
			},
		}
	end)
end)
