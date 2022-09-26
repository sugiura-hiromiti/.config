local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

local cmp = require 'cmp' --XXX nvim-cmp
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
               nvim_lsp = 'L',
               buffer = 'B',
               luasnip = 'S',
               nvim_lua = 'Lua',
            })[entry.source.name]
            return vim_item
         end,
      }),
   },
   mapping = cmp.mapping.preset.insert({
      ['<up>'] = cmp.mapping.scroll_docs(-10),
      ['<down>'] = cmp.mapping.scroll_docs(10),
      ['<tab>'] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Insert,
         select = true,
      },
      ['<c-c>'] = cmp.mapping.close(),
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--rust_analyzer
require('lspconfig').rust_analyzer.setup {
   capabilities = capabilities,
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
   capabilities = capabilities,
   settings = {
      Lua = {
         runtime = {
            version = 'LuaJIT',
         },
         diagnostics = {
            globals = { 'vim' },
         },
         workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
         },
         telemetry = {
            enable = false,
         },
      },
   },
}

--html
require 'lspconfig'.html.setup {
   capabilities = capabilities
}

--toml
require 'lspconfig'.taplo.setup {
   capabilities = capabilities
}
