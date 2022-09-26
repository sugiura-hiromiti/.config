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
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
      config = function()
         require 'telescope'.setup {
            pickers = {
               findfiles = {
                  hidden = true
               }
            },
            extensions = {
               file_browser = {
                  hidden = true
               },
               fzf = {
                  fuzzy = true,
               }
            }
         }
         require 'telescope'.load_extension 'frecency'
         require 'telescope'.load_extension 'file_browser'
         require 'telescope'.load_extension 'fzf'
      end }
   use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } --XXX telescope
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use 'williamboman/mason.nvim' --XXX                                    lsp
   use 'williamboman/mason-lspconfig.nvim'
   use 'neovim/nvim-lspconfig'
   use { 'glepnir/lspsaga.nvim', branch = 'main' }
   use 'onsails/lspkind.nvim'
   use 'hrsh7th/nvim-cmp' --XXX                                           completion source
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-nvim-lsp-signature-help'
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
   use { 'mfussenegger/nvim-dap',
      config = function()
         local function lldb_path()
            local hndl = io.popen('which lldb-vscode')
            if not hndl then return nil end
            local rslt = hndl:read 'a'
            hndl:close()
            return rslt
         end

         local dap = require 'dap'
         dap.adapters.lldb = {
            type = 'executable',
            command = lldb_path(),
            name = 'lldb'
         }
         dap.configurations.rust = {
            {
               name = 'Launch',
               type = 'lldb',
               request = 'launch',
               program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
               end,
               cwd = '${workspaceFolder}',
               stopOnEntry = false,
               args = {},
            },
         }
         dap.configurations.c = dap.configurations.rust
         dap.configurations.cpp = dap.configurations.rust
      end }
end)
