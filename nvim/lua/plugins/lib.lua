local colo_name = function()
	local handle = io.popen 'uname'
	local os_name = handle:read '*a'
	handle:close()
	if os_name == 'Darwin\n' then
		return {
			'sugiura-hiromichi/catppuccin',
			name = 'catppuccin',
			config = function()
				require('catppuccin').setup {
					integrations = { semantic_tokens = true },
				}
				vim.cmd 'colo catppuccin'
			end,
		}
	else
		return {
			'sugiura-hiromichi/vim-kalisi',
			config = function()
				vim.cmd 'colo kalisi'
			end,
		}
	end
end

return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	colo_name(),
}
