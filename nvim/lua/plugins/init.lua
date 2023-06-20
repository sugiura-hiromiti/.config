-- listup plugins here which is difficult to classify
return {
	{
		'chrisgrieser/nvim-recorder',
		config = function()
			require('recorder').setup {
				mapping = { startStopRecording = '<f9>' },
			}
		end,
	},
	--{ 'iamcco/markdown-preview.nvim', build = function() vim.fn['mkdp#util#install']() end, },
	{
		'iamcco/markdown-preview.nvim',
		build = 'cd app && npm install',
		init = function()
			vim.g.mkdp_filetypes = { 'markdown' }
		end,
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
