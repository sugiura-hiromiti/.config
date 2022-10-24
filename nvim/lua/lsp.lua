require 'mason'.setup()
require 'mason-lspconfig'.setup {
   ensure_installed = {
      'sumneko_lua',
      'rust_analyzer@nightly'
   }
}

local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
--[[ NOTE: cap
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--]]


-- NOTE: rust_analyzer
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

-- NOTE: lua
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
