return function(bar_name, bar)
	bar.set_bar_name(bar_name)
	bar.begin_config()

	local property_list = require 'sbar_lua_conf.helper.property'(bar_name)
	bar.default(property_list.default_properties)
	bar.bar(property_list.bar_properties)

	require 'sbar_lua_conf.item.clock'(bar_name, bar)
	require 'sbar_lua_conf.item.raycast_event'(bar_name, bar)
	require 'sbar_lua_conf.item.battery'(bar_name, bar)
	require 'sbar_lua_conf.item.input_method'(bar_name, bar)
	require 'sbar_lua_conf.item.space'(bar_name, bar)
	require 'sbar_lua_conf.item.current_app'(bar_name, bar)
	require 'sbar_lua_conf.item.window'(bar_name, bar)

	bar.end_config()
	bar.event_loop()
end
