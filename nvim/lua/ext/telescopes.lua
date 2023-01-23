return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		config = function()
			require('telescope').setup {
				defaults = {
					layout_strategy = 'vertical',
					mappings = {
						i = {
							['<a-j>'] = require('telescope.actions').preview_scrolling_down,
							['<a-k>'] = require('telescope.actions').preview_scrolling_up,
						},
					},
					winblend = 20,
					dynamic_preview_title = true,
				},
				extensions = {
					file_browser = { hidden = true, hide_parent_dir = true },
					smart_open = { show_scores = true },
				},
			}
			require('telescope').load_extension 'smart_open'
		end,
	},
	'nvim-telescope/telescope-file-browser.nvim',
	{
		'danielfalk/smart-open.nvim',
		branch = '0.1.x',
	},
}
