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
					frecency = {
						show_scores = true,
						workspaces = {
							['conf'] = '/Users/f/.config/',
							['nvim'] = '/Users/f/.config/nvim/',
							['prj'] = '/Users/f/Downloads/',
							['rust'] = '/Users/f/Downloads/rust/',
							['QwQ'] = '/Users/f/Downloads/QwQ/',
						},
					},
				},
			}
			require('telescope').load_extension 'frecency'
		end,
	},
	'nvim-telescope/telescope-frecency.nvim',
	{
		'FabianWirth/search.nvim',
		opts = {
			mappings = { next = '<bs>', prev = '<s-bs>' },
			tabs = {
				{
					'Frecency',
					function(_)
						require('telescope').extensions.frecency.frecency()
					end,
				},
				{
					'Buffer',
					function(opts)
						opts = opts or {}
						require('telescope.builtin').buffers(opts)
					end,
				},
				{
					'TODO',
					function(_)
						vim.cmd 'TodoTelescope'
					end,
				},
				{
					'Diagnostics',
					function(opts)
						opts = opts or {}
						require('telescope.builtin').diagnostics()
					end,
				},
				{
					'Notify',
					function(_)
						require('telescope').extensions.notify.notify()
					end,
				},
			},
		},
	},
}
