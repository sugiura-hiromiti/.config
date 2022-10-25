require 'packer'.startup(function(use) -- XXX: package
   use 'wbthomason/packer.nvim'
   use 'nvim-lua/plenary.nvim'
   use 'folke/tokyonight.nvim'
   use  'folke/todo-comments.nvim', config = function() require 'todo-comments'.setup {} end }
   use { 'folke/noice.nvim', event = 'VimEnter', config = function() require 'noice'.setup() end }
   use 'MunifTanjim/nui.nvim'
   use 'rcarriga/nvim-notify'
   use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
      require 'nvim-treesitter.configs'.setup {
         auto_install = true,
         highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
         }
      }
   end }
   use 'nvim-tree/nvim-web-devicons'
   use { 'windwp/nvim-autopairs', config = function() require 'nvim-autopairs'.setup { map_c_h = true } end }
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', config = function() -- telescope
      require 'telescope'.setup { extensions = { file_browser = { hidden = true, hide_parent_dir = true }, } }
      require 'telescope'.load_extension 'frecency'
      require 'telescope'.load_extension 'file_browser'
   end }
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use{ 'williamboman/mason.nvim',config=function()
require'mason'.setup()
   end}
   use{ 'williamboman/mason-lspconfig.nvim',config=function()

require 'mason-lspconfig'.setup {
   ensure_installed = {
      'sumneko_lua',
      'rust_analyzer@nightly'
   }
}
   end}
   use{ 'neovim/nvim-lspconfig',config=function()
local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

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
   end}
   use{ 'hrsh7th/nvim-cmp',config=function()

local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   window = {
      completion = cmp.config.window.bordered()
      --documentation = cmp.config.window.bordered()
   },
   mapping = cmp.mapping.preset.insert({
      ['<c-u>'] = cmp.mapping.scroll_docs(-10),
      ['<c-d>'] = cmp.mapping.scroll_docs(10),
      ['<c-c>'] = cmp.mapping.abort(),
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
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'buffer' }
   }
}

cmp.setup.cmdline('/', {
   sources = {
      { name = 'buffer' },
      { name = 'nvim_lsp_document_symbol' }
   }
})

cmp.setup.cmdline(':', {
   sources = {
      { name = 'path' },
      { name = 'cmdline' },
   }
})
   end}
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-nvim-lsp-signature-help'
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'hrsh7th/cmp-nvim-lsp-document-symbol'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
end)
