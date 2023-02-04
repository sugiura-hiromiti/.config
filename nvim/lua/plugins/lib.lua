local colo_name = function()
	local os_name = os.getenv 'OS_NAME'
	if os_name == 'Darwin' then
		return {
			'sugiura-hiromichi/catppuccin',
			config = function()
				vim.cmd 'colo catppuccin'
				require('catppuccin').setup {
					integrations = { lsp_saga = true, notify = false, noice = false, semantic_tokens = true },
				}
			end,
		}
	else
		return {
			'zanglg/nova.nvim',
			config = function()
				require('nova').setup()
				require('nova').load()
			end,
		}
	end
end

return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	'MunifTanjim/nui.nvim',
	'nvim-tree/nvim-web-devicons',
	colo_name(),
}
