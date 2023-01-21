return {
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { 'bash', 'markdown_inline' },
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			}
		end,
	},
	{
		'nvim-treesitter/nvim-treesitter-textobjects',
		config = function()
			require('nvim-treesitter.configs').setup {
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
							['ab'] = '@block.outer',
							['ib'] = '@block.inner',
						},
						selection_modes = {
							['@block.outer'] = 'V',
						},
					},
					swap = {
						enable = true,
						swap_next = { ['<space>s'] = '@parameter.inner' },
						swap_previous = { ['<space>S'] = '@parameter.inner' },
					},
					move = {
						--enable = true,
						set_jumps = true,
						goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
						goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
						goto_previous_start = { ['[m'] = '@function.outer', ['[]'] = '@class.outer' },
						goto_previous_end = { ['[M'] = '@function.outer', ['[['] = '@class.outer' },
					},
				},
			}
		end,
	},
}
