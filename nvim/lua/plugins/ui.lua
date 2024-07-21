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
	'stevearc/dressing.nvim',
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end,
	},
	{ 'NeogitOrg/neogit', config = true },
}
