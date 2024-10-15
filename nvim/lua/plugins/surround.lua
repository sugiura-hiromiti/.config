local my_lua_api = require 'my_lua_api'

return {
	-- TODO: configure to manipulate surround comment block
	'kylechui/nvim-surround',
	version = '*',
	event = 'VeryLazy',
	opts = {
		surrounds = {
			C = {
				add = function()
					local cmt_idctr = my_lua_api.comment_indicators(vim.bo.comments)
					return { { cmt_idctr.normal.block.pre }, { cmt_idctr.normal.block.post } }
				end,
				find = function()
					return require('nvim-surround.config').get_selection { node = 'block_comment' }
				end,
			},
		},
	},
}
