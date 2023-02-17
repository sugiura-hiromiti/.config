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
		'jackMort/ChatGPT.nvim',
		config = true,
	},
	{
		'iamcco/markdown-preview.nvim',
		build = function()
			vim.fn['mkdp#util#install']()
		end,
	},
}
