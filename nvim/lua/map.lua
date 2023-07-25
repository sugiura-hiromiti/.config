local map = vim.keymap.set
local ts_builtin = require 'telescope.builtin'

local nv = { 'n', 'v' }
local ic = { 'i', 'c' }
local nox = { 'n', 'o', 'x' }
map('i', '<c-[>', '<c-[><cmd>update | lua vim.lsp.buf.format{async=true}<cr>')
map(nv, '$', '^') -- swap $ & ^
map(nv, '^', '$')
map(nv, ',', '@:') --repeat previous command
map('n', '<esc>', function()
	require('notify').dismiss { pending = true, silent = true }
	vim.cmd 'noh'
end) --clear notification and highlight
map({ 'i', 'c', 's' }, '<c-n>', '<down>') --emacs keybind
map({ 'i', 'c', 's' }, '<c-p>', '<up>')
map(ic, '<c-b>', '<left>')
map(ic, '<c-f>', '<right>')
map(ic, '<c-a>', '<home>')
map(ic, '<c-e>', '<end>')
map(ic, '<c-d>', '<del>')
map(ic, '<c-k>', '<right><c-c>v$hs')
map(ic, '<c-u>', '<c-c>v^s')
map('i', '<c-t>', '<c-c>hxpa') -- `<c-t>` for insert & normal & cmdline mode
map('n', '<c-t>', 'hxp')
map(ic, '<a-d>', '<right><c-c>ves')
map(ic, '<a-f>', '<c-right>')
map(ic, '<a-b>', '<c-left>')
map(nv, '<tab>', require('todo-comments').jump_next)
map(nv, '<s-tab>', require('todo-comments').jump_prev)
map('n', '<cr>', ':Make ') -- execute shell command
map('n', '<s-cr>', ':!')
map(nv, '<left>', '<c-w><') -- change window size
map(nv, '<down>', '<c-w>+')
map(nv, '<up>', '<c-w>-')
map(nv, '<right>', '<c-w>>')
map(nox, 'w', function() -- spider
	require('spider').motion 'w'
end)
map(nox, 'e', function()
	require('spider').motion 'e'
end)
map(nox, 'b', function()
	require('spider').motion 'b'
end)
map({ 'n', 'v', 'i' }, '<bs>', '<cmd>FuzzyMotion<cr>') -- fuzzy motion
map(nv, 't', ts_builtin.builtin) -- Telescope
map('n', '<space>o', ts_builtin.lsp_document_symbols)
map('n', '<space>d', ts_builtin.diagnostics)
map(nv, '/', ts_builtin.live_grep)
map('n', '<space>f', require('telescope').extensions.smart_open.smart_open)
map('n', '<space>c', '<cmd>TodoTelescope<cr>')
map('n', '<space>n', require('telescope').extensions.notify.notify)
map('n', '<space>z', require('telescope').extensions.zoxide.list)
map(nv, '<space>a', vim.lsp.buf.code_action)
map('n', '<space>j', ts_builtin.lsp_references) --`j` stands for jump
map('n', '<space>r', vim.lsp.buf.rename)
map('n', '<space>h', vim.lsp.buf.hover)
map(nv, '<c-j>', vim.diagnostic.goto_next)
map(nv, '<c-k>', vim.diagnostic.goto_prev)

-- q: what function does assign to `<bs>`?
