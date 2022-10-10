require 'packer'.startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'kyazdani42/nvim-web-devicons'
   use { 'windwp/nvim-autopairs', config = function() require 'nvim-autopairs'.setup { map_c_h = true } end }
   use 'nvim-lua/plenary.nvim'
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', config = function() --XXX telescope
      require 'telescope'.setup { pickers = { findfiles = { hidden = true } },
         extensions = { file_browser = { hidden = true, hide_parent_dir = true }, } }
      require 'telescope'.load_extension 'frecency'
      require 'telescope'.load_extension 'file_browser'
   end }
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use { 'williamboman/mason.nvim', config = function() require 'mason'.setup() end } --XXX lsp
   use { 'williamboman/mason-lspconfig.nvim', config = function()
      require 'mason-lspconfig'.setup {
         ensure_installed = { 'sumneko_lua', 'rust_analyzer@nightly', 'html', 'taplo', 'json-lsp', 'marksman' }
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
      require 'mason-lspconfig'.setup_handlers {
         function(server_name)
            require 'lspconfig'[server_name].setup {
               capabilities = capabilities
            }
         end
      }
   end }
   use 'neovim/nvim-lspconfig'
   use { 'glepnir/lspsaga.nvim', branch = 'main' }
   use { 'hrsh7th/nvim-cmp', config = function()
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
   end } --XXX                                completion source
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
end)
