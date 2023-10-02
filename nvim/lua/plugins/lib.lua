local function colo_name()
	--	if
	--		 os.getenv 'TERM_PROGRAM' == 'WezTerm'
	--		 or os.getenv 'TERM_PROGRAM' == 'iTerm.app'
	--		 or os.getenv 'TERM' == 'alacritty'
	--	then
	return {
		'catppuccin/nvim',
		name = 'catppuccin',
		config = function()
			require('catppuccin').setup {
				background = {
					light = 'latte',
					dark = 'frappe',
				},
				--transparent_background = os.getenv 'TERM' == 'alacritty',
				integrations = { semantic_tokens = true },
			}
			vim.cmd 'colo catppuccin'
		end,
	}
	--	else
	--		return {
	--			'rebelot/kanagawa.nvim',
	--			config = function()
	--				require('kanagawa').load 'wave'
	--			end,
	--		}
	--	end
end

return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	'vim-denops/denops.vim',
	colo_name(),
	--{ 'pappasam/papercolor-theme-slim', config = function() vim.cmd 'colo PaperColorSlim' end, },
}
