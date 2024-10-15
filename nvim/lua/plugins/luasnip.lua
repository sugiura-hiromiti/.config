return {
	{
		'L3MON4D3/LuaSnip',
		config = function()
			require('luasnip').setup {
				history = false,
				updateevents = 'TextChanged,TextChangedI',
			}

			local ls = require 'luasnip'
			local fmt = require('luasnip.extras.fmt').fmt
			local s, i, c, t, f, d = ls.s, ls.insert_node, ls.choice_node, ls.text_node, ls.function_node, ls.dynamic_node

			local path_handler = assert(io.popen('ls $HOME/.config/nvim/lua/lua_snip_def/', 'r'))
			local snip_defs = {}
			for line in path_handler:lines() do
				local ft_end = line:find '.lua'
				if ft_end then
					local ft = line:sub(1, ft_end - 1)

					local snip, auto_snip = require('lua_snip_def.' .. line:sub(1, ft_end - 1))
					ls.add_snippets(ft, snip)
					ls.add_snippets(ft, auto_snip, { type = 'autosnippets' })
				end
			end
		end,
	},
}

-- ( surround )
