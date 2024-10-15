local symbols = require 'symbols'
local iterm_profile_is_hotkey = os.getenv 'ITERM_PROFILE' == 'Hotkey Window'

return {

	-- NOTE: Library
	'kkharji/sqlite.lua',
	{ 'echasnovski/mini.nvim', version = false },
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',

	-- NOTE: appearance
	{
		'vyfor/cord.nvim',
		build = './build || .\\build',
		event = 'VeryLazy',
		opts = {},
	},
	--	{
	--		'toppair/peek.nvim',
	--		event = { 'VeryLazy' },
	--		build = 'deno task --quiet build:fast',
	--		opts = {
	--			app = 'browser',
	--		},
	--	},
	{ 'OXY2DEV/helpview.nvim', lazy = false },
	{
		'MeanderingProgrammer/render-markdown.nvim',
		opts = { file_types = { 'markdown', 'noice', 'cmp_docs', 'notify' } },
	},
	'Hiphish/rainbow-delimiters.nvim',
	'chrisgrieser/nvim-spider',
	{
		'f-person/auto-dark-mode.nvim',
		config = function()
			local req = require 'auto-dark-mode'
			if not iterm_profile_is_hotkey then
				req.setup {}
			end
		end,
	},
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
	--	{
	--		'yorik1984/newpaper.nvim',
	--		config = function()
	--			require('newpaper').setup {}
	--			vim.cmd 'colo newpaper'
	--		end,
	--	},

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
		'williamboman/mason.nvim',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = {
			ensure_installed = {
				'rust_analyzer@nightly',
				'lua_ls',
			},
		},
	},
	--	{
	--		-- A simple statusline/winbar component that uses LSP to show your current code context
	--		'SmiteshP/nvim-navic',
	--		opts = {
	--			icons = symbols,
	--			lsp = { preference = { 'marksman', 'texlab' } },
	--			highlight = true,
	--			click = true,
	--		},
	--	},
	{
		'nvimtools/none-ls.nvim',
		config = function()
			local b = require('null-ls').builtins
			require('null-ls').setup {
				sources = {
					b.formatting.stylua,
					b.hover.printenv,
					b.diagnostics.zsh,
					b.code_actions.gitrebase,
					b.code_actions.gitsigns,
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
		-- TODO: consider using tree-sitter todo comment
		'folke/todo-comments.nvim',
		config = true,
	},
	'norcalli/nvim-colorizer.lua',
	'stevearc/dressing.nvim',

	-- NOTE: git
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup {}
		end,
	},

	-- NOTE: completion
	'https://codeberg.org/FelipeLema/cmp-async-path',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-buffer',
	--'hrsh7th/cmp-path',
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
	'JMarkin/cmp-diag-codes',

	-- NOTE: edit
	{
		'windwp/nvim-ts-autotag',
		config = function()
			require('nvim-ts-autotag').setup {}
		end,
	},
	'subnut/nvim-ghost.nvim',
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { check_ts = true, map_bs = false, map_c_h = true }
		end,
	},

	-- NOTE: telescope
	{
		'danielfalk/smart-open.nvim',
		branch = '0.2.x',
	},
	'nvim-telescope/telescope-ui-select.nvim',
	'nvim-telescope/telescope-file-browser.nvim',
}
