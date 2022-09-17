local autocmd = vim.api.nvim_create_autocmd
--local blacklist = { 'TelescopePrompt', 'TelescopeResults', 'frecency' }

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
autocmd({ 'vimenter', 'colorschemepre' }, {
	callback = function()
		if vim.o.background == 'light' then
			vim.cmd 'let ayucolor="light"'
		else
			vim.cmd 'let ayucolor="mirage"'
		end
	end
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
