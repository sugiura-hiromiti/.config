vim.opt.fo = { j = true }
vim.o.title = true
vim.bo.shiftwidth = 3
vim.bo.tabstop = 3
vim.bo.softtabstop = 3
vim.opt.fileencoding = 'utf-8'
vim.opt.list = true
vim.opt.listchars = { tab = '│ ' }
vim.opt.pumblend = 40
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.autowriteall = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.autochdir = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.laststatus = 3
vim.opt.termguicolors = true
vim.diagnostic.config { virtual_text = true }

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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
require 'user_defined'

if vim.g.neovide then
	require 'gui'
end
