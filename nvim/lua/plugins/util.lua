local symbols = require 'my_lua_api.symbols'
local iterm_profile_is_hotkey = os.getenv 'ITERM_PROFILE' == 'Hotkey Window'

return {
	--  TODO: later
	{ 'stevearc/overseer.nvim', opts = {} },
	{ '3rd/image.nvim' },
	{ 'pwntester/octo.nvim' },
	{
		'xemptuous/sqlua.nvim',
		lazy = true,
		cmd = 'SQLua',
		config = function()
			require('sqlua').setup()
		end,
	},
	{ 'folke/flash.nvim', event = 'VeryLazy' },

	-- NOTE: Library
	'kkharji/sqlite.lua',
	{ 'echasnovski/mini.nvim', version = false },
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',

	-- NOTE: appearance
	{ 'nvim-zh/colorful-winsep.nvim', config = true, event = { 'WinLeave' } },
	{
		'stevearc/oil.nvim',
		opts = {
			view_options = {
				show_hidden = true,
			},
			columns = {
				'icon',
				'permissions',
				'size',
			},
			win_options = {
				signcolumn = 'yes:2',
			},
			float = {
				win_options = {
					winblend = 30,
				},
			},
		},
	},
	{
		'tronikelis/xylene.nvim',
		opts = {
			on_attach = function(renderer)
				vim.keymap.set('n', '<cr>', function()
					renderer:toggle(vim.api.nvim_win_get_cursor(0)[1])
				end, { buffer = renderer.buf })

				vim.keymap.set('n', '!', function()
					renderer:toggle_all(vim.api.nvim_win_get_cursor(0)[1])
				end, { buffer = renderer.buf })
			end,
		},
	},
	{ 'refractalize/oil-git-status.nvim', config = true },
	{ 'JezerM/oil-lsp-diagnostics.nvim', opts = {} },
	{
		'vyfor/cord.nvim',
		build = ':Cord update',
		event = 'VeryLazy',
		opts = {},
	},
	{ 'OXY2DEV/helpview.nvim', lazy = false },
	'Hiphish/rainbow-delimiters.nvim',
	'chrisgrieser/nvim-spider',
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('catppuccin').setup {
				--		transparent_background = true,
				term_colors = true,
				dim_inactive = { enabled = true },
				styles = {
					keywords = { 'bold' },
					properties = { 'italic', 'bold' },
				},
			}
			vim.cmd 'colo catppuccin'
		end,
	},
	-- { 'f-person/auto-dark-mode.nvim', opts = {} },
	-- NOTE: LSP
	{
		'onsails/lspkind.nvim',
		config = function()
			require('lspkind').init {
				symbol_map = symbols,
			}
		end,
	},
	{
		'nvimtools/none-ls.nvim',
		config = function()
			local b = require('null-ls').builtins
			require('null-ls').setup {
				sources = {
					b.formatting.stylua, --.with { args = { '--config-path ~/.stylua.toml' } },
					b.formatting.google_java_format,
					b.formatting.alejandra,
				},
			}
		end,
	},

	-- NOTE: utility
	{ 'rcarriga/nvim-notify', opts = { background_colour = '#000000' } },
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		opts = {
			lsp = {
				override = {
					['vim.lsp.util.convert_input_to_markdown_lines'] = true,
					['vim.lsp.util.stylize_markdown'] = true,
					['cmp.entry.get_documentation'] = true,
				},
			},
			presets = { bottom_search = true },
			routes = {
				{
					filter = {
						event = 'msg_show',
						find = 'Unable to find native fzy native lua dep file. Probably need to update submodules!',
					},
					opts = { skip = true },
				},
			},
		},
	},
	{
		'folke/todo-comments.nvim',
		config = true,
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
	'stevearc/dressing.nvim',
	{
		'RaafatTurki/hex.nvim',
		config = function()
			require('hex').setup()
		end,
	},
	{
		'aaronik/treewalker.nvim',
		opts = {},
	},
	'danilamihailov/beacon.nvim',
	{ 'https://codeberg.org/esensar/nvim-dev-container', opts = {} },

	-- NOTE: git
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup {}
		end,
	},
	{ 'aspeddro/gitui.nvim', opts = {} },
	{ 'sindrets/diffview.nvim', opts = {} },
	{
		'shellRaining/hlchunk.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
		opts = {
			chunk = { enable = true },
			-- indent = { enable = true },
			line_num = { enable = true },
		},
	},

	-- NOTE: completion
	'https://codeberg.org/FelipeLema/cmp-async-path',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-cmdline',
	'lukas-reineke/cmp-rg',
	'saadparwaiz1/cmp_luasnip',
	'ray-x/cmp-treesitter',
	{
		'petertriho/cmp-git',
		init = function()
			table.insert(require('cmp').get_config().sources, { name = 'git' })
		end,
	},
	'hrsh7th/cmp-nvim-lsp-document-symbol',
	--{ 'zbirenbaum/copilot-cmp', opts = {} },
	{
		'saecki/crates.nvim',
		event = { 'BufRead Cargo.toml' },
		config = function()
			require('crates').setup {
				lsp = {
					enabled = true,
					actions = true,
					completion = true,
					hover = true,
				},
				completion = {
					cmp = {
						enabled = true,
					},
					crates = {
						enabled = true,
						min_chars = 1,
					},
				},
			}
		end,
	},

	-- NOTE: edit
	{
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup {}
		end,
	},
	--'subnut/nvim-ghost.nvim',
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup {
				check_ts = true,
				map_bs = false,
				map_c_h = true,
				enable_check_bracket_line = false,
			}
		end,
	},

	-- NOTE: telescope
	{
		'danielfalk/smart-open.nvim',
		branch = '0.3.x',
	},
	'nvim-telescope/telescope-ui-select.nvim',
	-- 'nvim-telescope/telescope-file-browser.nvim',
}
