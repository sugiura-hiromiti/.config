SBAR = require 'sketchybar'

-- set the bar name, when using multiple bar instance
-- SBAR.set_bar_name 'first_bar_as_global_info'
-- SBAR.set_bar_name 'second_bar_as_local_info'

SBAR.begin_config()
require 'bar'
require 'default'
require 'item'
SBAR.end_config()

SBAR.event_loop()
