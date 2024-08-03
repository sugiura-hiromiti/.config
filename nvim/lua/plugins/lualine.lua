local function navic()
	return require('nvim-navic').get_location()
end

local function lualine_mode()
	local mode = require('hydra.statusline').get_name() or vim.fn.mode()
	return mode
end

return {
	'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup {
			globalstatus = true,
			sections = {
				lualine_a = { lualine_mode },
				lualine_b = { 'filename' },
				lualine_c = { navic },
				lualine_x = { 'diagnostics', 'branch', 'diff' },
				lualine_y = { 'location' },
				lualine_z = {},
			},
		}

		vim.opt.laststatus = 3
	end,
}
