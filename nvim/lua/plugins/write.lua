return {
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { map_c_h = true }
		end,
	},
	{
		'L3MON4D3/LuaSnip',
		config = function()
			require('luasnip').setup {
				history = false,
				updateevents = 'TextChanged,TextChangedI',
			}

			local ls = require 'luasnip'
			local fmt, rep = require('luasnip.extras.fmt').fmt, require('luasnip.extras').rep
			local s, i, c, t, f, d = ls.s, ls.insert_node, ls.choice_node, ls.text_node, ls.function_node, ls.dynamic_node

			ls.add_snippets('lua', {
				-- snippets for lua ft
				s(
					'req',
					fmt("local {}=require'{}'", {
						f(function(import_name)
							local parts = vim.split(import_name[1][1], '.', { plain = true, trimempty = true })
							return parts[#parts] or ''
						end, { 1 }),
						i(1),
					})
				),
				s(
					'hotkey',
					fmt(
						[[
				hs.hotkey.bind({{'{}'}},'{}', function()
					{}
				end)
				]],
						{ i(1), i(2), i(0) }
					)
				),
			})

			ls.add_snippets('all', {
				-- snippets for all ft
				ls.parser.parse_snippet('lf', '-- defined in $TM_FILENAME\nlocal $1=function($2)\n$0\nend'),
				s('td', fmt([[{}: {}]], { c(1, { t ' d', t ' q', t ' t', t ' a', t ' x', t ' p', t ' e' }), i(0) })),
				s(
					'curtime',
					f(function()
						return os.date '%D - %H:%M'
					end)
				),
			})
		end,
	},
}
