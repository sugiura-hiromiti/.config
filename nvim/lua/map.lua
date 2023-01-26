local map = vim.keymap.set
local ls = require 'luasnip'

local function ctr_p()
	if ls.choice_active() then
		return function()
			ls.change_choice(1)
		end
	else
		return '<down>'
	end
end

local function ctr_n()
	if ls.choice_active then
		return function()
			ls.change_choice(-1)
		end
	else
		return '<up>'
	end
end

map('i', '<c-[>', '<c-[><cmd>update | lua vim.lsp.buf.format{async=true}<cr>')
map({ 'n', 'v' }, '$', '^') -- swap $ & ^
map({ 'n', 'v' }, '^', '$')
map({ 'n', 'v' }, ',', '@:') --repeat previous command
map('n', '<esc>', function()
	require('notify').dismiss { pending = true, silent = true }
	vim.cmd 'noh'
end) --clear notification and highlight
map({ 'i', 'c', 's' }, '<c-n>', ctr_p()) --emacs keybind
map({ 'i', 'c', 's' }, '<c-p>', ctr_n())
map({ 'i', 'c' }, '<c-b>', '<left>')
map({ 'i', 'c' }, '<c-f>', '<right>')
map({ 'i', 'c' }, '<c-a>', '<home>')
map({ 'i', 'c' }, '<c-e>', '<end>')
map({ 'i', 'c' }, '<c-d>', '<del>')
map({ 'i', 'c' }, '<c-k>', '<right><c-c>v$hs')
map({ 'i', 'c' }, '<c-u>', '<c-c>v^s')
map({ 'i', 'c' }, '<a-d>', '<right><c-c>ves')
map({ 'i', 'c' }, '<a-f>', '<c-right>')
map({ 'i', 'c' }, '<a-b>', '<c-left>')
map({ 'n', 'v' }, '<tab>', require('todo-comments').jump_next)
map({ 'n', 'v' }, '<s-tab>', require('todo-comments').jump_prev)
map('n', '<cr>', ':Make ') -- execute shell command
map('n', '<s-cr>', ':!')
map({ 'i', 'n', 'v' }, '<a-left>', '<c-w><') -- change window size
map({ 'i', 'n', 'v' }, '<a-down>', '<c-w>+')
map({ 'i', 'n', 'v' }, '<a-up>', '<c-w>-')
map({ 'i', 'n', 'v' }, '<a-right>', '<c-w>>')
map('n', 't', require('telescope.builtin').builtin) -- Telescope
map('n', '<space>o', require('telescope.builtin').lsp_document_symbols)
map('n', '<space>d', require('telescope.builtin').diagnostics)
map('n', '<space>f', require('telescope').extensions.smart_open.smart_open)
map('n', '<space>c', '<cmd>TodoTelescope<cr>')
map('n', '<space>n', require('telescope').extensions.notify.notify)
map({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action)
map('n', '<space>j', require('telescope.builtin').lsp_references) --`j` stands for jump
map('n', '<space>r', vim.lsp.buf.rename)
map('n', '<space>h', vim.lsp.buf.hover)
map({ 'n', 'v' }, '<c-j>', vim.diagnostic.goto_next)
map({ 'n', 'v' }, '<c-k>', vim.diagnostic.goto_prev)
