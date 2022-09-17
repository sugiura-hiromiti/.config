local opt = vim.opt
opt.relativenumber = true
opt.number = true
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
opt.list = true
opt.ruler = false
opt.cmdheight = 1
opt.shortmess = 'atT'
opt.listchars = {
	tab = '│ ',
}

local g = vim.g
g.python3_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/python3'
g.node_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv('RUBY_HOST')
g.ts_highlight_lua = true
--g.mapleader = ' '
