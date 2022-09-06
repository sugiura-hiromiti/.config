require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'overcache/NeoSolarized' --colorscheme
	use 'mhartington/oceanic-next'
	use 'NLKNguyen/papercolor-theme'
	use 'chriskempson/vim-tomorrow-theme'
	use 'muellan/am-colors'
	use 'rafalbromirski/vim-aurora'
	use 'FrenzyExists/aquarium-vim'
	use 'jamespwilliams/bat.vim'
	use 'michaelmalick/vim-colors-bluedrake'
	use 'cange/vim-theme-bronkow'
	use 'vinodshelke82/carbonized'
	use { 'catppuccin/nvim', as = 'catppuccin', run = ':CatppuccinCompile' }
	use 'saltdotac/citylights.vim'
	use 'GertjanReynaert/cobalt2-vim-theme'
	use 'archseer/colibri.vim'
	use 'sainnhe/edge'
	use 'sainnhe/everforest'
	use 'willian/envylabs.vim'
	use 'balanceiskey/vim-framer-syntax'
	use 'schickele/vim-fruchtig'
	use 'ah-y/flatui.vim'
	use 'elianiva/gitgud.nvim'
	use 'cormacrelf/vim-colors-github'
	use 'vim-scripts/guepardo.vim'
	use 'habamax/vim-habaurora'
	use 'humanoid-colors/vim-humanoid-colorscheme'
	use 'cocopon/iceberg.vim'
	use 'yuttie/inkstained-vim'
	use 'fabi1cazenave/kalahari.vim'
	use 'freeo/vim-kalisi'
	use 'wimstefan/Lightning'
	use 'kaicataldo/material.vim'
	use 'mkarmona/materialbox'
	use 'haishanh/night-owl.vim'
	use 'ajlende/atlas.vim'
	use 'arcticicestudio/nord-vim'
	use 'zanglg/nova.nvim'
	use 'yous/vim-open-color'
	use 'drewtempelmeyer/palenight.vim'
	use 'google/vim-colorscheme-primary'
	use 'AndrewVos/vim-pinata'
	use 'vimpostor/vim-prism'
	use 'aonemd/quietlight.vim'
	use 'DAddYE/soda.vim'
	use 'd11wtq/subatomic256.vim'
	use 'ku-s-h/summerfruit256.vim'
	use 'jsit/toast.vim'
	use 'folke/tokyonight.nvim'
	use 'lifepillar/vim-wwdc17-theme'
	use 'arzg/vim-colors-xcode'
	use 'nvim-lualine/lualine.nvim' --UI related
	use 'kyazdani42/nvim-web-devicons'
	use 'amdt/sunset'
	use 'ah-y/vim-transparent'
	use 'cohama/lexima.vim' --utility
	use { 'neoclide/coc.nvim', branch = 'release' } --lsp
	use 'mfussenegger/nvim-dap' --dap
end)

---------------------catppuccin
   require 'catppuccin'.setup({
      dim_inactive = {
         enabled = true,
         percentage = 0.3
      },
      compile = {
         enabled = true,
         path = vim.fn.stdpath 'cache' .. '/catppuccin'
      },
      styles = {
         functions = { 'bold' },
         variables = { 'italic' }
      },
      integrations = {
         coc_nvim = true,
         dap = {
            enabled = true,
            enable_ui = true
         }
      }
   })

---------------------lualine
require 'lualine'.setup({
	options = {
		always_divide_middle = false,
		globalstatus = true,
	},
	extensions = {
		'nvim-dap-ui', 'quickfix'
	}
})

---------------------dap
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
