return {
	'nvimtools/hydra.nvim',
	config = function()
		local te = require('telescope').extensions
		local tb = require 'telescope.builtin'
		local h = require 'hydra'
		local l = vim.lsp.buf

		h {
			name = 'palette',
			mode = { 'n', 'x' },
			body = '<space>',
			config = { color = 'teal', hint = { type = 'window', position = 'middle-right' } },
			hint = [[lsp
_a_ code action  _l_ finder
_r_ rename _d_ diagnostic
_o_ symbol _h_ hover

telescope
_b_ builtin _n_ notify
_f_ smart open _t_ todo
_e_ file browser _H_ help

else
_s_ ssr <esc> exit
]],
			heads = {
				{ 'a', '<cmd>Lspsaga code_action<cr>' },
				{ 'r', l.rename },
				{ 'h', l.hover },
				{ 'l', '<cmd>Lspsaga finder<cr>' },
				{ 'd', tb.diagnostics },
				{
					'o',
					function()
						if vim.bo.ft == 'lua' then
							tb.lsp_document_symbols { show_line = true }
						else
							tb.lsp_workspace_symbols { show_line = true }
						end
					end,
				},
				{ 'b', tb.builtin },
				{ 'f', te.smart_open.smart_open },
				{ 'n', te.notify.notify },
				{ 'e', te.file_browser.file_browser },
				{ 't', '<cmd>TodoTelescope<cr>' },
				{ 's', require('ssr').open },
				{ 'H', tb.help_tags },
				{ '<esc>', nil, { exit = true } },
			},
		}

		h {
			name = 'window',
			mode = { 'n', 'x' },
			body = '<tab>',
			config = { hint = { type = 'window', position = 'middle' } },
			hint = [[_q_ _w_ cycle
_h_ _j_ _k_ _l_ focus
_H_ _J_ _K_ _L_ move
_a_ _s_ _d_ _f_ resize
_t_ tab
_x_ close
]],
			heads = {
				{ 'q', '<c-w>W' },
				{ 'w', '<c-w>w' },
				{ 'h', '<c-w>h' },
				{ 'j', '<c-w>j' },
				{ 'k', '<c-w>k' },
				{ 'l', '<c-w>l' },
				{ 'H', '<c-w>H' },
				{ 'J', '<c-w>J' },
				{ 'K', '<c-w>K' },
				{ 'L', '<c-w>L' },
				{ 'a', '<c-w><' },
				{ 's', '<c-w>+' },
				{ 'd', '<c-w>-' },
				{ 'f', '<c-w>>' },
				{ 't', '<cmd>tabnext<cr>' },
				{ 'x', 'ZZ' },
			},
		}
		--h : jump
	end,
}
