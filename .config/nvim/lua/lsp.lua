local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert({
      ['<up>'] = cmp.mapping.scroll_docs(-10),
      ['<down>'] = cmp.mapping.scroll_docs(10),
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
   sources = {
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
   },
}
cmp.setup.cmdline(':', {
   sources = cmp.config.sources({
      { name = 'cmdline' }
   })
})

require 'mason'.setup()
require 'mason-lspconfig'.setup {
   ensure_installed = { 'sumneko_lua', 'rust_analyzer@nightly', 'html', 'taplo', 'json-lsp', 'marksman' }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--rust_analyzer
require('lspconfig').rust_analyzer.setup {
   capabilities = capabilities,
   settings = {
      ["rust-analyzer"] = {
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

--json
require 'lspconfig'.jsonls.setup {
   capabilities = capabilities
}

--markdown
require 'lspconfig'.marksman.setup {
   capabilities = capabilities
}
