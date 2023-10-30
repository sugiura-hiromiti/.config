return {
	{
		'onsails/lspkind.nvim',
		config = function()
			require('lspkind').init {
				symbol_map = {
					Text = '󰉿',
					Method = '󰆧',
					Function = '󰊕',
					Constructor = '',
					Field = '󰜢',
					Variable = '󰀫',
					Class = '󰠱',
					Interface = '',
					Module = '',
					Property = '󰜢',
					Unit = '󰑭',
					Value = '󰎠',
					Enum = '',
					Keyword = '󰌋',
					Snippet = '',
					Color = '󰏘',
					File = '󰈙',
					Reference = '󰈇',
					Folder = '󰉋',
					EnumMember = '',
					Constant = '󰏿',
					Struct = '󰙅',
					Event = '',
					Operator = '󰆕',
					TypeParameter = '',
					Copilot = '',
				},
			}
		end,
	},
	{
		'AckslD/nvim-FeMaco.lua',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = true,
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
				'html',
				'cssls',
				'jsonls',
			},
		},
		--config = function() require('mason-lspconfig').setup end,
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
		'nvimtools/none-ls.nvim',
config = function() require('null-ls').setup{
			sources = {
				require('null-ls').builtins.formatting.dprint.with {
					filetypes = { 'markdown', 'json', 'toml' },
				},
				require('null-ls').builtins.formatting.stylua,
				require('null-ls').builtins.formatting.prettier.with { filetypes = { 'css', 'yaml' } },
				require('null-ls').builtins.formatting.swiftformat,
				require('null-ls').builtins.formatting.yapf,
				require('null-ls').builtins.hover.printenv,
				require('null-ls').builtins.diagnostics.zsh,
			},
		} end,
	},
}
