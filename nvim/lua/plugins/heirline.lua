return {
	'rebelot/heirline.nvim',
	config = function()
		local symbols = require 'my_lua_api.symbols'
		local hl = require('heirline.utils').get_highlight
		local cond = require 'heirline.conditions'
		local lsp_symbol = require('lspsaga.symbol.winbar').get_bar
		--		local gps = require 'nvim-gps'

		local align = { provider = '%=' }

		local mode = {
			{ provider = vim.fn.mode() .. ' ', update = 'ModeChanged' },
			{
				provider = function()
					return require('hydra.statusline').get_name() .. ' '
				end,
				condition = function()
					return require('hydra.statusline').is_active()
				end,
			},
		}

		local symbol_bar_or_ft = {
			{
				provider = lsp_symbol,
			},
			{
				condition = function()
					if lsp_symbol() ~= nil then
						return false
					else
						return true
					end
				end,
				provider = function()
					return vim.bo.ft
				end,
			},
			--[[
						{
				condition = function()
					return vim.bo.ft == 'lisp' or vim.bo.ft == 'scheme'
				end,
				provider = gps.get_location,
			},
]]
		}

		--[[
				local path = {
			provider = function()
				local path = vim.api.nvim_buf_get_name(0)
				if path == '' then
					path = vim.bo.ft
				else
					local slash_pos = path:find '/'
					local next_slash_pos = path:find('/', slash_pos + 1)
					while next_slash_pos do
						path = path:sub(slash_pos + 1)
						slash_pos = path:find '/'
						next_slash_pos = path:find('/', slash_pos + 1)
					end
				end

				return path
			end,
			hl = hl '@string.special.path',
		}
		local navic = {
			provider = function(self)
				return self.child:eval()
			end,
			static = {
				-- create a type highlight map
				type_hl = {
					File = 'Directory',
					Module = '@include',
					Namespace = '@namespace',
					Package = '@include',
					Class = '@structure',
					Method = '@method',
					Property = '@property',
					Field = '@field',
					Constructor = '@constructor',
					Enum = '@field',
					Interface = '@type',
					Function = '@function',
					Variable = '@variable',
					Constant = '@constant',
					String = '@string',
					Number = '@number',
					Boolean = '@boolean',
					Array = '@field',
					Object = '@type',
					Key = '@keyword',
					Null = '@comment',
					EnumMember = '@field',
					Struct = '@structure',
					Event = '@keyword',
					Operator = '@operator',
					TypeParameter = '@type',
				},
				-- bit operation dark magic, see below...
				enc = function(line, col, winnr)
					return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
				end,
				-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
				dec = function(c)
					local line = bit.rshift(c, 16)
					local col = bit.band(bit.rshift(c, 6), 1023)
					local winnr = bit.band(c, 63)
					return line, col, winnr
				end,
			},
			init = function(self)
				local data = require('nvim-navic').get_data() or {}
				local children = {}
				-- create a child for each level
				for i, d in ipairs(data) do
					-- encode line and column numbers into a single integer
					local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
					local child = {
						{
							provider = ' ' .. d.icon .. ' ',
							hl = self.type_hl[d.type],
						},
						{
							-- escape `%`s (elixir) and buggy default separators
							provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
							-- highlight icon only or location name as well
							-- hl = self.type_hl[d.type],

							on_click = {
								-- pass the encoded position through minwid
								minwid = pos,
								callback = function(_, minwid)
									-- decode
									local line, col, winnr = self.dec(minwid)
									vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
								end,
								name = 'heirline_navic',
							},
						},
					}
					-- add a separator only if needed
					if #data > 1 and i < #data then
						table.insert(child, {
							provider = ' >',
							--hl = { fg = 'bright_fg' },
						})
					end
					table.insert(children, child)
				end
				-- instantiate the new child, overwriting the previous one
				self.child = self:new(children, 1)
			end,
			condition = function()
				return require('nvim-navic').is_available()
			end,
		}
		]]

		local diag = {
			condition = cond.has_diagnostics,
			static = {
				error_icon = symbols.DiagnosticError,
				warn_icon = symbols.DiagnosticWarn,
				info_icon = symbols.DiagnosticInfo,
				hint_icon = symbols.DiagnosticHint,
			},
			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,
			update = { 'DiagnosticChanged', 'BufEnter' },
			{
				provider = '![',
			},
			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. ' ' .. self.errors .. ' ')
				end,
				hl = hl '@comment.error',
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. ' ' .. self.warnings .. ' ')
				end,
				hl = hl '@comment.warning',
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. ' ' .. self.info .. ' ')
				end,
				hl = hl '@comment.note',
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. ' ' .. self.hints)
				end,
				hl = hl '@comment.hint',
			},
			{
				provider = ']',
			},
		}

		local git = {
			condition = cond.is_git_repo,

			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= 0
					or self.status_dict.removed ~= 0
					or self.status_dict.changed ~= 0
			end,
			{
				provider = function(self)
					return ' ' .. self.status_dict.head
				end,
				hl = { bold = true },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = '(',
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					return count > 0 and ('+' .. count)
				end,
				hl = { fg = hl('GitSignsAdd').fg },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					return count > 0 and ('-' .. count)
				end,
				hl = { fg = hl('GitSignsDelete').fg },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					return count > 0 and ('~' .. count)
				end,
				hl = { fg = hl('GitSignsChange').fg },
			},
			{
				condition = function(self)
					return self.has_changes
				end,
				provider = ')',
			},
		}

		local location = {
			provider = ' %l:%c',
		}

		require('heirline').setup { statusline = { mode, diag, align, symbol_bar_or_ft, align, git, location } }
	end,
}
