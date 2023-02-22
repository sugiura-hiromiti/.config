local my_au = vim.api.nvim_create_augroup('my_au', {})
local aucmd = vim.api.nvim_create_autocmd

-- Just using `set fo-=cro` won't work since many filetypes set/expand `formatoption`
aucmd('filetype', {
	group = my_au,
	callback = function()
		vim.opt.fo = { j = true }
		vim.opt.shiftwidth = 3
		vim.opt.tabstop = 3
		vim.opt.softtabstop = 3
	end,
})

aucmd('modechanged', {
	group = my_au,
	callback = function()
		local handle = assert(io.open('/tmp/wz_nvim.txt', 'r'), 'could not opened wz_nvim.txt')
		local bg = handle:read '*a'
		handle:close()
		if bg ~= vim.o.background then
			vim.o.background = bg
		end
	end,
})

local usrcmd = vim.api.nvim_create_user_command
usrcmd('Make', function(opts)
	local cmd = '<cr> '
	local args = opts.args
	local extra = ''
	local ft = vim.bo.filetype
	if ft == 'rust' then -- langs which have to be compiled
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
		local file = vim.fn.expand '%:t'
		if args == 't' then
			file = 'test.' .. ft
			args = ''
		end
		cmd = '!' .. ft .. ' ' .. file .. ' '
	elseif ft == 'html' then -- markup language
		cmd = '!open ' .. vim.fn.expand '%:t' .. ' '
	end

	vim.cmd(cmd .. args .. extra)
end, { nargs = '*' })

usrcmd('RmSwap', function(_)
	vim.cmd '!rip ~/.local/share/nvim/swap'
end, {})
