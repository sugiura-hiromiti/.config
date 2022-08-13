require 'packer'.startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'overcache/NeoSolarized'--colorscheme
   use 'NLKNguyen/papercolor-theme'
   use 'chriskempson/vim-tomorrow-theme'
   use { 'catppuccin/nvim', as = 'catppuccin', run = ':CatppuccinCompile' }
   use 'sainnhe/edge'
   use 'sainnhe/everforest'
   use 'ah-y/flatui.vim'
   use 'humanoid-colors/vim-humanoid-colorscheme'
   use 'ah-y/iceberg.vim'
   use 'freeo/vim-kalisi'
   use 'arcticicestudio/nord-vim'
   use 'zanglg/nova.nvim'
   use 'google/vim-colorscheme-primary'
   use 'jsit/toast.vim'
   use 'folke/tokyonight.nvim'
   use 'nvim-lualine/lualine.nvim'--UI related
   use 'norcalli/nvim-colorizer.lua'
   use 'kyazdani42/nvim-web-devicons'
   use 'amdt/sunset'
   use 'tribela/vim-transparent'
   use 'cohama/lexima.vim'--utility
   use { 'neoclide/coc.nvim', branch = 'release' }--lsp
   use 'mfussenegger/nvim-dap'--dap
end)

--setup of catppuccin moved to color_randomizer

require 'lualine'.setup({
   options = {
      always_divide_middle = false,
      globalstatus = true,
   },
   extensions = {
      'nvim-dap-ui', 'quickfix'
   }
})
