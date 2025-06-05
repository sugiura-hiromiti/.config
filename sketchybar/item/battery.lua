local palette = require 'helper.color'

local battery = SBAR.add('item', 'battery', { background = {
	border_color = palette.get_color 'yellow',
} })

battery:subscribe({ 'routine', 'power_source_change', 'system_woke' }, function()
	SBAR.exec('pmset -g batt', function(batt_info)
		local icon = '!'
		local label = '?'

		local found, _, charge = batt_info:find '(%d+)%%'
		if found then
			label = charge
		end

		local color = palette.get_color 'yellow'
		local charging, _, _ = batt_info:find 'AC Power'

		if charging then
			icon = icons.battery.charging
		else
			if found and charge > 80 then
				icon = icons.battery._100
			elseif found and charge > 60 then
				icon = icons.battery._75
			elseif found and charge > 40 then
				icon = icons.battery._50
			elseif found and charge > 20 then
				icon = icons.battery._25
				color = colors.orange
			else
				icon = icons.battery._0
				color = colors.red
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
			},
			label = { string = lead .. label },
		}
	end)
end)
