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
		keys={			{
				'<tab>',
				function ()
									require('todo-comments').jump_next()
				end,
				desc = 'jump to next todo comment',
				mode = { 'n', 'v' },
			},
			{
				'<s-tab>',
				function ()
									require('todo-comments').jump_prev()
				end,
				desc = 'jump to previous todo comment',
				mode = { 'n', 'v' },
			},
},
		config = true,
	},
	'norcalli/nvim-colorizer.lua',
}
