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
	},
	'chrisgrieser/nvim-spider',
	{
		'zbirenbaum/copilot.lua',
		cmd = 'Copilot',
		event = 'InsertEnter',
		opts = {
			panel = { enable = false },
			suggestion = {
				enable = false,
			},
		},
	},
	--	{
	--		'catppuccin/nvim',
	--		name = 'catppuccin',
	--		opts = {
	--			--	flavour = 'latte',
	--			--			background = { light = 'latte', dark = 'frappe' },
	--			transparent_background = true,
	--			styles = {
	--				comments = { 'italic' },
	--				conditionals = { 'italic', 'bold' },
	--				variables = { 'italic' },
	--			},
	--		},
	--	},
	{
		'rmehri01/onenord.nvim',
		opts = {
			styles = {
				comments = 'italic',
				strings = 'bold',
				keywords = 'NONE',
				diagnostics = 'underline',
			},
			disable = {
				background = true, -- Disable setting the background color
				float_background = true, -- Disable setting the background color for floating windows
				cursorline = false, -- Disable the cursorline
				eob_lines = true, -- Hide the end-of-buffer lines
			},
		},
	},
}
