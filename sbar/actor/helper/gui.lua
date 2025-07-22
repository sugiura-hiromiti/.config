local m = {}

m.update_property = function(env)
	local sender = env.SENDER
	if sender == 'display_change' then
		GUI_INFO.active_display = tonumber(env.INFO)
	elseif sender == 'space_change' then
		for _, v in pairs(env.INFO) do
			GUI_INFO.active_space = v
		end
	elseif sender == 'front_app_switched' then
		GUI_INFO.active_app = env.INFO
	end
end

return m
