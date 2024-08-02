return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local on_attach = function(client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr })
				end
				if client.server_capabilities.documentSymbolProvider then
					require('nvim-navic').attach(client, bufnr)
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
						experimental = { procAttrMacros = true },
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
						format = { enable = false },
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
			require('lspconfig').jsonls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').docker_compose_language_service.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').dockerls.setup { capabilities = capabilities, on_attach = on_attach }
			require('lspconfig').tsserver.setup { capabilities = capabilities, on_attach = on_attach }
		end,
	},
}
