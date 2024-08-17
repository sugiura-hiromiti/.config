return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		config = function()
			local t = require 'telescope'
			local a = require 'telescope.actions'
			t.setup {
				defaults = {
					layout_strategy = 'flex',
					layout_config = {
						flex = {
							flip_columns = 160,
						},
					},
					mappings = {
						i = {
							['<a-j>'] = a.preview_scrolling_down,
							['<a-k>'] = a.preview_scrolling_up,
							['<c-d>'] = a.nop,
							['<c-u>'] = a.nop,
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
				extensions = {},
			}
			t.load_extension 'smart_open'
			t.load_extension 'ui-select'
		end,
	},
	--	{
	--		'FabianWirth/search.nvim',
	--		opts = {
	--			mappings = { next = '<c-h>', prev = '<s-bs>' },
	--			tabs = {
	--				{
	--					'smart_open',
	--					function(_)
	--						t.extensions.smart_open.smart_open()
	--					end,
	--				},
	--				{
	--					'Notify',
	--					function(_)
	--						t.extensions.notify.notify()
	--					end,
	--				},
	--				{
	--					'builtin',
	--					function(_)
	--						require('telescope.builtin').builtin()
	--					end,
	--				},
	--				{
	--					'doc_symbol',
	--					function(_)
	--						require('telescope.builtin').lsp_document_symbols { show_line = true }
	--					end,
	--				},
	--				{
	--					'TODO',
	--					function(_)
	--						vim.cmd 'TodoTelescope'
	--					end,
	--				},
	--			},
	--		},
	--	},
}
