local on_attach = function(client, bufnr)
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
end

return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('*', {
				capabilities = capabilities,
				on_attach = on_attach,
			})

			local rust = vim.lsp.config.rust_analyzer
			local rust_config = vim.tbl_deep_extend('force', rust, {
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
			})

			vim.lsp.config('rust_analyzer', rust_config)
			vim.lsp.config('lua_ls', {
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim', 'hs' } },
						workspace = {
							-- library = vim.api.nvim_get_runtime_file('', true),
							-- checkThirdParty = 'Apply',
						},
						format = { enable = false },
					},
				},
			})
			vim.lsp.config('markdown_oxide', {
				capabilities = vim.tbl_deep_extend('force', capabilities, {
					workspace = {
						didChangeWatchedFiles = {
							dynamicRegistration = true,
						},
					},
				}),
			})
			vim.lsp.config('sourcekit', {
				filetypes = { 'swift', 'objective-c', 'objective-cpp' },
				single_file_support = true,
			})
			vim.lsp.config('dprint', {
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
			})
			vim.lsp.config('html', { init_options = { embeddedLanguages = { markdown = true } } })
			-- vim.lsp.config('vuels', { filetypes = { 'vue' } })

			vim.lsp.enable {
				'rust_analyzer',
				'lua_ls',
				'hls',
				'asm_lsp',
				'zls',
				'clangd',
				'nil_ls',
				'cssls',
				'docker_compose_language_service',
				'dockerls',
				'taplo',
				'sourcekit',
				'sqls',
				'marksman',
				'markdown_oxide',
				'jsonls',
				'gopls',
				'dprint',
				'html',
				'vuels',
				'yamlls',
				-- 'postgres_lsp',
			}
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
	{
		'luckasRanarison/tailwind-tools.nvim',
		name = 'tailwind-tools',
		build = 'UpdateRemotePlugins',
		opts = {
			server = { settings = { includeLanguages = { rust = 'html' } }, on_attach = on_attach },
			extension = {
				patterns = {
					rust = { 'class:%s*["\']([^"\']+)["\']' },
				},
			},
		},
	},
	{ 'nanotee/sqls.nvim' },
}
