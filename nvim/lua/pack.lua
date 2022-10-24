require 'packer'.startup(function(use) -- XXX: package
   use 'wbthomason/packer.nvim'
   use 'nvim-lua/plenary.nvim'
   use 'folke/tokyonight.nvim'
   use { 'folke/todo-comments.nvim', config = function() require 'todo-comments'.setup {} end }
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
   use 'williamboman/mason.nvim'
   use 'williamboman/mason-lspconfig.nvim'
   use 'neovim/nvim-lspconfig'
   use  'hrsh7th/nvim-cmp'
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
