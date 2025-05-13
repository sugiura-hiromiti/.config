local on_attach = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
	-- if client.server_capabilities.documentSymbolProvider then
	-- 	print 'attaching'
	-- end
end

return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			local lsp_conf = require 'lspconfig'
			--			vim.no
			lsp_conf.rust_analyzer.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					['rust-analyzer'] = {
						-- cargo = {
						-- 	allTargets = false,
						-- },
						-- checkOnSave = {
						-- 	allTargets = false,
						-- },
						diagnostics = { styleLints = { enable = true } },
						hover = {
							actions = { reference = { enable = true } },
							show = { traitAssocItems = 5 },
						},
						inlayHints = {
							closingBraceHints = { minLines = 20 },
							lifetimeElisionHints = { enable = 'always', ParameterNames = true },
							maxLength = 20,
							typeHints = { hideNamedConstructor = false },
							--						implicitDrops = { enable = true },
						},
						interpret = { tests = true },
						lens = { implementations = { enable = true } },
						rustfmt = { overrideCommand = 'cargo +nightly fmt', rangeFormatting = { enable = true } },
						semanticHighlighting = { operator = { specialization = { enable = true } } },
						typing = { autoClosingAngleBrackets = { enable = true } },
						workspace = { symbol = { search = { kind = 'all_symbols' } } },
						experimental = { procAttrMacros = true },
						completion = {
							fullFunctionSignatures = { enable = true },
							privateEditable = { enable = true },
							termSearch = { enable = true },
						},
					},
				},
			}
			lsp_conf.hls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
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
			lsp_conf.markdown_oxide.setup {
				capabilities = vim.tbl_deep_extend('force', capabilities, {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
				on_attach = on_attach,
			}
			lsp_conf.zls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.sourcekit.setup {
				filetypes = { 'swift', 'objective-c', 'objective-cpp' },
				single_file_support = true,
				capabilities = capabilities,
				on_attach = on_attach,
			}
			lsp_conf.gopls.setup {}
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
			-- lsp_conf.marksman.setup { capabilities = capabilities, on_attach = on_attach }
			-- lsp_conf.sqlls.setup {
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- 	root_dir = '~/.config/sql-language-server/',
			-- }
			-- lsp_conf.sqls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.taplo.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.html.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				init_options = { embeddedLanguages = { markdown = true } },
			}
			lsp_conf.cssls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.docker_compose_language_service.setup {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			lsp_conf.dockerls.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.ts_ls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				-- init_options = {
				-- 	plugins = {
				-- 		{
				-- 			name = '`vue/typescript-plugin',
				-- 			location = '/home/xsugiurah/.nvm/versions/node/v20.10.0/lib/node_modules/@vue/typescript-plugin',
				-- 			languages = { 'javascript', 'typescript', 'vue' },
				-- 		},
				-- 	},
				-- },
				-- filetypes = {
				-- 	'javascript',
				-- 	'typescript',
				-- 	'vue',
				-- },
			}
			lsp_conf.nil_ls.setup {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					['nil'] = {
						formatting = {
							command = { 'nixfmt' },
						},
					},
				},
			}
			lsp_conf.asm_lsp.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.phpactor.setup { capabilities = capabilities, on_attach = on_attach }
			lsp_conf.vuels.setup { filetypes = { 'vue' }, capabilities = capabilities, on_attach = on_attach }
			-- lsp_conf.volar.setup { capabilities = capabilities, on_attach = on_attach }
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
						edit = 'e',
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
						exec_action = 'e',
						toggle_or_jump = 'o',
					},
				},
				finder = {
					max_height = 0.8,
					right_width = 0.6,
					default = 'def+ref+imp',
					keys = {
						shuttle = 'e',
						toggle_or_open = 'o',
						vsplit = 'v',
						split = 'x',
					},
				},
				hover = {
					--					open_link = 'o',
				},
				lightbulb = { enable = false },
				beacon = { enable = true },
			}
		end,
	},
	-- {
	-- 	'nvim-java/nvim-java',
	-- 	config = function()
	-- 		require('java').setup {
	-- 			jdk = {
	-- 				auto_install = false,
	-- 			},
	-- 		}
	--
	-- 		local capabilities = require('cmp_nvim_lsp').default_capabilities()
	-- 		require('lspconfig').jdtls.setup {
	-- 			capabilityes = capabilities,
	-- 			on_attach = on_attach,
	-- 			settings = {
	-- 				java = {
	-- 					configuration = {
	-- 						runtimes = {
	-- 							{
	-- 								name = '23',
	-- 								path = '/Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home/',
	-- 								default = true,
	-- 							},
	-- 						},
	-- 					},
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- },
	{
		'luckasRanarison/tailwind-tools.nvim',
		name = 'tailwind-tools',
		build = ':UpdateRemetePlugins',
		opts = {
			server = { settings = { includeLanguages = { rust = 'html' } }, on_attach = on_attach },
			extension = {
				patterns = {
					rust = { 'class:%s*["\']([^"\']+)["\']' },
				},
			},
		},
	},
}
