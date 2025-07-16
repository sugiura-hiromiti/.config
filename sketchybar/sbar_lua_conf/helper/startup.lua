---@param bar_name string
---@param display_index integer
---@param bar table
return function(bar_name, display_index, bar)
	bar.set_bar_name(bar_name)
	bar.begin_config()

	local property_list = require 'sbar_lua_conf.helper.property'(display_index)
	bar.default(property_list.default_properties)
	bar.bar(property_list.bar_properties)

	require 'sbar_lua_conf.item.clock'(display_index, bar)
	require 'sbar_lua_conf.item.raycast_event'(display_index, bar)
	require 'sbar_lua_conf.item.battery'(display_index, bar)
	require 'sbar_lua_conf.item.input_method'(display_index, bar)
	require 'sbar_lua_conf.item.space'(display_index, bar)
	require 'sbar_lua_conf.item.current_app'(display_index, bar)
	require 'sbar_lua_conf.item.window'(display_index, bar)

	bar.end_config()
	bar.event_loop()
end
