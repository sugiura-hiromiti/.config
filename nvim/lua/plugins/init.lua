-- listup plugins here which is difficult to classify
return {
	-- d: need more understanding
	{
		'ecthelionvi/neoComposer.nvim',
		dependencies = { 'kkharji/sqlite.lua' },
	},
	-- e: https://github.com/toppair/peek.nvim/issues/47
	{
		'saimo/peek.nvim',
		build = 'deno task --quiet build:fast',
		config = function()
			require('peek').setup { theme = vim.o.background, app = 'browser' }
		end,
	},
	'chrisgrieser/nvim-spider',
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		config = function()
			require('copilot').setup {
				-- for `copilot-cmp`, `panel` and `suggestion` should be disabled
				panel = { enable = false },
				suggestion = {
					enable = false,
					--					auto_trigger = true,
					--					keymap = { next = '<down>', prev = '<up>', dismiss = '<c-c>' },
					--				},
					--				filetypes = { ['*'] = true },
				},
			}
		end,
	},
	{
		'kawre/leetcode.nvim',
		build = ':TSUpdate html',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
			'nvim-tree/nvim-web-devicons',
		},
		opts = {
			lang = 'rust',
			sql = 'sqlite3',
		},
	},
}
