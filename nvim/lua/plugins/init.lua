-- listup plugins here which is difficult to classify

local iterm_profile_is_hotkey = os.getenv 'ITERM_PROFILE' == 'Hotkey Window'
return {
	-- Library
	'kkharji/sqlite.lua',
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				auto_install = true,
				ignore_install = { 'markdown' },
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			}
		end,
	},
	'nvim-lua/plenary.nvim',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',

	{
		'chrisgrieser/nvim-spider',
	},
	{
		'f-person/auto-dark-mode.nvim',
		config = function()
			local req = require 'auto-dark-mode'
			if not iterm_profile_is_hotkey then
				req.setup {}
			end
		end,
	},
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('catppuccin').setup {
				background = { dark = 'frappe' },
				transparent_background = true,
				term_colors = true,
				dim_inactive = { enabled = true },
				styles = {
					keywords = { 'bold' },
					properties = { 'italic', 'bold' },
				},
			}
			vim.cmd 'colo catppuccin'
		end,
	},
}
