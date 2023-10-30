return {
	'rcarriga/nvim-notify',
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = { 'MunifTanjim/nui.nvim' },
		config = function()
			require('noice').setup {
				presets = { bottom_search = true, long_message_to_split = true },
			}
		end,
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
		-- FIX:
		-- TODO:
		-- HACK:
		-- WARN:
		-- PERF:
		-- NOTE:
		-- TEST:
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup {
				options = {
					sections = {
						lualine_c = {
							require('NeoComposer.ui').status_recording,
							{ require('lazy.status').updates, cond = require('lazy.status').has_updates },
						},
						lualine_x = { 'encoding', 'fileformat' },
						lualine_y = { 'location' },
						lualine_z = { vim.fn.getcwd },
					},
				},
			}
		end,
	},
}
