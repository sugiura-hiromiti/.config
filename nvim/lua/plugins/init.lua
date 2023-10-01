-- listup plugins here which is difficult to classify
return {
	'ecthelionvi/neoComposer.nvim',
	-- e: bug https://github.com/toppair/peek.nvim/issues/47
	--{ 'toppair/peek.nvim', build = 'deno task --quiet build:fast', config = function() require('peek').setup { theme = vim.o.background, app = 'browser' } end, },
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && npm install',
	},
	'chrisgrieser/nvim-spider',
	{
		'zbirenbaum/copilot.lua',
		config = function()
			require('copilot').setup {
				panel = { enable = false },
				suggestion = {
					auto_trigger = true,
					keymap = { next = '<down>', prev = '<up>', dismiss = '<c-c>' },
				},
				filetypes = { ['*'] = true },
			}
		end,
	},
}
