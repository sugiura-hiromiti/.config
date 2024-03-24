-- listup plugins here which is difficult to classify
return {
	-- Library
	'kkharji/sqlite.lua',
	{	'nvim-treesitter/nvim-treesitter',build=":TSUpdate"
},
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',

	-- TODO: cofig later
	{ 'lewis6991/gitsigns.nvim', config = true },
	{
		'TobinPalmer/Tip.nvim',
		event = 'VimEnter',
		init = function()
			require('tip').setup { seconds = 10, title = 'Tip!', url = 'https://vtip.43z.one' }
		end,
	},
	{
		'chrisgrieser/nvim-spider',
	},
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
			panel = { enable = false },
			suggestion = { enable = false },
		},
	},
	{ 'f-person/auto-dark-mode.nvim', config = true },
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('catppuccin').setup {
				background = { dark = 'frappe' },
				term_colors = true,
				dim_inactive = { enabled = true },
				styles = {
					keywords = { 'bold' },
					properties = { 'italic', 'bold' },
				},
			}
			vim.cmd 'colo catppuccin'
		end,
	},
}
