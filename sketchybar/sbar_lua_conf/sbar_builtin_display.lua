local sbar_builtin_display = require 'sketchybar'

require('sbar_lua_conf.helper.dbg').print_table(sbar_builtin_display, 'sketchybar.')

require 'sbar_lua_conf.helper.startup'(
	'builtin',
	require('sbar_lua_conf.helper.yabai').builtin_display_index(),
	sbar_builtin_display
)

return sbar_builtin_display
