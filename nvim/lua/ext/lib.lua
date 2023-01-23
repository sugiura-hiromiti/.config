local colo_name = function()
	local term = os.getenv 'TERM_PROGRAM'
	if term == 'iTerm.app' or term == 'Warp.app' then
		return {
			'sugiura-hiromichi/catppuccin',
			config = function()
				vim.cmd 'colo catppuccin'
				require('catppuccin').setup {
					integrations = { lsp_saga = true, notify = false, noice = false, semantic_tokens = true },
				}
			end,
		}
	else
		return {
			'AlexvZyl/nordic.nvim',
			branch = 'main',
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
