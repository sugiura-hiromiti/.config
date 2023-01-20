return {
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { map_c_h = true }
		end,
	},
	{
		'jackMort/ChatGPT.nvim',
		config = true,
	},
	{
		'AckslD/nvim-FeMaco.lua',
		config = true,
	},
	'L3MON4D3/LuaSnip',
}
