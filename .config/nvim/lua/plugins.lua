require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'mhartington/oceanic-next'
	use 'NLKNguyen/papercolor-theme'
	use 'muellan/am-colors'
	use 'rafalbromirski/vim-aurora'
	use 'jamespwilliams/bat.vim'
	use 'cange/vim-theme-bronkow'
	use 'vinodshelke82/carbonized'
	use { 'catppuccin/nvim', as = 'catppuccin', run = ':CatppuccinCompile' }
	use 'sainnhe/edge'
	use 'sainnhe/everforest'
	use 'willian/envylabs.vim'
	use 'balanceiskey/vim-framer-syntax' --Sub
	use 'schickele/vim-fruchtig'
	use 'ah-y/flatui.vim'
	use 'vim-scripts/guepardo.vim'
	use 'habamax/vim-habaurora'
	use 'humanoid-colors/vim-humanoid-colorscheme'
	use 'cocopon/iceberg.vim'
	use 'yuttie/inkstained-vim'
	use 'fabi1cazenave/kalahari.vim'
	use 'freeo/vim-kalisi'
	use 'wimstefan/Lightning'
	use 'mkarmona/materialbox'
	use 'arcticicestudio/nord-vim'
	use 'zanglg/nova.nvim'
	use 'yous/vim-open-color'
	use 'drewtempelmeyer/palenight.vim'
	use 'google/vim-colorscheme-primary'
	use 'AndrewVos/vim-pinata'
	use 'vimpostor/vim-prism' --Sub
	use 'aonemd/quietlight.vim'
	use 'd11wtq/subatomic256.vim'
	use 'ku-s-h/summerfruit256.vim'
	use 'jsit/toast.vim'
	use 'folke/tokyonight.nvim'
	use 'lifepillar/vim-wwdc17-theme'
	use 'arzg/vim-colors-xcode' --Sub
	use 'nvim-lualine/lualine.nvim' --UI related
	use 'kyazdani42/nvim-web-devicons'
	use 'amdt/sunset'
	use 'ah-y/vim-transparent'
	use 'windwp/nvim-autopairs' --utility
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' } --telescope
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use { 'nvim-telescope/telescope-frecency.nvim',
		config = function()
			require 'telescope'.load_extension('frecency')
		end,
		requires = { 'kkharji/sqlite.lua' } }
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'williamboman/mason.nvim' --lsp
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")

			saga.init_lsp_saga({
				-- your configuration
				symbol_in_winbar = {
					enable = true,
				},
				show_outline = {
					win_width = 36
				},
				definition_preview_icon = " "
			})
		end,
	})
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
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

---------------------autopairs
require 'nvim-autopairs'.setup({
	map_c_h = true
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

--config of telescope moved to fuzzy.lua

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
