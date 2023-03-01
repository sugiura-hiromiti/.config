return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('catppuccin').setup {
				background = {
					light = 'latte',
					dark = 'frappe',
				},
				integrations = { semantic_tokens = true },
			}
			vim.cmd 'colo catppuccin'
		end,
	},
}
