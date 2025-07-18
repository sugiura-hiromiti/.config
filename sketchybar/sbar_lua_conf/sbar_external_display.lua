local external_display_indices = require('sbar_lua_conf.helper.yabai').external_display_indices()

local bars = {}
for _, i in ipairs(external_display_indices) do
	local sbar_external_display = require 'sketchybar'
	require 'sbar_lua_conf.helper.startup'('external_' .. i, i, sbar_external_display)
	table.insert(bars, sbar_external_display)
end

return bars
