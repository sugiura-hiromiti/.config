vim.cmd 'colo tokyonight'
if vim.fn.expand('%:p') == '' then vim.cmd [[e $MYVIMRC]] end

local p = vim.opt
p.pumblend = 20
p.relativenumber = true
p.number = true
p.softtabstop = 3
p.shiftwidth = 3
p.expandtab = true
p.autowriteall = true
p.termguicolors = true
p.clipboard:append { 'unnamedplus' }
p.autochdir = true
p.laststatus = 0

local map = vim.keymap.set
map('n', '<esc>', '<cmd>noh<cr>') --<esc> to noh
map('i', '<c-]>', [[<c-]><cmd>update | lua vim.lsp.buf.format{async=true} | lua print'save & formatted'<cr>]])
map({ 'n', 'v' }, ',', '@:') --repeat previous command
map('i', '<c-n>', '<down>') --emacs keybind
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-u>', '<c-c>v^s')
map('i', '<a-d>', '<right><c-c>ves')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left>')
map('n', '<tab>', function() require 'todo-comments'.jump_next() end)
map('n', '<S-tab>', function() require 'todo-comments'.jump_prev() end)
map({ 'n', 'v' }, '<a-h>', '<c-w>h')
map({ 'n', 'v' }, '<a-j>', '<c-w>j')
map({ 'n', 'v' }, '<a-k>', '<c-w>k')
map({ 'n', 'v' }, '<a-l>', '<c-w>l')
map('n', 't', require 'telescope.builtin'.builtin) -- Telescope
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)
map('n', '<space>j', require 'telescope.builtin'.lsp_references) --`j` stands for jump
map('n', '<space>b', require 'telescope.builtin'.buffers)
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map('n', '<space>c', '<cmd>TodoTelescope<cr>')
map('n', '<space>n', '<cmd>Telescope notify<cr>')
map({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action)
map('n', '<space>r', vim.lsp.buf.rename)
map('n', '<space>h', vim.lsp.buf.hover)
map('n', '<c-j>', vim.diagnostic.goto_next)
map('n', '<c-k>', vim.diagnostic.goto_prev)



require'pack'
--require 'cmp'
--require 'lsp'
