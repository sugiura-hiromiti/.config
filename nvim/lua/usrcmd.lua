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
		if os.getenv 'TERM_PROGRAM' == 'WezTerm' then
			local handle = assert(io.open('/tmp/wz_nvim.txt', 'r'), 'could not opened wz_nvim.txt')
			local bg = handle:read '*a'
			handle:close()
			if bg ~= vim.o.background then
				vim.o.background = bg
			end
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
		if args == '' or string.sub(opts.fargs[1], 1, 2) == '--' then
			args = 'r '
		else
			args = table.remove(opts.fargs, 1) -- insert 1st argument to `args`
		end
		table.insert(opts.fargs, 1, '-q')
		for _, a in ipairs(opts.fargs) do
			extra = ' ' .. extra .. ' ' .. a
		end
	elseif ft == 'cpp' or ft == 'c' then
		cmd = '!make '
	elseif ft == 'swift' or ft == 'lua' or ft == 'python' then -- langs which has interpreter
		local file = vim.fn.expand '%:t'
		local interpreter = ft
		if interpreter == 'python' then
			interpreter = interpreter .. '3'
		end
		if args == 't' then
			file = 'test.' .. ft
			args = ''
		end
		cmd = '!' .. interpreter .. ' ' .. file .. ' '
	elseif ft == 'html' then -- markup language
		cmd = '!open ' .. vim.fn.expand '%:t' .. ' '
	elseif ft == 'markdown' then
		cmd = 'MarkdownPreviewToggle '
	end

	vim.cmd(cmd .. args .. extra)
end, { nargs = '*' })

usrcmd('RmSwap', function(_)
	vim.cmd '!rip ~/.local/share/nvim/swap'
end, {})
