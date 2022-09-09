---------------------mason
require 'mason'.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

---------------------mason-lspconfig
require 'mason-lspconfig'.setup({
	ensure_installed = { 'sumneko_lua', 'rust_analyzer' }
})

---------------------lspconfig
-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = 'LSP',
				spell = 'Spl',
				zsh = 'Zsh',
				buffer = 'Buf',
				luasnip = 'Snp',
				treesitter = 'TS',
				--				calc = '[Calculator',
				nvim_lua = 'Lua',
				path = 'Path',
				nvim_lsp_signature_help = 'Sign',
				cmdline = 'Vim'
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<a-k>'] = cmp.mapping.scroll_docs(-10),
		['<a-j>'] = cmp.mapping.scroll_docs(10),
		--		['<C-Space>'] = cmp.mapping.complete(),
		['<tab>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
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
	local bufopts = { silent = true, buffer = bufnr }
	vim.keymap.set('n', '<space>s', vim.lsp.buf.signature_help, bufopts)

	if client.server_capabilities.document_highlight then
		vim.cmd [[
      hi! LspReferenceRead gui=bold cterm=bold guibg=DarkGray
      hi! LspReferenceText gui=bold cterm=bold guibg=DarkGray
      hi! LspReferenceWrite gui=bold cterm=bold guibg=DarkGray
    ]]
		vim.api.nvim_create_augroup('lsp_document_highlight', {})
		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			group = 'lsp_document_highlight',
			buffer = 0,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd('CursorMoved', {
			group = 'lsp_document_highlight',
			buffer = 0,
			callback = vim.lsp.buf.clear_references,
		})
	end
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
				--[[
				references = {
					adt = {
						enable = true
					},
					enumVariant = {
						enable = true
					},
					method = {
						enable = true
					},
					trait = {
						enable = true
					}
				}
			]] --
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
