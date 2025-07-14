return function(bar_name, bar)
	local battery = bar.add('item', 'battery', {
		width = 'dynamic',
		position = 'right',
	})

	local icons = require 'sbar_lua_conf.helper.icon'
	local palette = require 'sbar_lua_conf.helper.color'
	battery:subscribe({ 'routine', 'power_source_change', 'system_woke' }, function()
		bar.exec('pmset -g batt', function(batt_info)
			local icon = '!'
			local label = '?'

			local found, _, charge = batt_info:find '(%d+)%%'
			if found then
				label = charge
				charge = tonumber(charge)
			end

			local color = palette.get_color 'yellow'
			if charge >= 80 then
				color = palette.get_color 'green'
			elseif charge <= 20 then
				color = palette.get_color 'red'
			end

			local charging, _, _ = batt_info:find 'AC Power'

			if charging then
				icon = icons.battery.charging
			else
				if found then
					if charge >= 95 then
						icon = icons.battery._100
						color = palette.get_color 'blue'
					elseif charge >= 85 then
						icon = icons.battery._90
						color = palette.get_color 'sapphire'
					elseif charge >= 75 then
						icon = icons.battery._80
						color = palette.get_color 'sky'
					elseif charge >= 65 then
						icon = icons.battery._70
						color = palette.get_color 'teal'
					elseif charge >= 55 then
						icon = icons.battery._60
						color = palette.get_color 'green'
					elseif charge >= 45 then
						icon = icons.battery._50
						color = palette.get_color 'yellow'
					elseif charge >= 35 then
						icon = icons.battery._40
						color = palette.get_color 'peach'
					elseif charge >= 25 then
						icon = icons.battery._30
						color = palette.get_color 'maroon'
					elseif charge >= 15 then
						icon = icons.battery._20
						color = palette.get_color 'red'
					elseif charge >= 5 then
						icon = icons.battery._10
						color = palette.get_color 'red'
					else
						icon = icons.error
						color = palette.get_color 'red'
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
end
