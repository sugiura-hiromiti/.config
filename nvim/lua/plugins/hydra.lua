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
_e_ file browser _c_ help
_x_ float term

else
_g_ gitui _s_ ssr <esc> exit
]],
			heads = {
				{ 'a', '<cmd>Lspsaga code_action<cr>' },
				{ 'r', l.rename },
				{ 'h', l.hover },
				{ 'l', '<cmd>Lspsaga finder<cr>' },
				--{ 'd', '<cmd>Lspsaga show_workspace_diagnostics<cr>' },
				{ 'd', tb.diagnostics },
				{
					'o',
					function()
						if vim.bo.ft == 'lua' or vim.bo.ft == 'markdown' then
							tb.lsp_document_symbols { show_line = true }
						else
							tb.lsp_workspace_symbols { show_line = true }
						end
					end,
				},
				{ 'b', tb.builtin },
				{ 'f', te.smart_open.smart_open },
				{ 'n', te.notify.notify },
				-- {
				-- 	'e',
				-- 	function()
				-- 		oil.open(nil, { preview = { vertical = true, split = 'topleft' } }, function()
				-- 			local filer_win = vim.api.nvim_get_current_win()
				-- 			vim.api.nvim_win_set_width(filer_win, 40)
				-- 		end)
				-- 	end,
				-- },
				{ 'e', te.file_browser.file_browser },
				{ 't', '<cmd>TodoTelescope<cr>' },
				{ 'g', '<cmd>Gitui<cr>' },
				{ 's', require('ssr').open },
				{ 'c', tb.help_tags },
				{ 'x', '<cmd>Lspsaga term_toggle<cr>' },
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
_<c-b>_ _<c-n>_ _<c-p>_ _<c-f>_ resize
_t_ split new tab _c_ close _x_ exit
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
				{ '<c-b>', '<c-w><' },
				{ '<c-n>', '<c-w>+' },
				{ '<c-p>', '<c-w>-' },
				{ '<c-f>', '<c-w>>' },
				--{ 't', '<cmd>tab split<cr>' },
				{
					't',
					function()
						local win = vim.api.nvim_get_current_win()
						local buf = vim.api.nvim_get_current_buf()

						-- saves the buffer
						vim.api.nvim_buf_call(buf, function()
							vim.cmd 'update'
						end)

						-- split window
						vim.api.nvim_win_close(win, true)
						vim.cmd 'tabnew'
						vim.api.nvim_set_current_buf(buf)
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
