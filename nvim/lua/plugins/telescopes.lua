return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		config = function()
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
				},
			}
			require('telescope').load_extension 'smart_open'
		end,
	},
	{
		'danielfalk/smart-open.nvim',
		branch = '0.1.x',
	},
}
