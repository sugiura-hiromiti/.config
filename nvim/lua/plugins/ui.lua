local function mini(find, kind)
	return {
		view = 'mini',
		filter = { event = 'msg_show', kind = kind or '', find = find },
	}
end

return {
	'rcarriga/nvim-notify',
	{
		'folke/noice.nvim',
		config = function()
			require('noice').setup {
				lsp = {
					override = {
						['vim.lsp.util.convert_input_to_markdown_lines'] = true,
						['vim.lsp.util.stylize_markdown'] = true,
						['cmp.entry.get_documentation'] = true,
					},
				},
				presets = { bottom_search = true },
				routes = {
					mini 'written',
					mini 'more lines',
					mini 'fewer lines',
					mini 'yanked',
					mini 'chang; before',
					mini 'chang; after',
				},
			}
		end,
	},
	{
		'folke/todo-comments.nvim',
		config = function()
			require('todo-comments').setup {
				keywords = {
					FIX = { alt = { 'e' } },
					TODO = { alt = { 'q' } },
					HACK = { color = 'doc', alt = { 'a' } },
					WARN = { alt = { 'x' } },
					PERF = { color = 'cmt', alt = { 'p' } },
					NOTE = { alt = { 'd' } },
					TEST = { alt = { 't', 'PASS', 'FAIL' } },
				},
				colors = { cmt = { 'Comment' }, doc = { 'SpecialComment' } },
			}
		end,
	},
	{
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup()
		end,
	},
	--{ 'giusgad/pets.nvim', config = function() require('pets').setup() end, },
}
