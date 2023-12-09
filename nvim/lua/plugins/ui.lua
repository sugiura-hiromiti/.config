return {
	'rcarriga/nvim-notify',
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			presets = { bottom_search = true, long_message_to_split = true },
		},
	},
	{
		'folke/todo-comments.nvim',
		config = true,
	},
	'norcalli/nvim-colorizer.lua',

	-- TODO: config for this
	{
		'nvim-lualine/lualine.nvim',
		opts = {
			sections = {
				lualine_b = {
					'navic',
				},
				lualine_c = {},
				lualine_x = {
					'filetype',
					'branch',
					'diff',
				},
				lualine_y = { 'diagnostics' },
				-- NOTE: add todo-comments component
			},
		},
	},
}
