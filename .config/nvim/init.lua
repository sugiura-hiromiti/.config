vim.cmd 'colo iceberg'

local filenam = vim.fn.expand('%:p') --XXX            default open
if filenam == '' then
   vim.cmd [[e $MYVIMRC]]
end

local autocmd = vim.api.nvim_create_autocmd --XXX     command
autocmd('bufwritepre', {
   pattern = { '*.rs', '*.lua', '*.cpp', '*.md', '*.html', '*.toml', '*.json' },
   callback = function() vim.lsp.buf.format { async = true } end
})
autocmd({ 'filetype' }, {
   pattern = { 'terminal', 'help' },
   command = 'wincmd L'
})

local opt = vim.opt --XXX                             variable
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.cursorcolumn = true
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
opt.laststatus = 3
opt.statusline = '%t%#Normal#%=%#StatusLine#%{strftime("%m/%d %H:%M %a")}'
local g = vim.g
g.python3_host_prog = os.getenv 'HOMEBREW_PREFIX' .. '/bin/python3'
g.node_host_prog = os.getenv 'HOMEBREW_PREFIX' .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv 'RUBY_HOST'

local map = vim.keymap.set --XXX                      mapping
local nv = { 'n', 'v' }
map('n', '<esc>', ':noh<cr>') --<esc> to noh
map('n', '<up>', '"zdd<up>"zP') --move line
map('n', '<down>', '"zdd"zp')
map('v', '<up>', '"zx<up>"zP`[V`]')
map('v', '<down>', '"zx"zp`[V`]')
map(nv, ',', '@:') --repeat previous command
map('i', '<c-n>', '<down>') --emacs keybind
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<c-c>^i')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-t>', '<c-c><left>"zx"zpa')
map('i', '<c-y>', '<c-r>"')
map('i', '<a-d>', '<right><c-c>ves')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left>')
map(nv, '<', '<c-w>W') --split pane and change size
map(nv, '>', '<c-w>w')
map('n', 't', require 'telescope.builtin'.builtin) --Telescope
map('n', '<space>m', require 'telescope.builtin'.marks)
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)
map('n', '<space>b', require 'telescope.builtin'.buffers)
map(nv, '<space>r', require 'telescope.builtin'.registers)
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map(nv, '<space>a', '<cmd>Lspsaga code_action<CR>') --lspsaga
map('n', '<space>n', '<cmd>Lspsaga rename<cr>')
map('n', '<space>j', '<cmd>Lspsaga lsp_finder<cr>')
map('n', '<space>h', '<cmd>Lspsaga hover_doc<cr>')
map('n', '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
map('n', '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
map('n', '<A-t>', '<cmd>Lspsaga open_floaterm<CR>')
map('t', '<A-t>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])

require 'plugins'
require 'lsp'
