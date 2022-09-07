require 'telescope'.setup {
	extensions = {
		file_browser = {
			hijack_netrw = true,
			hidden = true
		}
	}
}
require 'telescope'.load_extension 'file_browser'
require 'telescope'.load_extension 'fzf'

local opts = { noremap = true }
vim.keymap.set('n', '<cr>e', [[<cmd>Telescope file_browser<cr>]], opts)
vim.keymap.set('n', '<cr>t', [[<cmd>Telescope<cr>]], opts)
vim.keymap.set('n', '<cr>f', [[<cmd>Telescope frecency<cr>]], opts)
