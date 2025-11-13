local ui = require 'my_lua_api.ui'
local select = require 'my_lua_api.select'

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
			config = { color = 'teal', hint = { type = 'window', position = 'middle' } },
			hint = [[
_a_ code action  _l_ finder
_r_ rename       _d_ diagnostic
_o_ symbol       _h_ hover
_b_ builtin      _n_ notify
_f_ smart open   _t_ text search
_e_ file browser _m_ manual
_x_ term         _w_ window opener
_g_ gitui        _s_ ssr

<esc> exit
]],
			heads = {
				{
					'a',
					function()
						local ft = vim.bo.filetype
						if ft == 'rust' then
							vim.cmd 'RustLsp codeAction'
						else
							l.code_action()
						end
					end,
				},
				{ 'r', l.rename },
				{
					'h',
					function()
						local ft = vim.bo.filetype
						if ft == 'rust' then
							local mode = vim.api.nvim_get_mode().mode
							if mode == 'n' then
								mode = 'actions'
							elseif mode == 'v' or mode == 'V' then
								mode = 'range'
							end
							vim.cmd.RustLsp { 'hover', mode }
						else
							l.hover()
						end
					end,
				},
				{ 'l', tb.lsp_references },
				{ 'd', tb.diagnostics },
				{ 'o', select.symbols },
				{ 'b', tb.builtin },
				{ 'f', te.smart_open.smart_open },
				{ 'n', te.notify.notify },
				{ 'e', te.file_browser.file_browser },
				{ 'g', select.git },
				{
					's',
					function()
						local ft = vim.bo.filetype
						if ft == 'rust' then
							vim.cmd.RustLsp 'ssr'
						else
							require('ssr').open()
						end
					end,
				},
				{ 'm', select.references },
				{ 'x', select.terminal },
				{ 't', select.text_search },
				{ 'w', select.file_nav },
				{ '<esc>', nil, { exit = true } },
			},
		}

		h {
			name = 'window',
			mode = { 'n', 'x' },
			body = '<tab>',
			config = { invoke_on_body = true, hint = { type = 'window', position = 'middle' } },
			hint = [[
_q_ _w_ tab
_h_ _j_ _k_ _l_ focus
_H_ _J_ _K_ _L_ move
_<c-b>_ _<c-n>_ _<c-p>_ _<c-f>_ resize
_t_ split new tab _c_ close _x_ exit
]],
			heads = {
				{ 'q', '<cmd>tabprevious<cr>' },
				{ 'w', '<cmd>tabnext<cr>' },
				{ 'h', '<c-w>h' },
				{ 'j', '<c-w>j' },
				{ 'k', '<c-w>k' },
				{ 'l', '<c-w>l' },
				{ 'H', '<c-w>H' },
				{ 'J', '<c-w>J' },
				{ 'K', '<c-w>K' },
				{ 'L', '<c-w>L' },
				{ '<c-b>', '<c-w><' },
				{ '<c-n>', '<c-w>+' },
				{ '<c-p>', '<c-w>-' },
				{ '<c-f>', '<c-w>>' },
				--{ 't', '<cmd>tab split<cr>' },
				{
					't',
					function()
						ui.split_win_to_tab()
					end,
				},
				{ 'c', 'ZZ' },
				{
					'x',
					function()
						vim.cmd 'wqa'
					end,
				},
			},
		}
		--h : jump
	end,
}
