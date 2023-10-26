--local function mini(find, kind)
--	return {
--		view = 'mini',
--		filter = { event = 'msg_show', kind = kind or '', find = find },
--	}
--end

return {
	'rcarriga/nvim-notify',
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = { 'MunifTanjim/nui.nvim' },
		config = function()
			require('noice').setup {
				presets = { bottom_search = true, long_message_to_split = true },
				--				routes = {
				--					mini 'written',
				--					mini '>ed',
				--					mini '<ed',
				--					mini 'fewer lines',
				--					mini 'more lines',
				--					mini 'change; before',
				--				},
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
	--{ 'edluffy/hologram.nvim', config = function() require('hologram').setup { auto_display = true } end, },
	--{ 'nvim-zh/colorful-winsep.nvim', config = true, event = { 'winnew' }, },
	--{ 'giusgad/pets.nvim', config = function() require('pets').setup() end, },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function(opts)
			require('lualine').setup {
				options = {
					sections = {
						--					lualine_c = {
						--						require('NeoComposer.ui').status_recording,
						--						{ require('lazy.status').updates, cond = require('lazy.status').has_updates },
						--					},
						lualine_x = { 'encoding', 'fileformat' },
						lualine_y = { 'location' },
						--					lualine_z = { vim.fn.getcwd },
					},
				},
			}
		end,
	},
}
