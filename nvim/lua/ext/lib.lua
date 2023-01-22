local colo_name = function()
	if os.getenv 'TERM_PROGRAM' == 'iTerm.app' then
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
			'catppuccin/nvim',
			name = 'catppuccin',
			config = function()
				require('catppuccin').setup {
					flavour = 'latte',
					background = {
						light = 'latte',
						dark = 'latte',
					},
					integrations = { lsp_saga = true, notify = false, noice = false, semantic_tokens = true },
				}
				vim.cmd 'Catppuccin latte'
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
