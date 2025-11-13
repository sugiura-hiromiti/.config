vim.cmd 'smapclear'

local m = vim.keymap.set
-- local tsb = require 'telescope.builtin'
local select = require 'my_lua_api.select'
local log = require 'my_lua_api.nvim_logger'

local dial_pair = {
	mode = { 'normal', 'visual' },
	g = { 'g', '' },
	direction = { ['a'] = 'increment', ['x'] = 'decrement' },
}

local function table_contains(table, elem)
	for _, v in pairs(table) do
		if v == elem then
			return true
		end
	end
	return false
end

local function is_url(path)
	return path:match '^https?://'
end

-- NOTE: better defaults
for _, mode in pairs(dial_pair.mode) do
	for _, g in pairs(dial_pair.g) do
		for key, value in pairs(dial_pair.direction) do
			m(string.sub(mode, 1, 1), g .. '<c-' .. key .. '>', function()
				require('dial.map').manipulate(value, g .. mode)
			end)
		end
	end
end

m('i', '<esc>', function()
	vim.cmd 'stopinsert'

	local cur_buf = vim.api.nvim_get_current_buf()
	local has_format_ability = false
	local lsp_clients = vim.lsp.get_clients { bufnr = cur_buf }
	for _, client in pairs(lsp_clients) do
		if client.server_capabilities.documentFormattingProvider then
			has_format_ability = true
			break
		else
		end
	end
	if has_format_ability then
		vim.lsp.buf.format { async = false }
	end

	if vim.api.nvim_buf_get_option(0, 'modifiable') then
		vim.cmd 'wa'
	else
		log.info('change did not saved', 'markdown', 'unmodifiable buffer')
	end
end)
m('n', '<esc>', function()
	require('notify').dismiss { pending = true, silent = true }
	vim.cmd 'noh'
end)
m({ 'n', 'x' }, '$', '^')
m({ 'n', 'x' }, '^', '$')
m({ 'n', 'x' }, '<cr>', function()
	local special_ft = { 'ssr', 'qf' }
	if table_contains(special_ft, vim.bo.ft) then
		return '<cr>'
	else
		if vim.bo.filetype == 'rust' then
			return ':RustLsp '
		else
			return ':Make '
		end
	end
end, { expr = true })
m({ 'n', 'x' }, '<s-cr>', function()
	if vim.bo.ft == 'ssr' then
		return '<s-cr>'
	else
		return ':!'
	end
end, { expr = true })
m({ 'n', 'x' }, '<del>', '<c-d>')
m('t', '<esc>', '<c-\\><c-n>')
m('n', 'gf', function()
	local cfile = vim.fn.expand '<cfile>'

	if is_url(cfile) then
		vim.ui.open(cfile)
	else
		select.file_nav()
	end
end)
m({ 'n', 'v' }, '{', '<c-b>')
m({ 'n', 'v' }, '}', '<c-f>')
m({ 'n', 'o', 'x' }, 'w', function()
	require('spider').motion 'w'
end)
m({ 'n', 'o', 'x' }, 'e', function()
	require('spider').motion 'e'
end)
m({ 'n', 'o', 'x' }, 'b', function()
	require('spider').motion 'b'
end)

-- NOTE: emacs keybind
m('!', '<c-a>', '<home>')
m('!', '<c-e>', '<end>')
m('!', '<c-k>', '<right><c-c>v$hs')
m('!', '<c-u>', '<c-c>v^s')
m('!', '<a-d>', '<right><c-c>ves')
m('!', '<a-f>', '<c-right>')
m('!', '<a-b>', '<c-left>')

-- move by block (treesitter)
m('n', '<up>', '<cmd>Treewalker Up<cr>')
m('n', '<down>', '<cmd>Treewalker Down<cr>')
m('n', '<right>', '<cmd>Treewalker Right<CR>')
m('n', '<left>', '<cmd>Treewalker Left<CR>')

-- swapping items (treesitter)
m({ 'n', 'v' }, '<c-p>', '<cmd>Treewalker SwapUp<cr>')
m({ 'n', 'v' }, '<c-n>', '<cmd>Treewalker SwapDown<cr>')
m({ 'n', 'v' }, '<c-f>', '<cmd>Treewalker SwapRight<cr>')
m({ 'n', 'v' }, '<c-b>', '<cmd>Treewalker SwapLeft<cr>')

m({ 'n', 'x' }, '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
m({ 'n', 'x' }, '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')

-- m({ 'n', 'i', 'c', 'x' }, '<c-tab>', '<cmd>tabnext<cr>')
-- m({ 'n', 'i', 'c', 'x' }, '<c-s-tab>', '<cmd>tabprevious<cr>')

-- NOTE: select ui
m({ 'n', 'x' }, '/', select.text_search)
m({ 'n', 'x' }, '?', select.references)
m({ 'n', 'x' }, '"', select.git)
m({ 'n', 'x' }, "'", select.terminal)
