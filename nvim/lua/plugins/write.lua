return {
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { map_c_h = true }
		end,
	},
	{
		'L3MON4D3/LuaSnip',
		version = '<CurrentMajor>.*',
		config = function()
			require('luasnip').setup {
				history = false,
				updateevents = 'TextChanged,TextChangedI',
			}

			local ls = require 'luasnip'
			local fmt = require('luasnip.extras.fmt').fmt
			local s, i, c, t, f = ls.s, ls.insert_node, ls.choice_node, ls.text_node, ls.function_node

			ls.add_snippets('lua', {
				-- snippets for lua ft
				s(
					'sreq',
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
				s(
					'hs_notify',
					fmt(
						[[
				hs.notify.new({{title='{}', informativeText={}}}):send()
				]],
						{ i(1, 'HammerSpoon'), i(2) }
					)
				),
				s('bc', fmt('--[[{}]]', i(1))),
			})

			ls.add_snippets('all', {
				-- snippets for all ft
				s('td', fmt(' {}: {}', { c(1, { t 'd', t 'q', t 't', t 'a', t 'x', t 'p', t 'e' }), i(0) })),
			})

			ls.add_snippets({ 'rust', 'c', 'cpp', 'css', 'swift' }, {
				s('bc', fmt('/*{}*/', i(1))),
			})
		end,
	},
}
