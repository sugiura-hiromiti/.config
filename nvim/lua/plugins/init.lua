-- listup plugins here which is difficult to classify
return {
	-- Library
	'kkharji/sqlite.lua',
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				auto_install = true,
				ignore_install = { 'markdown' },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			}
		end,
	},
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',

	{
		'chrisgrieser/nvim-spider',
	},
	{ 'f-person/auto-dark-mode.nvim', config = true },
	{
		'polirritmico/monokai-nightasty.nvim',
		config = function()
			vim.opt.background = 'light'
			vim.cmd 'colo monokai-nightasty'
		end,
	},
}
