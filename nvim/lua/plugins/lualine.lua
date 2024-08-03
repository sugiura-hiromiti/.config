return {
	'nvim-lualine/lualine.nvim',
	opts = {
		globalstatus = true,
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'filename' },
			lualine_c = {
				function()
					return require('nvim-navic').get_location()
				end,
			},
			lualine_x = { 'diagnostics', 'branch', 'diff' },
			lualine_y = { 'location' },
			lualine_z = {},
		},
	},
}
