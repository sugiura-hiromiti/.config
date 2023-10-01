return {
	{
		'AckslD/nvim-FeMaco.lua',
		config = true,
	},
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
			local on_attach = function(client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint(bufnr)
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
							checkThirdParty = false,
						},
						telemetry = { enable = false },
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
			require('lspconfig').pylsp.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').html.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').cssls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').bashls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').yamlls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').jsonls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').taplo.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').marksman.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').texlab.setup {
				filetypes = { 'tex', 'plaintex', 'bib', 'markdown' },
				capabilities = capabilities,
				on_attach = on_attach,
			}
		end,
	},
	{
		-- a: null-ls.nvim will be archived from August 2023
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local nls = require 'null-ls'
			local builtins = nls.builtins
			local fmt = builtins.formatting
			local hov = builtins.hover
			local diag = builtins.diagnostics
			--local cmp = builtins.completion
			nls.setup {
				sources = {
					fmt.dprint.with { filetypes = { 'markdown', 'json', 'toml' } },
					fmt.stylua,
					fmt.prettier.with { filetypes = { 'css', 'yaml' } },
					fmt.swiftformat,
					fmt.yapf,
					hov.printenv,
					diag.zsh,
				},
			}
		end,
	},
}
