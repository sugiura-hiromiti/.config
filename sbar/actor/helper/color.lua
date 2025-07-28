---@class catppuccin_frappe
---@field rosewater integer  "#f2d5cf"
---@field flamingo integer   "#eebebe"
---@field pink integer       "#f4b8e4"
---@field mauve integer      "#ca9ee6"
---@field red integer        "#e78284"
---@field maroon integer     "#ea999c"
---@field peach integer      "#ef9f76"
---@field yellow integer     "#e5c890"
---@field green integer      "#a6d189"
---@field teal integer       "#81c8be"
---@field sky integer        "#99d1db"
---@field sapphire integer   "#85c1dc"
---@field blue integer       "#8caaee"
---@field lavender integer   "#babbf1"
---@field text integer       "#c6d0f5"
---@field subtext1 integer   "#b5bfe2"
---@field subtext0 integer   "#a5adce"
---@field overlay2 integer   "#949cbb"
---@field overlay1 integer   "#838ba7"
---@field overlay0 integer   "#737994"
---@field surface2 integer   "#626880"
---@field surface1 integer   "#51576d"
---@field surface0 integer   "#414559"
---@field base integer       "#303446"
---@field mantle integer     "#292c3c"
---@field crust integer      "#232634"
---@field get_color function

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

---@type catppuccin_frappe
local palette = {
	rosewater = 0xfff2d5cf,
	flamingo = 0xffeebebe,
	pink = 0xfff4b8e4,
	mauve = 0xffca9ee6,
	red = 0xffe78284,
	maroon = 0xffea999c,
	peach = 0xffef9f76,
	yellow = 0xffe5c890,
	green = 0xffa6d189,
	teal = 0xff81c8be,
	sky = 0xff99d1db,
	sapphire = 0xff85c1dc,
	blue = 0xff8caaee,
	lavender = 0xffbabbf1,
	text = 0xffc6d0f5,
	subtext1 = 0xffb5bfe2,
	subtext0 = 0xffa5adce,
	overlay2 = 0xff949cbb,
	overlay1 = 0xff838ba7,
	overlay0 = 0xff737994,
	surface2 = 0xff626880,
	surface1 = 0xff51576d,
	surface0 = 0xff414559,
	base = 0xff303446,
	mantle = 0xff292c3c,
	crust = 0xff232634,

	---@param name color_name name of the color in the palette
	---@param alpha integer|nil "0xXX" representation of alpha color code
	---@return integer
	get_color = function(name, alpha)
		if alpha == nil then
			alpha = 0xff
		end

		local rgb = palette[name] - 0xff000000 + alpha * 0x1000000

		return rgb
	end,
}

return palette
