local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol',
			before = function(entry, vim_item)
				vim_item.menu = ({
					nvim_lsp = 'LSP',
					spell = 'Spl',
					zsh = 'Zsh',
					buffer = 'Buf',
					luasnip = 'Snp',
					treesitter = 'TS',
					nvim_lua = 'Lua',
					path = 'Path',
					nvim_lsp_signature_help = 'Sign',
					cmdline = 'Vim'
				})[entry.source.name]
				return vim_item
			end,
		}),
	},
	mapping = cmp.mapping.preset.insert({
		['<up>'] = cmp.mapping.scroll_docs(-10),
		['<down>'] = cmp.mapping.scroll_docs(10),
		--		['<C-Space>'] = cmp.mapping.complete(),
		['<tab>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
		['<S-tab>'] = cmp.mapping.close(),
		['<c-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's', 'c' }),
		['<c-p>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's', 'c' }),
	}),
	experimental = {
		ghost_text = true
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'nvim_lsp_signature_help' }
	},
}

cmp.setup.cmdline('/', {
	sources = cmp.config.sources({
		{ name = 'nvim_lsp_document_symbol' },
		{ name = 'buffer' }
	})
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'cmdline' }
	})
})

--see more detail at https://github.com/neovim/nvim-lspconfig
local on_attach = function(client, bufnr)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--rust_analyzer
require('lspconfig').rust_analyzer.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {
			completion = {
				snippets = {
					custom = {
						todo = {
							postfix = 'td',
							body = [[todo!(==============================================================
				[${receiver}]
				   ${1=simple, concrete, logical}.
					==============================================================);]],
							description = 'custom todo! snippet',
							scope = 'expr'
						}
					}
				}
			},
			hover = {
				actions = {
					reference = {
						enable = true
					}
				}
			},
			inlayHints = {
				closingBraceHints = {
					minLines = 0
				},
				lifetimeElisionHints = {
					enable = 'always',
					useParameterNames = true
				},
				maxLength = 0,
				typeHints = {
					hideNamedConstructor = false
				}
			},
			lens = {
				implementations = {
					enable = false
				}
			},
			rustfmt = {
				rangeFormatting = {
					enable = true
				}
			},
			semanticHighlighting = {
				operator = {
					specialization = {
						enable = true
					}
				}
			},
			typing = {
				autoClosingAngleBrackets = {
					enable = true
				}
			},
			workspace = {
				symbol = {
					search = {
						kind = 'all_symbols'
					}
				}
			}
		}
	}
}

--lua
require 'lspconfig'.sumneko_lua.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	-- Server-specific settings...
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}
