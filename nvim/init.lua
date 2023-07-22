if vim.fn.expand '%:p' == '' then
	vim.cmd [[e $MYVIMRC]]
end

vim.opt.fileencoding = 'utf-8'
vim.opt.list = true
vim.opt.listchars = { tab = '│ ' }
--vim.opt.listchars = { tab = ' ·' }
vim.opt.pumblend = 22
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.autowriteall = true
vim.opt.termguicolors = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.autochdir = true
vim.opt.laststatus = 0
vim.opt.scrolloff = 10
vim.g.updatetime = 10
vim.g.editorconfig = true
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup 'plugins'

require 'usrcmd'
require 'map'

-- #fa0b1c #2048ab #48eb0c #f7f7f7 #3c4c55
