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
					print 'attaching'
					--require('nvim-navic').attach(client, bufnr)
				end
			end
			lsp_conf.rust_analyzer.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					['rust-analyzer'] = {
						diagnostics = { styleLints = { enable = true } },
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
							checkThirdParty = 'Apply',
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
				filetypes = {
					'javascript',
					'typescript',
					'javascriptreact',
					'typescriptreact',
					'json',
					'jsonc',
					'markdown',
					'toml',
					'yaml',
				},
				capabilities = capabilities,
				on_attach = on_attach,
			}
			lsp_conf.clangd.setup { capabilities = capabilities, on_attach = on_attach }
			--lsp_conf.pylsp.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.marksman.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.taplo.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.html.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = { embeddedLanguages = { markdown = true } },
			}
			lsp_conf.cssls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.docker_compose_language_service.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.dockerls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.ts_ls.setup { capabilities = capabilities, on_attach = on_attach }
		end,
	},
	{
		'nvimdev/lspsaga.nvim',
		event = 'LspAttach',
		config = function()
			require('lspsaga').setup {
				symbol_in_winbar = {
					enable = false,
				},
				scroll_preview = {
					scroll_down = '<a-j>',
					scroll_up = '<a-k>',
				},
				callhierarchy = {
					keys = {
						edit = '<cr>',
						vsplit = 'v',
						split = 'x',
						shuttle = 'e',
					},
				},
				code_action = {
					show_server_name = true,
					extend_gitsigns = true,
				},
				diagnostic = {
					max_height = 0.8,
					extend_relatedInformation = true,
					keys = {
						exec_action = '<cr>',
						toggle_or_jump = 'o',
					},
				},
				finder = {
					max_height = 0.8,
					right_width = 0.6,
					default = 'def+ref+imp',
					keys = {
						shuttle = 'e',
						toggle_or_open = '<cr>',
						vsplit = 'v',
						split = 'x',
					},
				},
				hover = {
					open_link = '<cr>',
				},
				lightbulb = { enable = false },
				beacon = { enable = true },
			}
		end,
	},
}
