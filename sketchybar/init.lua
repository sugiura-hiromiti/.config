SBAR = require 'sketchybar'

-- set the bar name, when using multiple bar instance
-- SBAR.set_bar_name 'first_bar_as_global_info'
-- SBAR.set_bar_name 'second_bar_as_local_info'

print 'abc'
SBAR.begin_config()
print 'def'
require 'bar'
print 'ghi'
require 'default'
print 'jkl'
require 'item'
SBAR.end_config()

SBAR.event_loop()
