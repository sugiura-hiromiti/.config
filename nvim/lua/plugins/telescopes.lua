return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		config = function()
			local acts = require 'telescope.actions'
			require('telescope').setup {
				defaults = {
					layout_strategy = 'flex',
					layout_config = {
						flex = {
							flip_columns = 160,
							--flip_lines = 40,
						},
					},
					mappings = {
						i = {
							['<a-j>'] = acts.preview_scrolling_down,
							['<a-k>'] = acts.preview_scrolling_up,
							['<c-d>'] = acts.nop,
							['<c-u>'] = acts.nop,
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
					frecency = { show_scores = true },
					file_browser = {
						hidden = true,
						hijack_netrw = true,
						collapse_dirs = true,
						respect_gitignore = false,
					},
				},
			}
			require('telescope').load_extension 'frecency'
			require('telescope').load_extension 'file_browser'
		end,
	},
	'nvim-telescope/telescope-frecency.nvim',
	-- FIX: replace file-browser to find_files
	'nvim-telescope/telescope-file-browser.nvim',
}
