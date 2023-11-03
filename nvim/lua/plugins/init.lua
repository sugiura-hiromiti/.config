-- listup plugins here which is difficult to classify
return {
	-- TODO: cofig later
	{
		'lewis6991/gitsigns.nvim',
		config = true,
	},
	-- NOTE: need more understanding
	{
		'ecthelionvi/neoComposer.nvim',
		dependencies = { 'kkharji/sqlite.lua' },
	},
	-- TODO: https://github.com/toppair/peek.nvim/issues/47
	{
		'saimo/peek.nvim',
		build = 'deno task --quiet build:fast',
		opts = { theme = vim.o.background, app = 'browser' },
		--config = function() require('peek').setup end,
	},
	'chrisgrieser/nvim-spider',
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
			-- for `copilot-cmp`, `panel` and `suggestion` should be disabled
			panel = { enable = false },
			suggestion = {
				enable = false,
				--auto_trigger = true,
				--keymap = { next = '<down>', prev = '<up>', dismiss = '<c-c>' },},
				--filetypes = { ['*'] = true },
			},
		},
		--config = function() require('copilot').setup , } end,
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
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		opts = {
			flavour = 'latte',
			background = { light = 'latte', dark = 'frappe' },
			styles = {
				comments = { 'italic' },
				conditionals = { 'italic', 'bold' },
				variables = { 'italic' },
			},
		},
		--config = function() vim.cmd 'colo catppuccin' end,
	},
}
