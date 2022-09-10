require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'
	use { 'NLKNguyen/papercolor-theme',
		config = function()
			local g = vim.g
			g.PaperColor_Theme_Options = {
				theme = {
					default = {
						allow_bold = true,
						allow_italic = true
					}
				},
				language = {
					cpp = {
						highlight_standard_library = true
					},
					c = {
						highlight_builtins = true
					}
				}
			}
		end }
	--See d7f034d for lualine settings archive
	use 'kyazdani42/nvim-web-devicons'
	use { 'amdt/sunset',
		config = function()
			local g = vim.g
			g.sunset_latitude = 35.02
			g.sunset_longitude = 135
		end }
	use { 'tribela/vim-transparent',
		config = function()
			if os.getenv 'PROFILE_NAME' == 'hotkey' then
				vim.cmd 'TransparentDisable'
			end
		end }
	use { 'windwp/nvim-autopairs',
		setup = function()
			require 'nvim-autopairs'.setup {
				map_c_h = true
			}
		end,
		config = function()
			--	 If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			local cmp = require('cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end }
	use { 'rcarriga/nvim-notify',
		setup = function()
			local notify = require 'notify'
			notify.setup({
				background_colour = '#000000',
			})
		end,
		config = function()
			vim.notify = notify
		end }
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
		setup = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = { 'lua', 'toml' },
				sync_install = true,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false
				}
			}
		end }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
		setup = function()
			require 'telescope'.setup {
				extensions = {
					file_browser = {
						hijack_netrw = true,
						hidden = true
					},
					fzf = {
						fuzzy = true,
					}
				}
			}
		end,
		config = function()
			require 'telescope'.load_extension 'frecency'
			require 'telescope'.load_extension 'file_browser'
			require 'telescope'.load_extension 'fzf'
		end } --telescope
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'nvim-telescope/telescope-frecency.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'kkharji/sqlite.lua'
	use 'williamboman/mason.nvim' --lsp
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use { 'glepnir/lspsaga.nvim',
		branch = 'main',
		config = function()
			local saga = require 'lspsaga'
			saga.init_lsp_saga({
				-- your configuration
				symbol_in_winbar = {
					in_custom = true
				},
				code_action_lightbulb = {
					sign = false
				},
				show_outline = {
					win_width = 36
				},
			})
		end,
	}
	use 'onsails/lspkind.nvim'
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

--lspsaga


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
