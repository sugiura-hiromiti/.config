require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'zanglg/nova.nvim'
	use 'jamespwilliams/bat.vim'
	use 'ayu-theme/ayu-vim'
	use { 'NLKNguyen/papercolor-theme',
		config = function()
			local g = vim.g
			g.PaperColor_Theme_Options = {
				theme = {
					default = {
						allow_bold = true,
						allow_italic = true,
						transparent_background = os.getenv 'PROFILE_NAME' == 'hotkey' and true or false
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
	use { 'LudoPinelli/comment-box.nvim',
		config = function()
			require 'comment-box'.setup {
				line_width = 80
			}
		end }
	use 'famiu/bufdelete.nvim'
	use { 'RRethy/vim-illuminate',
		config = function()
			vim.cmd 'hi IlluminatedWordText gui=bold guibg=DarkGray'
			vim.cmd 'hi IlluminatedWordRead gui=bold guibg=DarkGray'
			--vim.cmd 'hi IlluminatedWordWrite gui=bold guibg=DarkGray'
		end }
	use 'wakatime/vim-wakatime'
	use { 'kevinhwang91/nvim-hlslens' }
	use { 'petertriho/nvim-scrollbar',
		config = function()
			require 'scrollbar'.setup()
			require("scrollbar.handlers.search").setup()
		end }
	--use 'folke/todo-comments.nvim'
	use { 'amdt/sunset',
		config = function()
			local g = vim.g
			g.sunset_latitude = 35.02
			g.sunset_longitude = 135
		end }
	use { 'windwp/nvim-autopairs', after = 'nvim-cmp',
		config = function()
			require 'nvim-autopairs'.setup {
				map_c_h = true
			} --	 If you want insert `(` after select function or method item
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			require('cmp').event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
		end }
	use { 'rcarriga/nvim-notify',
		config = function()
			local notify = require 'notify'
			notify.setup({
				background_colour = '#000000',
				fps = 30,
			})
			vim.notify = notify
		end }
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = { 'toml', 'help' },
				sync_install = true,
				--				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false
				}
			}
		end }
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
						hijack_netrw = true,
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
			require 'telescope'.load_extension 'projects'
		end } --telescope
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use 'nvim-telescope/telescope-frecency.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use { 'ahmedkhalf/project.nvim',
		config = function()
			require 'project_nvim'.setup {
				patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json', 'Cargo.toml' },
				show_hidden = true,
				silent_chdir = false,
			}
		end }
	use 'kkharji/sqlite.lua'
	use { 'williamboman/mason.nvim',
		config = function()
			require 'mason'.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				}
			})
		end } --lsp
	use { 'williamboman/mason-lspconfig.nvim',
		config = function()
			require 'mason-lspconfig'.setup({
				ensure_installed = { 'sumneko_lua', 'rust_analyzer' }
			})
		end }
	use 'neovim/nvim-lspconfig'
	use { 'glepnir/lspsaga.nvim',
		branch = 'main',
		config = function()
			require 'lspsaga'.init_lsp_saga({
				-- your configuration
				symbol_in_winbar = {
					in_custom = true,
					click_support = true
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
		end } --dap
end)
