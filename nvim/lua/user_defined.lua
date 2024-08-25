vim.cmd 'smapclear'
local m = vim.keymap.set
local tsb = require 'telescope.builtin'
local td = require 'todo-comments'

m('i', '<esc>', function()
	local ft_no_update = vim.bo.ft:find 'Telescope'
	if (not string.match(vim.bo.bt, 'no') or vim.bo.modifiable) and not ft_no_update then
		vim.cmd 'update'
	end
	vim.cmd 'stopinsert'
	vim.lsp.buf.format { async = true }
end)
m('n', '<esc>', function()
	require('notify').dismiss { pending = true, silent = true }
	vim.cmd 'noh'
end)

-- NOTE: utility
m({ 'n', 'x' }, 'k', 'gk')
m({ 'n', 'x' }, 'j', 'gj')
m({ 'n', 'x' }, '$', '^')
m({ 'n', 'x' }, '^', '$')
m({ 'n', 'x' }, '>', '@:')
-- keep in mind of usage of `,` & `<`
m({ 'n', 'x' }, '<cr>', ':Make ')
m({ 'n', 'x' }, '<s-cr>', ':!')
m({ 'n', 'x' }, '<del>', '<c-d>')

-- NOTE: emacs keybind
m('!', '<c-a>', '<home>')
m('!', '<c-e>', '<end>')
m('!', '<c-k>', '<right><c-c>v$hs')
m('!', '<c-u>', '<c-c>v^s')
m('!', '<a-d>', '<right><c-c>ves')
m('!', '<a-f>', '<c-right>')
m('!', '<a-b>', '<c-left>')

-- NOTE: lsp
m({ 'n', 'x' }, '<c-j>', function()
	vim.diagnostic.jump { count = 1 }
end)
m({ 'n', 'x' }, '<c-k>', function()
	vim.diagnostic.jump { count = -1 }
end)

-- NOTE: telescope
m({ 'n', 'x' }, '/', tsb.live_grep)
m({ 'n', 'x' }, '<up>', td.jump_prev)
m({ 'n', 'x' }, '<down>', td.jump_next)

-- NOTE: spider
m({ 'n', 'o', 'x' }, 'w', function()
	require('spider').motion 'w'
end)
m({ 'n', 'o', 'x' }, 'e', function()
	require('spider').motion 'e'
end)
m({ 'n', 'o', 'x' }, 'b', function()
	require('spider').motion 'b'
end)

-- NOTE: user command
local c = vim.api.nvim_create_user_command

c('Make', function(opts)
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
				local r = string.find(string.sub(path, l + 1), '/') or string.find(string.sub(path, l + 1), '%.')

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
		cmd = '!NEOVIM_CXX_AUTO_RUNNED_FILE=' .. vim.fn.expand '%:t' .. ' make'
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
		cmd = [[lua if require('peek').is_open() then require('peek').close() else require('peek').open() end]]
		--'MarkdownPreviewToggle'
	end

	vim.cmd(cmd .. args .. extra)
end, { nargs = '*' })
c('RmSwap', function()
	vim.cmd '!rip ~/.local/state/nvim/swap/'
end, {})

-- NOTE: autocmd
local au_id = vim.api.nvim_create_augroup('my_au', { clear = true })
local a = vim.api.nvim_create_autocmd
a('filetype', {
	group = au_id,
	callback = function()
		local ft = vim.bo.ft
		if ft == 'notify' then
			vim.bo.modifiable = true
		elseif ft == 'yaml' then
			vim.bo.expandtab = true
		end
	end,
})
a('bufreadpost', {
	group = 'my_au',
	callback = function()
		require('colorizer').attach_to_buffer(0)
	end,
})
