local on_attach = function(client, bufnr)
	-- if client.server_capabilities.inlayHintProvider then
	-- 	vim.lsp.inlay_hint.enable()
	-- 	vim.notify(vim.lsp.inlay_hint.is_enabled(), vim.log.levels.INFO, {})
	-- else
	-- 	vim.notify 'inlay_hint not'
	-- end
end

vim.g.rustaceanvim = {
	tools = {
		test_executor = 'background',
	},
	server = {
		default_settings = {
			['rust-analyzer'] = {
				assist = {
					preferSelf = true,
				},
				cargo = {
					allTargets = false,
					targetDir = vim.fn.expand '~/.cache/rust-analyzer/target',
				},
				check = {
					command = 'clippy',
				},
				completion = {
					fullFunctionSignatures = { enable = true },
					-- privateEditable = { enable = true },
					termSearch = { enable = true },
				},
				diagnostics = { experimental = { enable = true }, styleLints = { enable = true } },
				hover = {
					actions = { reference = { enable = true } },
					maxSubstitutionLength = 40,
					memoryLayout = {
						niches = true,
					},
					show = { traitAssocItems = 5 },
				},
				inlayHints = {
					bindingModeHints = { enable = true },
					closingBraceHints = { minLines = 20 },
					closureCaptureHints = { enable = true },
					closureReturnTypeHints = { enable = 'always' },
					discriminantHints = { enable = 'always' },
					expressionAdjustmentHints = { enable = 'always' },
					genericParameterHints = { lifetime = { enable = true }, type = { enable = true } },
					implicitDrops = { enable = true },
					implicitSizedBoundHints = { enable = true },
					lifetimeElisionHints = { enable = 'always', useParameterNames = true },
					rangeExclusiveHints = { enable = true },
				},
				interpret = { tests = true },
				lens = {
					enable = true,
					references = {
						adt = { enable = true },
						enumVariant = { enable = true },
						method = { enable = true },
						trait = { enable = true },
					},
				},
				lru = { capacity = 512 },
				rustfmt = { --overrideCommand = { 'cargo', ' fmt' },
					rangeFormatting = { enable = true },
				},
				semanticHighlighting = { operator = { specialization = { enable = true } } },
				workspace = { symbol = { search = { kind = 'all_symbols' } } },
			},
		},
	},
}

return {
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.lsp.config('*', {
				capabilities = capabilities,
				on_attach = on_attach,
			})
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
				'lua_ls',
				'asm_lsp',
				'zls',
				'clangd',
				'nil_ls',
				'cssls',
				'taplo',
				'sourcekit',
				'marksman',
				'markdown_oxide',
				'jsonls',
				'dprint',
				'html',
				'yamlls',
				'fish_lsp',
				'terraformls',
				'graphql',
				'ts_ls',
				'eslint',
				-- 'gh_actions_ls',
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
	-- {
	-- 	'luckasRanarison/tailwind-tools.nvim',
	-- 	name = 'tailwind-tools',
	-- 	build = 'UpdateRemotePlugins',
	-- 	opts = {
	-- 		server = { settings = { includeLanguages = { rust = 'html' } }, on_attach = on_attach },
	-- 		extension = {
	-- 			patterns = {
	-- 				rust = { 'class:%s*["\']([^"\']+)["\']' },
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		'mrcjkb/rustaceanvim',
		lazy = false,
	},
	{
		'mrcjkb/haskell-tools.nvim',
		lazy = false, -- This plugin is already lazy
		config = function()
			require('telescope').load_extension 'ht'
		end,
	},
	-- { 'nanotee/sqls.nvim' },
}
