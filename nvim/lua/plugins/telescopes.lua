return {
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		keys = {
			{ 't', function ()
				require'telescope.builtin'.builtin()
			end, desc = 'open telescope prompt', mode = { 'n', 'v' } },
			{
				'<space>o',
				function()
					if vim.bo.ft == 'lua' then
						require'telescope.builtin'.lsp_document_symbols()
					else
						require'telescope.builtin'.lsp_dynamic_workspace_symbols()
					end
				end,
				desc = 'search symbols',
			},
			{ '<space>d', function ()
				require'telescope.builtin'.diagnostics()
			end, desc = 'search diagnostics' },
			{ '/', function ()
				require'telescope.builtin'.live_grep()
			end, desc = 'grep texts in current workspace', mode = { 'n', 'v' } },
			{ '<space>b', function ()
				require'telescope.builtin'.buffers()
			end, desc = 'search buffers' },
			{ '<space>m', function ()
				require'telescope.builtin'.keymaps()
			end, desc = 'search keymaps' },
			{ '<space>j', function ()
				require'telescope.builtin'.lsp_references()
			end, desc = 'open jump list of outline under the cursor' },
			{ '<space>f', '<cmd>Telescope frecency<cr>', desc = 'fuzzy search files smartly' },
			{ '<space>c', '<cmd>TodoTelescope<cr>', desc = 'search todo comments' },
			{ '<space>n', function ()
				require'telescope'.extensions.notify.notify()
			end, desc = 'search notifications' },
			{ '<space>e', function ()
				require'telescope'.extensions.file_browser.file_browser()
			end, desc = 'open telescope-file-bowser' },
		},
		config = function()
			local acts = require 'telescope.actions'
			require'telescope'.setup {
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
			require'telescope'.load_extension 'frecency'
			require'telescope'.load_extension 'file_browser'
		end,
	},
	'nvim-telescope/telescope-frecency.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
}
