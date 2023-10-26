return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.4',
		config = function()
			local z_utl = require 'telescope._extensions.zoxide.utils'
			require('telescope').setup {
				defaults = {
					layout_strategy = 'vertical',
					layout_config = { vertical = { preview_cutoff = 0 } },
					mappings = {
						i = {
							['<a-j>'] = require('telescope.actions').preview_scrolling_down,
							['<a-k>'] = require('telescope.actions').preview_scrolling_up,
						},
					},
					winblend = 20,
					dynamic_preview_title = true,
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--hidden',
					},
				},
				extensions = {
					--smart_open = { show_scores = true },
					zoxide = {
						mappings = {
							default = {
								after_action = function(selection)
									print(selection.path .. ': ' .. selection.z_score)
								end,
							},
							['<c-x>'] = { action = z_utl.create_basic_command 'sp' },
						},
					},
					frecency = {
						show_scores = true,
					},
				},
			}
			require('telescope').load_extension 'frecency'
			require('telescope').load_extension 'macros'
		end,
	},
	{
		'nvim-telescope/telescope-frecency.nvim',
		dependencies = { 'kkharji/sqlite.lua' },
	},
	{
		'jvgrootveld/telescope-zoxide',
		dependencies = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},
	},
}
