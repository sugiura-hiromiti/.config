require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'NLKNguyen/papercolor-theme' --colorscheme
	use 'nvim-lualine/lualine.nvim' --UI related
	use 'kyazdani42/nvim-web-devicons'
	use 'amdt/sunset'
	use 'ah-y/vim-transparent'
	use 'windwp/nvim-autopairs' --utility
	use 'rcarriga/nvim-notify'
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' } --telescope
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use { 'nvim-telescope/telescope-frecency.nvim',
		config = function()
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
					in_custom = true
				},
				show_outline = {
					win_width = 36
				},
			})
		end,
	})
	use 'hrsh7th/nvim-cmp' --completion source
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'mfussenegger/nvim-dap' --dap
end)

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

---------------------notify
local notify = require 'notify'
notify.setup({
	background_colour = '#000000',
})
vim.notify = notify

---------------------telescope
require 'telescope'.setup {
	extensions = {
		file_browser = {
			hijack_netrw = true,
			hidden = true
		}
	}
}
require 'telescope'.load_extension 'frecency'
require 'telescope'.load_extension 'file_browser'
require 'telescope'.load_extension 'fzf'

---------------------treesitter
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'rust', 'lua', 'markdown', 'toml' },
	sync_install = true,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	}
}

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
