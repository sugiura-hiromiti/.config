local map = vim.keymap.set
local nv = { 'n', 'v' }

--See commit c3364a3 for color_randomize

map(nv, ':', ';') --exchange : & ;
map(nv, ';', ':')
map('n', '<esc>', ':noh<cr>') --<esc> to noh
map('n', 'W', 'wi') --move & insert
map('n', 'E', 'ea')
map('n', 'B', 'bi')
map('n', '<a-k>', ':bprev<cr>') --buffer
map('n', '<a-j>', ':bnext<cr>')
map('n', '<up>', '"zdd<up>"zP') --move line
map('n', '<down>', '"zdd"zp')
map('v', '<up>', '"zx<up>"zP`[V`]')
map('v', '<down>', '"zx"zp`[V`]')
--ideas:mapping something to <left> & <right> in normal mode
map(nv, ',', '@:') --like '.', repeat previous command

--use <tab> instead <space> with neither lsp nor fuzzy commands
map('n', '<tab>b',
	function()
		if vim.o.background == 'light' then
			vim.o.background = 'dark'
		else
			vim.o.background = 'light'
		end
	end)
map('n', '<tab>f', vim.lsp.buf.format)
map('n', '<tab>d', '<cmd>bd<cr>')

--emacs keybind
map('i', '<c-n>', '<down>')
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<c-c>^i')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-t>', '<c-c><left>"zx"zpa')
map('i', '<c-y>', '<c-r>"')
map('i', '<a-d>', '<c-c>ciw')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left><left>')

--split pane and change size
map(nv, '<', '<c-w>W')
map(nv, '>', '<c-w>w')
map(nv, '_', ':<c-u>sp<cr>')
map(nv, '<bar>', ':<c-u>vs<cr>')
map(nv, '`', '<c-w>>')
map(nv, '-', '<c-w><')
map(nv, '\\', '<c-w>+')
map(nv, '=', '<c-w>-')

--Telescope
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>t', require 'telescope.builtin'.builtin)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>r', require 'telescope.builtin'.lsp_references)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)

--lspsaga
map("n", "<space>a", "<cmd>Lspsaga code_action<CR>")
map("v", "<space>a", "<cmd>Lspsaga range_code_action<CR>")
map("n", "<space>n", "<cmd>Lspsaga rename<CR>")
map("n", "<space>h", "<cmd>Lspsaga hover_doc<CR>")
map("n", "<A-t>", "<cmd>Lspsaga open_floaterm<CR>")
map("t", "<A-t>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
