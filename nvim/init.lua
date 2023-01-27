if vim.fn.expand '%:p' == '' then
	vim.cmd [[e $MYVIMRC]]
end

-- `vim.opt`
local p = vim.opt
p.list = true
p.listchars = { tab = '│ ' }
p.pumblend = 22
p.relativenumber = true
p.number = true
p.autowriteall = true
p.termguicolors = true
p.clipboard:append { 'unnamedplus' }
p.autochdir = true
p.laststatus = 0
vim.g.editorconfig = true
vim.o.cot = 'menu,menuone,noselect'

local aucmd = vim.api.nvim_create_autocmd
-- Just using `set fo-=cro` won't work since many filetypes set/expand `formatoption`
aucmd('filetype', {
	callback = function()
		p.fo = { j = true }
		p.shiftwidth = 3
		p.tabstop = 3
		p.softtabstop = 3
	end,
})

-- lazy
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

require('lazy').setup('plugins', { checker = { enable = true, frequency = 1 } })
require 'usrcmd'
require 'map'
