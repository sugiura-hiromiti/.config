return {
	'rcarriga/nvim-notify',
	{
		'folke/noice.nvim',
		config = function()
			require('noice').setup {}
		end,
	},
	{
		'folke/todo-comments.nvim',
		config = function()
			require('todo-comments').setup {
				keywords = {
					FIX = { alt = { 'e' } },
					TODO = { alt = { 'q' } },
					HACK = { color = 'doc', alt = { 'a' } },
					WARN = { alt = { 'x' } },
					PERF = { color = 'cmt', alt = { 'p' } },
					NOTE = { alt = { 'd' } },
					TEST = { alt = { 't', 'PASS', 'FAIL' } },
				},
				colors = { cmt = { 'Comment' }, doc = { 'SpecialComment' } },
			}
		end,
	},
}
