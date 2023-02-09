local colo_name = function()
	local handle = io.popen 'uname'
	local os_name = handle:read '*a'
	handle:close()
	if os_name == 'Darwin\n' then
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
