return {
	'mrjones2014/legendary.nvim',
	priority = 1000,
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
						vim.cmd 'stopinsert'
						vim.lsp.buf.format { async = true }
					end,
					n = function()
						require('notify').dismiss { pending = true, silent = true }
						vim.cmd 'noh'
					end,
				},
				description = 'customized <esc> key',
			},
			{ 't', '<cmd>Legendary<cr>', description = 'open legendary window', mode = { 'v', 'n' } },
			{
				itemgroup = 'smart replacement',
				description = "adjust vim's weired keybinds",
				icon = ' ',
				keymaps = {
					{ 'k', 'gk', description = 'move cursor to the visually previous line', mode = { 'n', 'v' } },
					{ 'j', 'gj', description = 'move cursor to the visually next line', mode = { 'n', 'v' } },
					{ '$', '^', description = 'move cursor to the end of line', mode = { 'v', 'n' } },
					{ '^', '$', description = 'move cursor to the start of line', mode = { 'v', 'n' } },
					{ ',', '@:', description = 'repeat last ex command', mode = { 'v', 'n' } },
					{ '<cr>', ':Make ', description = 'execute `Make` command' },
					{ '<s-cr>', ':!', description = 'execute shell command' },
				},
			},
			{
				itemgroup = 'emacs keybind',
				description = 'emulating emacs keybind',
				icon = '',
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
				itemgroup = 'window manipulation',
				description = 'manipulate window (currently only size)',
				icon = ' ',
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
				icon = '',
				keymaps = {
					{ '<space>a', vim.lsp.buf.code_action, description = 'code action', mode = { 'n', 'v' } },
					{ '<space>r', vim.lsp.buf.rename, description = 'rename symbol' },
					{ '<space>h', vim.lsp.buf.hover, description = 'show hover information' },
					{ '<c-j>', vim.diagnostic.goto_next, description = 'go to next diagnostic', mode = { 'n', 'v' } },
					{ '<c-k>', vim.diagnostic.goto_prev, description = 'go to previous diagnostic', mode = { 'n', 'v' } },
				},
			},
			{
				itemgroup = 'telescope',
				description = 'telescope manipulation',
				icon = ' ',
				keymaps = {
					{
						'T',
						function()
							require('telescope.builtin').builtin()
						end,
						description = 'open telescope prompt',
						mode = { 'n', 'v' },
					},
					{
						'<space>o',
						function()
							if vim.bo.ft == 'lua' then
								require('telescope.builtin').lsp_document_symbols()
							else
								require('telescope.builtin').lsp_dynamic_workspace_symbols()
							end
						end,
						description = 'search symbols',
					},
					{
						'/',
						function()
							require('telescope.builtin').live_grep()
						end,
						description = 'grep texts in current workspace',
						mode = { 'n', 'v' },
					},
					{
						'<space>j',
						function()
							require('telescope.builtin').lsp_references()
						end,
						description = 'open jump list of outline under the cursor',
					},
					{
						'<space>f',
						function()
							require('search').open()
						end,
						description = 'fuzzy search files smartly',
					},
				},
			},
			{
				itemgroup = 'todo-comments',
				description = 'move between todo-comments',
				icon = ' ',
				keymaps = {
					{
						'<tab>',
						function()
							require('todo-comments').jump_next()
						end,
						description = 'jump to next todo comment',
						mode = { 'n', 'v' },
					},
					{
						'<s-tab>',
						function()
							require('todo-comments').jump_prev()
						end,
						description = 'jump to previous todo comment',
						mode = { 'n', 'v' },
					},
				},
			},
			{
				itemgroup = 'spider',
				description = 'improved word move',
				icon = '󱇪 ',
				keymaps = {
					{
						'w',
						function()
							require('spider').motion 'w'
						end,
						description = 'move cursor to the start of next word',
						mode = { 'n', 'o', 'x' },
					},
					{
						'e',
						function()
							require('spider').motion 'e'
						end,
						description = 'move cursor to the end of next word',
						mode = { 'n', 'o', 'x' },
					},
					{
						'b',
						function()
							require('spider').motion 'b'
						end,
						description = 'move cursor to the start of previous word',
						mode = { 'n', 'o', 'x' },
					},
				},
			},
		},
		commands = {
			{
				'Make',
				function(opts)
					local cmd = '<cr> '
					local args = opts.args
					local extra = ''
					local ft = vim.bo.filetype
					if ft == 'rust' then -- langs which have to be compiled
						cmd = '!cargo '
						if args == '' then
							local paths = vim.fn.expand '%:p'
							local path = type(paths) == 'string' and paths or paths[1]

							args = 'r '
							if string.find(path, '/src/bin') ~= nil then
								local _, l = string.find(path, '/src/bin/')
								local r = string.find(string.sub(path, l + 1), '/')
									or string.find(string.sub(path, l + 1), '%.')

								args = args .. '--bin ' .. string.sub(path, l + 1, l + r - 1)
							elseif vim.fn.expand '%' ~= 'main.rs' then
								args = 't '
							end
						else
							args = table.remove(opts.fargs, 1) -- insert 1st argument to `args`
						end
						table.insert(opts.fargs, 1, '-q')
						for _, a in ipairs(opts.fargs) do
							extra = extra .. ' ' .. a
						end
					elseif ft == 'cpp' or ft == 'c' then
						cmd = '!make NEOVIM_CXX_AUTO_RUNNED_FILE=' .. vim.fn.expand '%:t'
					elseif ft == 'ruby' or ft == 'swift' or ft == 'lua' or ft == 'python' then -- langs which has interpreter
						local file = vim.fn.expand '%:t'
						local interpreter = ft
						if interpreter == 'python' then
							interpreter = interpreter .. '3'
						end
						if args == 't' then
							file = 'test.' .. ft
							args = ''
						end
						cmd = '!' .. interpreter .. ' ' .. file .. ' '
					elseif ft == 'html' then -- markup language
						cmd = '!open ' .. vim.fn.expand '%:t' .. ' '
					elseif ft == 'markdown' then
						cmd =
							[[lua if require('peek').is_open() then require('peek').close() else require('peek').open() end]]
						--'MarkdownPreviewToggle'
					end

					vim.cmd(cmd .. args .. extra)
				end,
				description = 'executer',
				--{ nargs = '*' },
				unfinished = true,
			},
			{
				'RmSwap',
				function()
					vim.cmd '!rip ~/.local/state/nvim/swap'
				end,
				description = 'remove swap file of current buffer',
			},
		},
		autocmds = {
			{
				name = 'my_au',
				clear = true,
				{
					'filetype',
					function()
						vim.opt.fo = { j = true }
						vim.opt.shiftwidth = 3
						vim.opt.tabstop = 3
						vim.opt.softtabstop = 3
						if vim.opt.ft:get() == 'notify' then
							vim.opt.ft = 'markdown'
						end
					end,
				},
				{
					'bufreadpost',
					function()
						require('colorizer').attach_to_buffer(0)
					end,
				},
			},
		},
	},
}
