require 'packer'.startup(function(use)
   use 'wbthomason/packer.nvim'
   use { 'amdt/sunset',
      config = function()
         vim.g.sunset_latitude = 35.03
         vim.g.sunset_longitude = 135.79
      end }
   use 'cocopon/iceberg.vim'
   use 'kyazdani42/nvim-web-devicons'
   use { 'windwp/nvim-autopairs', after = 'nvim-cmp',
      config = function()
         require 'nvim-autopairs'.setup {
            map_c_h = true
         } --	 If you want insert `(` after select function or method item
         require('cmp').event:on(
            'confirm_done',
            require('nvim-autopairs.completion.cmp').on_confirm_done()
         )
      end }
   use 'nvim-lua/plenary.nvim'
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',--XXX telescope
      config = function()
         require 'telescope'.setup {
            pickers = {
               findfiles = {
                  hidden = true
               }
            },
            extensions = {
               file_browser = {
                  hidden = true,
                  hide_parent_dir = true
               },
            }
         }
         require 'telescope'.load_extension 'frecency'
         require 'telescope'.load_extension 'file_browser'
      end }
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use 'williamboman/mason.nvim' --XXX                                    lsp
   use 'williamboman/mason-lspconfig.nvim'
   use 'neovim/nvim-lspconfig'
   use { 'glepnir/lspsaga.nvim', branch = 'main' }
   use 'hrsh7th/nvim-cmp' --XXX                                           completion source
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-nvim-lsp-signature-help'
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
end)
