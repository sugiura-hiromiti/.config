local builtin = require 'telescope.builtin'
local tlscp = require 'telescope'
return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		keys = {
			{ 't', builtin.builtin, desc = 'open telescope prompt', mode = { 'n', 'v' } },
			{
				'<space>o',
				function()
					if vim.bo.ft == 'lua' then
						builtin.lsp_document_symbols()
					else
						builtin.lsp_dynamic_workspace_symbols()
					end
				end,
				desc = 'search symbols',
			},
			{ '<space>d', builtin.diagnostics, desc = 'search diagnostics' },
			{ '/', builtin.live_grep, desc = 'grep texts in current workspace', mode = { 'n', 'v' } },
			{ '<space>b', builtin.buffers, desc = 'search buffers' },
			{ '<space>m', builtin.keymaps, desc = 'search keymaps' },
			{ '<space>j', builtin.lsp_references, desc = 'open jump list of outline under the cursor' },
			{ '<space>f', '<cmd>Telescope frecency<cr>', desc = 'fuzzy search files smartly' },
			{ '<space>c', '<cmd>TodoTelescope<cr>', desc = 'search todo comments' },
			{ '<space>n', tlscp.extensions.notify.notify, desc = 'search notifications' },
			{ '<space>e', tlscp.extensions.file_browser.file_browser, desc = 'open telescope-file-bowser' },
		},
		config = function()
			local acts = require 'telescope.actions'
			tlscp.setup {
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
					smart_open = { show_scores = true },
					file_browser = {
						hidden = true,
						hijack_netrw = true,
						collapse_dirs = true,
						respect_gitignore = false,
					},
				},
			}
			tlscp.load_extension 'frecency'
			tlscp.load_extension 'file_browser'
		end,
	},
	'nvim-telescope/telescope-frecency.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
}
