local autocmd = vim.api.nvim_create_autocmd

autocmd('vimenter', {
	callback = function()
		if os.getenv 'PROFILE_NAME' == 'hotkey' then
			vim.o.background = 'dark'
		end
	end
})
autocmd('vimenter', {
	command = 'set tabstop=3'
})
autocmd('vimenter', {
	command = 'set softtabstop=3'
})
autocmd('vimenter', {
	command = 'set shiftwidth=3'
})
autocmd('colorscheme', {
	command = 'hi! link VertSplit Normal'
})
autocmd({ 'insertleave', 'bufwritepre' }, {
	pattern = { '*.rs', '*.lua', '*.cpp' },
	callback = function() vim.lsp.buf.format { async = true } end
})
autocmd({ 'insertleave', 'bufwritepre' }, {
	callback = function()
		local blacklist = { 'TelescopePrompt', 'TelescopeResults', 'frecency' }
		local ft = vim.bo.filetype
		local is_black --nil on init
		for _, value in ipairs(blacklist) do
			if ft == value then
				is_black = true
				break
			end
		end
		if not is_black then
			vim.cmd 'update'
		end
	end
})
autocmd({ 'winenter' }, {
	pattern = { 'terminal', 'help' },
	command = 'wincmd H'
})

local stl_refresh = { 'BufEnter', 'BufWinEnter', 'CursorMoved', 'CursorMovedI' }
autocmd(stl_refresh, {
	callback = function()
		vim.wo.stl = require 'lspsaga.symbolwinbar'.get_symbol_node()
	end
})

-----------------------------------------------------usercmd
--local mycmd = vim.api.nvim_create_user_command
