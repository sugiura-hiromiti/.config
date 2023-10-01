local map = vim.keymap.set
local ts_builtin = require 'telescope.builtin'

local nv = { 'n', 'v' }
local ic = { 'i', 'c' }
local nox = { 'n', 'o', 'x' }
map(
	'i',
	'<c-[>',
	'<c-[><cmd>update | lua vim.lsp.buf.format{async=true}<cr>',
	{ desc = 'autosave & autoformat when entering normal mode' }
)
map(nv, '$', '^', { desc = 'move cursor to the end of line' })
map(nv, '^', '$', { desc = 'move cursor to the start of line' })
map(nv, ',', '@:', { desc = 'repeat last ex command' })
map('n', '<esc>', function()
	require('notify').dismiss { pending = true, silent = true }
	vim.cmd 'noh'
end, { desc = 'clear notification and highlight' })
map({ 'i', 'c', 's' }, '<c-n>', '<down>', { desc = 'move down cursor' })
map({ 'i', 'c', 's' }, '<c-p>', '<up>', { desc = 'move up cursor' })
map(ic, '<c-b>', '<left>', { desc = 'move left cursor' })
map(ic, '<c-f>', '<right>', { desc = 'move right cursor' })
map(ic, '<c-a>', '<home>', { desc = 'move cursor to the start of context' })
map(ic, '<c-e>', '<end>', { desc = 'move cursor to the end of line' })
map(ic, '<c-d>', '<del>', { desc = 'delete character under cursor' })
map(ic, '<c-k>', '<right><c-c>v$hs', { desc = 'delete to the end of line' })
map(ic, '<c-u>', '<c-c>v^s', { desc = 'delete to the start of line' })
map({ 'n', 'v' }, 'k', 'gk', { desc = 'move cursor to the visually previous line' })
map({ 'n', 'v' }, 'j', 'gj', { desc = 'move cursor to the visually next line' })
map('i', '<c-t>', '<c-c>hxpa', { desc = 'exchange two characters right of the cursor' })
map('n', '<c-t>', 'hxp', { desc = 'exchange two characters right of the cursor' })
map(ic, '<a-d>', '<right><c-c>ves', { desc = 'delete to the end of word' })
map(ic, '<a-f>', '<c-right>', { desc = 'move cursor to the end of word' })
map(ic, '<a-b>', '<c-left>', { desc = 'move cursor to the start of word' })
map(nv, '<tab>', require('todo-comments').jump_next, { desc = 'jump to next todo comment' })
map(nv, '<s-tab>', require('todo-comments').jump_prev, { desc = 'jump to previous todo comment' })
map('n', '<cr>', ':Make ', { desc = 'execute `Make` command' })
map('n', '<s-cr>', ':!', { desc = 'execute shell command' })
map(nv, '<left>', '<c-w><', { desc = 'decrease window width' })
map(nv, '<down>', '<c-w>+', { desc = 'increase window height' })
map(nv, '<up>', '<c-w>-', { desc = 'decrease window height' })
map(nv, '<right>', '<c-w>>', { desc = 'increase window width' })
map('n', 't', '<cmd>tabnext<cr>', { desc = 'go to next tab' })
map(nox, 'w', function()
	require('spider').motion 'w'
end, { desc = 'move cursor to the start of next word' })
map(nox, 'e', function()
	require('spider').motion 'e'
end, { desc = 'move cursor to the end of next word' })
map(nox, 'b', function()
	require('spider').motion 'b'
end, { desc = 'move cursor to the start of previous word' })
map(nv, '<space>t', ts_builtin.builtin, { desc = 'open Telescope prompt' }) -- Telescope
map(
	'n',
	'<space>o',
	ts_builtin.lsp_dynamic_workspace_symbols,
	{ desc = 'search workspace symbols' }
)
map('n', '<space>d', ts_builtin.diagnostics, { desc = 'search diagnostics' })
map(nv, '/', ts_builtin.live_grep, { desc = 'grep texts in current directory' })
map('n', '<space>b', ts_builtin.buffers, { desc = 'search buffers' })
map(
	'n',
	'<space>f',
	require('telescope').extensions.smart_open.smart_open,
	{ desc = 'fuzzy search files smartly' }
)
map('n', '<space>c', '<cmd>TodoTelescope<cr>', { desc = 'search todo comments' })
map(
	'n',
	'<space>n',
	require('telescope').extensions.notify.notify,
	{ desc = 'search notifications' }
)
map(
	'n',
	'<space>z',
	require('telescope').extensions.zoxide.list,
	{ desc = 'search zoxided directory' }
)
map(nv, '<space>a', vim.lsp.buf.code_action, { desc = 'code action' })
map(
	'n',
	'<space>j',
	ts_builtin.lsp_references,
	{ desc = 'open jump list of outline under the cursor' }
)
map('n', '<space>r', vim.lsp.buf.rename, { desc = 'rename symbol' })
map('n', '<space>h', vim.lsp.buf.hover, { desc = 'show hover information' })
map(nv, '<c-j>', vim.diagnostic.goto_next, { desc = 'go to next diagnostic' })
map(nv, '<c-k>', vim.diagnostic.goto_prev, { desc = 'go to previous diagnostic' })

-- q: what function does assign to `<bs>`?
