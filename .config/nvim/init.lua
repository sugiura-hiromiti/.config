vim.cmd 'colo iceberg'
local filenam = vim.fn.expand('%:p') --XXX            default open
if filenam == '' then
   vim.cmd [[e $MYVIMRC]]
end

local opt = vim.opt --XXX                             variable
opt.relativenumber = true
opt.signcolumn = 'no'
opt.softtabstop = 3
opt.shiftwidth = 3
opt.expandtab = true
opt.swapfile = false
opt.writebackup = false
opt.updatetime = 50
opt.mouse = 'a'
opt.autowriteall = true
opt.termguicolors = true
opt.clipboard:append { 'unnamedplus' }
opt.autochdir = true
opt.laststatus = 0

local g = vim.g
g.python3_host_prog = os.getenv 'HOMEBREW_PREFIX' .. '/bin/python3'
g.node_host_prog = os.getenv 'HOMEBREW_PREFIX' .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv 'RUBY_HOST'

local map = vim.keymap.set --XXX                      mapping
map('n', '<esc>', ':noh<cr>') --<esc> to noh
map({ 'n', 'v' }, ',', '@:') --repeat previous command
map('i', '<c-n>', '<down>') --emacs keybind
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-t>', '<c-c><left>"zx"zpa')
map('i', '<c-y>', '<c-r>"')
map('i', '<a-d>', '<right><c-c>ves')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left>')
map('n', '>', '<c-w>w')
map('n', '<', '<c-w>W')
map('n', '<space>w', function()
   vim.cmd 'wa'
   vim.lsp.buf.format { async = true }
end)
map('n', 't', require 'telescope.builtin'.builtin) --Telescope
map('n', '<space>m', require 'telescope.builtin'.marks)
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)
map('n', '<space>b', require 'telescope.builtin'.buffers)
map({ 'n', 'v' }, '<space>r', require 'telescope.builtin'.registers)
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map({ 'n', 'v' }, '<space>a', '<cmd>Lspsaga code_action<CR>') --lspsaga
map('n', '<space>n', '<cmd>Lspsaga rename<cr>')
map('n', '<space>j', '<cmd>Lspsaga lsp_finder<cr>')
map('n', '<space>h', '<cmd>Lspsaga hover_doc<cr>')
map('n', '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
map('n', '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
map('n', '<A-t>', '<cmd>Lspsaga open_floaterm<CR>')
map('t', '<A-t>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])

require 'plugins'
require 'lsp'
