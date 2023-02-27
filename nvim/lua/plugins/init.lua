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
	{
		'iamcco/markdown-preview.nvim',
		build = function()
			vim.fn['mkdp#util#install']()
		end,
	},
	{
		'zbirenbaum/copilot.lua',
		config = function()
			require('copilot').setup {
				panel = { enable = false },
				suggestion = {
					auto_trigger = true,
					keymap = { accept = '<tab>', next = '<down>', prev = '<up>', dismiss = '<c-c>' },
				},
				filetypes = { ['*'] = true },
			}
		end,
	},
}
