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
_a_ code action  _j_ jump
_i_ incoming _r_ rename
_o_ outgoing _s_ symbol
_d_ diagnostic _h_ hover

telescope
_b_ builtin _n_ notify
_f_ smart open _t_ todo

else
_g_ gitui <esc> exit
]],
			heads = {
				{ 'a', l.code_action },
				{ 'r', l.rename },
				{ 'h', l.hover },
				{ 'j', tb.lsp_references },
				{ 'd', tb.diagnostics },
				{
					's',
					function()
						if vim.bo.ft == 'lua' then
							tb.lsp_document_symbols { show_line = true }
						else
							tb.lsp_dynamic_workspace_symbols { show_line = true }
						end
					end,
				},
				{ 'i', tb.lsp_incoming_calls },
				{ 'o', tb.lsp_outgoing_calls },

				{ 'b', tb.builtin },
				{ 'f', te.smart_open.smart_open },
				{ 'n', te.notify.notify },
				{ 't', '<cmd>TodoTelescope<cr>' },

				{ 'g', require('gitui').open },
				{ '<esc>', nil, { exit = true } },
			},
		}

		h {
			name = 'window',
			mode = { 'n', 'x' },
			body = 't',
			config = { hint = { type = 'statuslinemanual' } },
			hint = '_q_ _w_ cycle / _h_ _j_ _k_ _l_ focus / _H_ _J_ _K_ _L_ window / _<c-[>_ _1_ _2_ _3_ resize / _t_ tab',
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
				{ '<c-[>', '<c-w><' },
				{ '1', '<c-w>+' },
				{ '2', '<c-w>-' },
				{ '3', '<c-w>>' },
				{ 't', '<cmd>tabnext<cr>' },
			},
		}
		--h : jump
	end,
}
