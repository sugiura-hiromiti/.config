return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	{
		'sugiura-hiromichi/catppuccin',
		config = function()
			vim.cmd'colo catppuccin'
			require('catppuccin').setup {
				integrations = { lsp_saga = true, notify = false, noice = false, semantic_tokens = true },
			}
		end,
	},
}
