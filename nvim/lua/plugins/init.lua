-- listup plugins here which is difficult to classify
return {
	-- Library
	'kkharji/sqlite.lua',
	'nvim-treesitter/nvim-treesitter',
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',

	-- TODO: cofig later
	{
		'lewis6991/gitsigns.nvim',
		config = true,
	},
	-- NOTE: need more understanding
	'ecthelionvi/neoComposer.nvim',
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
				cursorline = false, -- Disable the cursorline
				eob_lines = true, -- Hide the end-of-buffer lines
			},
		},
	},
}
