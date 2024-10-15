local ls = require 'luasnip'
local fmt = require('luasnip.extras.fmt').fmt
local s, i, c, t, f, d = ls.s, ls.insert_node, ls.choice_node, ls.text_node, ls.function_node, ls.dynamic_node

-- snippets for lua ft
return {
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
}, {}
