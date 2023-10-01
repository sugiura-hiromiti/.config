return {
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { check_ts = true, map_bs = false, map_c_h = true }
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
			local fmt = require('luasnip.extras.fmt').fmt
			local s, i, c, t, f, d =
				ls.s, ls.insert_node, ls.choice_node, ls.text_node, ls.function_node, ls.dynamic_node

			ls.add_snippets('lua', {
				-- snippets for lua ft
				s(
					'sreq',
					fmt("local {}=require'{}'", {
						f(function(import_name)
							local parts =
								vim.split(import_name[1][1], '.', { plain = true, trimempty = true })
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
			})

			ls.add_snippets('all', {
				-- snippets for all ft
				s(
					'td',
					fmt('{} {}: {}', {
						f(function(_)
							local ft = vim.bo.filetype
							local comment_pre = '//'
							if ft == 'lua' then
								comment_pre = '--'
							end
							return comment_pre
						end),
						c(1, { t 'd', t 'q', t 't', t 'a', t 'x', t 'p', t 'e' }),
						i(0),
					})
				),
				s(
					'cb',
					fmt('{}\n{}{}', {
						f(function(_)
							local ft = vim.bo.filetype
							local cb_pre = '/*'
							if ft == 'lua' then
								cb_pre = '--[['
							elseif ft == 'markdown' then
								cb_pre = '<!--'
							end
							return cb_pre
						end),
						i(1),
						f(function(_)
							local ft = vim.bo.filetype
							local cb_post = '*/'
							if ft == 'lua' then
								cb_post = ']]'
							elseif ft == 'markdown' then
								cb_post = '-->'
							end
							return cb_post
						end),
					})
				),
			})
		end,
	},
	-- d: config later raw_word
	{
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		config = function()
			require('nvim-surround').setup {}
		end,
	},
	{ 'XxiaoA/ns-textobject.nvim', config = true },
}

--[[
<head>
{
{ this text will be surrounded }

}
</head>
]]
