--[[
				{
	  active = "#353B49",
	  bg = "#2E3440",
	  blue = "#81A1C1",
	  cyan = "#88C0D0",
	  dark_blue = "#5E81AC",
	  dark_pink = "#E44675",
	  dark_red = "#BF616A",
	  diff_add = "#A3BE8C",
	  diff_add_bg = "#394E3D",
	  diff_change = "#5E81AC",
	  diff_change_bg = "#39495D",
	  diff_remove = "#D57780",
	  diff_remove_bg = "#4D2B2E",
	  diff_text_bg = "#405D7E",
	  error = "#BF616A",
	  fg = "#C8D0E0",
	  fg_light = "#E5E9F0",
	  float = "#3B4252",
	  gray = "#646A76",
	  green = "#A3BE8C",
	  highlight = "#3F4758",
	  highlight_dark = "#434C5E",
	  hint = "#B988B0",
	  info = "#A3BE8C",
	  light_gray = "#6C7A96",
	  light_green = "#8FBCBB",
	  light_purple = "#B48EAD",
	  light_red = "#DE878F",
	  none = "NONE",
	  orange = "#D08F70",
	  pink = "#E85B7A",
	  purple = "#B988B0",
	  red = "#D57780",
	  selection = "#4C566A",
	  warn = "#D08F70",
	  yellow = "#EBCB8B"
	}
			]]
local  --[[palette]]_ = require('onenord.colors').load()

return {
	{
		'rcarriga/nvim-notify',
		opts = { background_colour = '#000000' },
	},
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = { 'MunifTanjim/nui.nvim' },
		opts = {
			presets = { bottom_search = true, long_message_to_split = true },
		},
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
	},
	{
		'norcalli/nvim-colorizer.lua',
		main = 'colorizer',
	},
	-- TODO: config for this
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup {}
		end,
	},
}
