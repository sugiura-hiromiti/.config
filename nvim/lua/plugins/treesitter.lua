return {
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
	{
		'cshuaimin/ssr.nvim',
		config = function()
			require('ssr').setup {
				max_height = 50,
				keymaps = {
					replace_all = '<s-cr>',
				},
			}
		end,
	},
	{
		'sugiura-hiromichi/nvim-gps',
		opts = {},
	},
}
