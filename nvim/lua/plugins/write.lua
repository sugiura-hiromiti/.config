return {
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { map_c_h = true }
		end,
	},
	'L3MON4D3/LuaSnip',
}
