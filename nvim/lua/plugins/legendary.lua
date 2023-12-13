return {
	'mrjones2014/legendary.nvim',
	priority = 10000,
	lazy = false,
	opts = {
		keymaps = {
			{
				'<esc>',
				{
					i = function()
						if not (string.match(vim.bo.bt, 'no') or vim.bo.modifiable == false) then
							vim.cmd 'update'
						end
						vim.cmd 'stopintsert'
						vim.lsp.buf.format { async = true }
					end,
					n = function()
						require('notify').dismiss { pending = true, silent = true }
						vim.cmd 'noh'
					end,
				},
				description = 'customized <esc> key',
			},
			{ 'k', 'gk', description = 'move cursor to the visually previous line', mode = { 'n', 'v' } },
			{ 'j', 'gj', description = 'move cursor to the visually next line', mode = { 'n', 'v' } },
			{ '$', '^', description = 'move cursor to the end of line', mode = { 'v', 'n' } },
			{ '^', '$', description = 'move cursor to the start of line', mode = { 'v', 'n' } },
			{ ',', '@:', description = 'repeat last ex command', mode = { 'v', 'n' } },
			{ '<cr>', ':Make ', description = 'execute `Make` command' },
			{ '<s-cr>', ':!', description = 'execute shell command' },
			{
				itemgroup = 'emacs keybind',
				description = 'emulating emacs keybind',
				icon = '',
				keymaps = {
					{ '<c-n>', '<down>', description = 'move down cursor', mode = { 'i', 'c', 's' } },
					{ '<c-p>', '<up>', description = 'move up cursor', mode = { 'i', 'c', 's' } },
					{ '<c-b>', '<left>', description = 'move left cursor', mode = { 'i', 'c' } },
					{ '<c-f>', '<right>', description = 'move right cursor', mode = { 'i', 'c' } },
					{ '<c-a>', '<home>', description = 'move cursor to the start of context', mode = { 'i', 'c' } },
					{ '<c-e>', '<end>', description = 'move cursor to the end of line', mode = { 'i', 'c' } },
					{ '<c-d>', '<del>', description = 'delete character under cursor', mode = { 'i', 'c' } },
					{ '<c-k>', '<right><c-c>v$hs', description = 'delete to the end of line', mode = { 'i', 'c' } },
					{ '<c-u>', '<c-c>v^s', description = 'delette to the start of line', mode = { 'i', 'c' } },
					{
						'<c-t>',
						{
							i = '<c-c>hxpa',
							n = 'hxp',
						},
						description = 'exchange two characters right of the cursor',
					},
					{ '<a-d>', '<right><c-c>ves', description = 'delete to the end of word', mode = { 'i', 'c' } },
					{ '<a-f>', '<c-right>', description = 'move cursor to the end of next word', mode = { 'i', 'c' } },
					{ '<a-b>', '<c-left>', description = 'move cursor to the start of previous word', mode = { 'i', 'c' } },
				},
			},
			{
				'<tab>',
				require('todo-comments').jump_next,
				description = 'jump to next todo comment',
				mode = { 'n', 'v' },
			},
			{
				'<s-tab>',
				require('todo-comments').jump_prev,
				description = 'jump to previous todo comment',
				mode = { 'n', 'v' },
			},
			{
				itemgroup = 'window manipulation',
				description = 'manipulate window (currently only size)',
				icon = '',
				keymaps = {
					{ '<left>', '<c-w><', description = 'decrease window width', mode = { 'n', 'v' } },
					{ '<down>', '<c-w>+', description = 'increase window height', mode = { 'n', 'v' } },
					{ '<up>', '<c-w>-', description = 'decrease window height', mode = { 'n', 'v' } },
					{ '<right>', '<c-w>>', description = 'increaase window width', mode = { 'n', 'v' } },
				},
			},
			{
				itemgroup = 'lsp related',
				description = 'execute builtin lsp feature',
				icon = '',
				keymaps = {
					{ '<space>a', vim.lsp.buf.code_action, description = 'code action', mode = { 'n', 'v' } },
					{ '<space>r', vim.lsp.buf.rename, description = 'rename symbol' },
					{ '<space>h', vim.lsp.buf.hover, description = 'show hover information' },
					{ '<c-j>', vim.diagnostic.goto_next, description = 'go to next diagnostic', mode = { 'n', 'v' } },
					{ '<c-k>', vim.diagnostic.goto_prev, description = 'go to previous diagnostic', mode = { 'n', 'v' } },
				},
			},
		},
	},
}
