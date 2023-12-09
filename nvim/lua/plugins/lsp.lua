local symbols = require 'symbols'

return {
	{
		'onsails/lspkind.nvim',
		config = function()
			require('lspkind').init {
				symbol_map = symbols,
			}
		end,
	},
	{
		'williamboman/mason.nvim',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = {
			ensure_installed = {
				'rust_analyzer@nightly',
				'lua_ls'
			},
		},
	},
	{
		'SmiteshP/nvim-navic',
		opts = {
			icons = symbols,
			lsp = { auto_attach = true, preference = { 'marksman', 'texlab' } },
			highlight = true,
			click = true,
		}
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local on_attach = function(client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(bufnr)
				end
			end
			require('lspconfig').rust_analyzer.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					['rust-analyzer'] = {
						hover = { actions = { reference = { enable = true } } },
						inlayHints = {
							closingBraceHints = { minLines = 20 },
							lifetimeElisionHints = { enable = 'always', ParameterNames = true },
							maxLength = 20,
							typeHints = { hideNamedConstructor = false },
						},
						lens = { implementations = { enable = true } },
						rustfmt = { rangeFormatting = { enable = true } },
						semanticHighlighting = { operator = { specialization = { enable = true } } },
						typing = { autoClosingAngleBrackets = { enable = true } },
						workspace = { symbol = { search = { kind = 'all_symbols' } } },
					},
				},
			}
			require('lspconfig').lua_ls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim', 'hs' } },
						workspace = {
							library = vim.api.nvim_get_runtime_file('', true),
							checkThirdParty = 'Disable',
						},
						format = {
							enable = true,
						},
					},
				},
			}
			require('lspconfig').sourcekit.setup {
				filetypes = { 'swift', 'objective-c', 'objective-cpp' },
				single_file_support = true,
				capabilities = capabilities,
				on_attach = on_attach,
			}
			require('lspconfig').clangd.setup { capabilities = capabilities, on_attach = on_attach }
			--require('lspconfig').pylsp.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').html.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').cssls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').marksman.setup { capabilities = capabilities, on_attach = on_attach }
		end,
	},
	{
		'nvimtools/none-ls.nvim',
		config = function()
			require('null-ls').setup {
				sources = {
					require('null-ls').builtins.hover.printenv,
					require('null-ls').builtins.diagnostics.zsh,
				},
			}
		end,
	},
}
