local opt = vim.opt
opt.relativenumber = true
opt.number = true
opt.tabstop = 3
opt.softtabstop = 3
opt.shiftwidth = 3
opt.expandtab = true
opt.cursorline = true
opt.cursorcolumn = true
opt.swapfile = false
opt.writebackup = false
opt.updatetime = 50
opt.mouse = 'a'
opt.autowriteall = true
opt.termguicolors = true
opt.laststatus = 0
opt.clipboard:append { 'unnamedplus' }
opt.autochdir = true
--opt.cmdheight = 0

local g = vim.g
g.python3_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/python3'
g.node_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv('RUBY_HOST')
g.ts_highlight_lua = true
--g.mapleader = ' '
