return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup {
				ensure_installed = {
					'rust_analyzer@nightly',
					'html',
					'cssls',
					'jsonls',
				},
			}
		end,
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			require('lspconfig').rust_analyzer.setup {
				capabilities = capabilities,
				settings = {
					['rust-analyzer'] = {
						hover = { actions = { reference = { enable = true } } },
						inlayHints = {
							closingBraceHints = { minLines = 0 },
							lifetimeElisionHints = { enable = 'always', ParameterNames = true },
							maxLength = 0,
							typeHints = { hideNamedConstructor = false },
						},
						lens = { implementations = { enable = false } },
						rustfmt = { rangeFormatting = { enable = true } },
						semanticHighlighting = { operator = { specialization = { enable = true } } },
						typing = { autoClosingAngleBrackets = { enable = true } },
						workspace = { symbol = { search = { kind = 'all_symbols' } } },
					},
				},
			}
			require('lspconfig').sumneko_lua.setup {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim' } },
						workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}
			require('lspconfig').sourcekit.setup {
				filetypes = { 'swift', 'objective-c', 'objective-cpp' },
				single_file_support = true,
				capabilities = capabilities,
			}
			require('lspconfig').clangd.setup { capabilities = capabilities }
			require('lspconfig').html.setup { capabilities = capabilities, init_options = { provideFormatter = false } }
			require('lspconfig').cssls.setup { capabilities = capabilities }
			require('lspconfig').bashls.setup { capabilities = capabilities }
			require('lspconfig').yamlls.setup { capabilities = capabilities }
			require('lspconfig').jsonls.setup { capabilities = capabilities }
			require('lspconfig').taplo.setup { capabilities = capabilities }
			require('lspconfig').marksman.setup { capabilities = capabilities }
			require('lspconfig').texlab.setup {
				filetypes = { 'tex', 'plaintex', 'bib', 'markdown' },
				capabilities = capabilities,
			}
		end,
	},
	{
		'glepnir/lspsaga.nvim',
		branch = 'main',
		config = function()
			require('lspsaga').setup {
				scroll_preview = { scroll_down = '<a-j>', scroll_up = '<a-k>' },
				lightbulb = { enable = false },
				finder = { vsplit = '<c-v>', split = '<c-x>' },
				rename = { in_select = false },
				symbol_in_winbar = { enable = false },
			}
		end,
	},
	{
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local nls = require 'null-ls'
			local fmt = nls.builtins.formatting
			nls.setup {
				sources = {
					fmt.dprint.with { filetypes = { 'markdown', 'json', 'toml' } },
					fmt.stylua,
					fmt.prettier.with { filetypes = { 'css', 'html', 'yaml' } },
					fmt.beautysh.with { extra_args = { '-t' } },
					fmt.swiftformat,
				},
			}
		end,
	},
	{
		'jayp0521/mason-null-ls.nvim',
		config = function()
			require('mason-null-ls').setup { ensure_installed = { 'beautysh' } }
		end,
	},
}
