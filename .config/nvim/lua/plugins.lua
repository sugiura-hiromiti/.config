require 'packer'.startup(function(use)
   use 'wbthomason/packer.nvim'
   use 'overcache/NeoSolarized' --colorscheme
   use 'drewtempelmeyer/palenight.vim'
   use 'adrian5/oceanic-next-vim'
   use 'cormacrelf/vim-colors-github'
   use 'FrenzyExists/aquarium-vim'
   use 'GertjanReynaert/cobalt2-vim-theme'
   use 'saltdotac/citylights.vim'
   use 'haishanh/night-owl.vim'
   use 'NLKNguyen/papercolor-theme'
   use 'chriskempson/vim-tomorrow-theme'
   use { 'catppuccin/nvim', as = 'catppuccin', run = ':CatppuccinCompile' }
   use 'sainnhe/edge'
   use 'sainnhe/everforest'
   use 'ah-y/flatui.vim'
   use 'humanoid-colors/vim-humanoid-colorscheme'
   use 'cocopon/iceberg.vim'
   use 'freeo/vim-kalisi'
   use 'arcticicestudio/nord-vim'
   use 'zanglg/nova.nvim'
   use 'google/vim-colorscheme-primary'
   use 'jsit/toast.vim'
   use 'folke/tokyonight.nvim'
   use 'nvim-lualine/lualine.nvim' --UI related
   use 'norcalli/nvim-colorizer.lua'
   use 'kyazdani42/nvim-web-devicons'
   use 'amdt/sunset'
   use 'tribela/vim-transparent'
   use 'cohama/lexima.vim' --utility
   use { 'neoclide/coc.nvim', branch = 'release' } --lsp
   use 'mfussenegger/nvim-dap' --dap
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

local dap = require 'dap'
dap.adapters.lldb = {
   type = 'executable',
   command = function()
      local hndl = io.popen('which lldb-vscode')
      if not hndl then return nil end
      local rslt = hndl:read 'a'
      hndl:close()
      return rslt
   end
   ,
   name = 'lldb'
}

dap.configurations.rust = {
   {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
   },
}

dap.configurations.c = dap.configurations.rust
dap.configurations.c = { {
   program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
   end
} }
dap.configurations.cpp = dap.configurations.c
