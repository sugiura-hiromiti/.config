local autocmd = vim.api.nvim_create_autocmd
--local blacklist = { 'TelescopePrompt', 'TelescopeResults', 'frecency' }

if os.getenv 'PROFILE_NAME' == 'hotkey' then
	autocmd('vimenter', {
		callback = function()
			vim.o.background = 'dark'
		end
	})
end
autocmd('vimenter', {
	command = 'set tabstop=3'
})
autocmd('vimenter', {
	command = 'set softtabstop=3'
})
autocmd('vimenter', {
	command = 'set shiftwidth=3'
})
autocmd({ 'vimenter', 'colorscheme' }, {
	command = 'hi! link VertSplit Normal | hi! link WinBar StatusLine'
})
autocmd({ 'insertleave', 'bufwritepre' }, {
	pattern = { '*.rs', '*.lua', '*.cpp' },
	callback = function() vim.lsp.buf.format { async = true } end
})
autocmd({ 'filetype' }, {
	pattern = { 'terminal', 'help' },
	command = 'wincmd H'
})
autocmd({ 'bufwritepost' }, {
	pattern = { 'plugins.lua', 'lsp.lua' },
	command = 'PackerCompile'
})
autocmd({ 'vimenter' }, {
	command = 'PackerCompile'
})

local stl_refresh = { 'BufEnter', 'BufWinEnter', 'CursorMoved', 'CursorMovedI' }
autocmd(stl_refresh, {
	pattern = { '*.lua', '*.cpp', '*.rs', '*.txt' },
	callback = function()
		--local stl_l = [[%#Normal#%=%(]]
		local stl_r = [[%=%(%v│%t│%{&filetype}%)]]
		local sym = require 'lspsaga.symbolwinbar'.get_symbol_node()
		if sym then
			local start = string.find(sym, '')
			if start ~= nil then
				start = start + 4
				sym = string.sub(sym, start)
			end
			sym = string.gsub(sym, '->', '')
			sym = string.gsub(sym, '', '')
		else
			sym = ''
		end
		vim.wo.stl = sym .. stl_r
	end
})

-----------------------------------------------------userdefined
local mycmd = vim.api.nvim_create_user_command

mycmd('Ayu', function(opts)
	vim.g.ayucolor = opts.args
	vim.cmd 'colo ayu'
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		return { 'light', 'mirage', 'dark' }
	end
})
