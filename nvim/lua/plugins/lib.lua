local function colo_name()
	if os.getenv 'TERM_PROGRAM' == 'WezTerm' then
		return {
			'catppuccin/nvim',
			name = 'catppuccin',
			config = function()
				require('catppuccin').setup {
					background = {
						light = 'latte',
						dark = 'frappe',
					},
					integrations = { semantic_tokens = true },
				}
				vim.cmd 'colo catppuccin'
			end,
		}
	else
		return {
			'rebelot/kanagawa.nvim',
			config = function()
				require('kanagawa').load 'wave'
			end,
		}
	end
end

return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('catppuccin').setup {
				background = {
					light = 'latte',
					dark = 'frappe',
				},
				integrations = { semantic_tokens = true },
			}
			vim.cmd 'colo catppuccin'
		end,
	},
}
