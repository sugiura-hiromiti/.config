require 'packer'.startup(function(use)
   use 'wbthomason/packer.nvim'
   use { 'catppuccin/nvim', as = 'catppuccin', run = ':CatppuccinCompile' } --colorscheme
   use 'folke/tokyonight.nvim'
   use 'google/vim-colorscheme-primary'
   use 'chriskempson/vim-tomorrow-theme'
   use 'jsit/toast.vim'
   use 'humanoid-colors/vim-humanoid-colorscheme'
   use 'NLKNguyen/papercolor-theme'
   use 'ah-y/flatui.vim'
   use 'ah-y/iceberg.vim'
   use 'zanglg/nova.nvim'
   use 'sainnhe/edge'
   use 'freeo/vim-kalisi'
   use 'arcticicestudio/nord-vim'
   use 'overcache/NeoSolarized'
   use 'sainnhe/everforest'
   use 'nvim-lualine/lualine.nvim'
   use 'norcalli/nvim-colorizer.lua'
   use 'kyazdani42/nvim-web-devicons'
   use 'amdt/sunset'
   use 'cohama/lexima.vim'
   use { 'neoclide/coc.nvim', branch = 'release' }
   use 'mfussenegger/nvim-dap'
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
