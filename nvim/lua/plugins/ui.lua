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
		--		cofig = function()
		--			require('colorizer').setup {
		--				'*',
		--			}
		--		end,
	},

	-- TODO: config for this
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
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
