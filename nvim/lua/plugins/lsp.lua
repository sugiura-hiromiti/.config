return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local lsp_conf = require 'lspconfig'
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local on_attach = function(client, bufnr)
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr })
				end
				if client.server_capabilities.documentSymbolProvider then
					require('nvim-navic').attach(client, bufnr)
				end
			end
			lsp_conf.rust_analyzer.setup {
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
			lsp_conf.lua_ls.setup {
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
			lsp_conf.sourcekit.setup {
				filetypes = { 'swift', 'objective-c', 'objective-cpp' },
				single_file_support = true,
				capabilities = capabilities,
				on_attach = on_attach,
			}
			lsp_conf.dprint.setup {
				filetypes = { 'javascript', 'typescript', 'json', 'jsonc', 'markdown', 'toml', 'yaml' },
				capabilities = capabilities,
				on_attach = on_attach,
			}
			lsp_conf.clangd.setup { capabilities = capabilities, on_attach = on_attach }
			--lsp_conf.pylsp.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.html.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.cssls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.marksman.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.jsonls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.docker_compose_language_service.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.dockerls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.tsserver.setup { capabilities = capabilities, on_attach = on_attach }
		end,
	},
}
