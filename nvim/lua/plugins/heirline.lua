return {
	'rebelot/heirline.nvim',
	config = function()
		local symbols = require 'symbols'
		local hl = require('heirline.utils').get_highlight
		local cond = require 'heirline.conditions'

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
		}
		local navic = {
			provider = function()
				return require('nvim-navic').get_location { highlight = true }
			end,
			condition = function()
				return require('nvim-navic').is_available()
			end,
		}
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
			hl = { bg = '#000000' },
			{
				provider = '![',
			},
			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
				end,
				hl = { fg = hl('DiagnosticError').fg },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
				end,
				hl = { fg = hl('DiagnosticWarn').fg },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. ' ')
				end,
				hl = { fg = hl('DiagnosticInfo').fg },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = hl('DiagnosticHint').fg },
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
			hl = { bg = '#000000' },
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

		require('heirline').setup { statusline = { mode, path, navic, align, diag, git, location } }
	end,
}
