---@class catppuccin_frappe
---@field   rosewater integer  "#f2d5cf"
---@field   flamingo integer  "#eebebe"
---@field   pink integer  "#f4b8e4"
---@field   mauve integer  "#ca9ee6"
---@field   red integer  "#e78284"
---@field   maroon integer  "#ea999c"
---@field   peach integer  "#ef9f76"
---@field   yellow integer  "#e5c890"
---@field   green integer  "#a6d189"
---@field   teal integer  "#81c8be"
---@field   sky integer  "#99d1db"
---@field   sapphire integer  "#85c1dc"
---@field   blue integer  "#8caaee"
---@field   lavender integer  "#babbf1"
---@field   text integer  "#c6d0f5"
---@field   subtext1 integer  "#b5bfe2"
---@field   subtext0 integer  "#a5adce"
---@field   overlay2 integer  "#949cbb"
---@field   overlay1 integer  "#838ba7"
---@field   overlay0 integer  "#737994"
---@field   surface2 integer  "#626880"
---@field   surface1 integer  "#51576d"
---@field   surface0 integer  "#414559"
---@field   base integer  "#303446"
---@field   mantle integer  "#292c3c"
---@field   crust integer  "#232634"

---@alias color_name
---|   'rosewater' # "#f2d5cf"
---|   'flamingo' # "#eebebe"
---|   'pink' # "#f4b8e4"
---|   'mauve' # "#ca9ee6"
---|   'red' # "#e78284"
---|   'maroon' # "#ea999c"
---|   'peach' # "#ef9f76"
---|   'yellow' # "#e5c890"
---|   'green' # "#a6d189"
---|   'teal' # "#81c8be"
---|   'sky' # "#99d1db"
---|   'sapphire' # "#85c1dc"
---|   'blue' # "#8caaee"
---|   'lavender' # "#babbf1"
---|   'text' # "#c6d0f5"
---|   'subtext1' # "#b5bfe2"
---|   'subtext0' # "#a5adce"
---|   'overlay2' # "#949cbb"
---|   'overlay1' # "#838ba7"
---|   'overlay0' # "#737994"
---|   'surface2' # "#626880"
---|   'surface1' # "#51576d"
---|   'surface0' # "#414559"
---|   'base' # "#303446"
---|   'mantle' # "#292c3c"
---|   'crust' # "#232634"

package.path = package.path
	.. ';'
	.. os.getenv 'HOME'
	.. '/.local/share/nvim/lazy/catppuccin/lua/catppuccin/palettes/frappe.lua'
local original_palette = require 'frappe'

local m = {}

---@param name color_name name of the color in the palette
---@param alpha integer|nil "0xXX" representation of alpha color code
---@return integer
m.get_color = function(name, alpha)
	if alpha == nil then
		alpha = 0xff000000
	end

	local rgb = original_palette[name]:sub(2, 7)
	local rgb_code = tonumber(rgb, 16)
	local color_code = alpha + rgb_code

	return color_code
end

return m
