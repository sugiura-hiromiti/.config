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

local usrcmd = vim.api.nvim_create_user_command
usrcmd('Make', function(opts)
	local cmd = '<cr> '
	local args = opts.args
	local extra = ''
	local ft = vim.bo.filetype
	if ft == 'rust' then -- langs which have to compile
		cmd = '!cargo '
		if args == '' then
			args = 'r -q'
		else
			args = table.remove(opts.fargs, 1)
			table.insert(opts.fargs, 1, '-q')
			for _, a in ipairs(opts.fargs) do
				extra = ' ' .. extra .. ' ' .. a
			end
		end
	elseif ft == 'cpp' or ft == 'c' then
		cmd = '!make '
	elseif ft == 'swift' or ft == 'lua' then -- langs which has interpreter
		cmd = '!' .. ft .. ' ' .. vim.fn.expand '%:t' .. ' '
	elseif ft == 'html' then -- markup language
		cmd = '!open ' .. vim.fn.expand '%:t' .. ' '
	end

	vim.cmd(cmd .. args .. extra)
end, { nargs = '*' })

require 'ext'
require 'map'
