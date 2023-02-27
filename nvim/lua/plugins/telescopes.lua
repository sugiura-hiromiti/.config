return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
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
					smart_open = { show_scores = true },
					zoxide = {
						mappings = {
							default = {
								after_action = function(selection)
									print(selection.path .. ': ' .. selection.z_score)
								end,
							},
							['<c-x>'] = { action = z_utl.create_basic_command 'sp' },
							['<s-cr>'] = {
								keepinsert = true,
								action = function(selec)
									require('telescope.builtin').fd { cwd = selec.path }
								end,
							},
						},
					},
				},
			}
			require('telescope').load_extension 'smart_open'
		end,
	},
	{
		'danielfalk/smart-open.nvim',
		branch = '0.1.x',
	},
	'jvgrootveld/telescope-zoxide',
}
