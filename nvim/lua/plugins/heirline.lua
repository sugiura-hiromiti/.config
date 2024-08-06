return {
	'rebelot/heirline.nvim',
	config = function()
		local symbols = require 'symbols'
		local utils = require 'heirline.utils'
		local cond = require 'heirline.conditions'
		local status_git = vim.b.gitsigns_status_dict

		local align = { provider = '%=' }
		local mode =
			{ provider = vim.fn.mode() .. ' ', update = 'ModeChanged', hl = { bg = utils.get_highlight('Normal').fg } }
		local path = {
			pick_child = { 2, 1 },
			fallthrough = false,
			{ provider = '%Y' },
			{
				provider = function()
					local path = vim.api.nvim_buf_get_name(0)

					local slash_pos = path:find '/'
					local next_slash_pos = path:find('/', slash_pos + 1)
					while next_slash_pos do
						path = path:sub(slash_pos + 1)
						slash_pos = path:find '/'
						next_slash_pos = path:find('/', slash_pos + 1)
					end

					return path
				end,
				condition = function()
					return vim.api.nvim_buf_get_name(0) ~= ''
				end,
			},
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
			{
				provider = '![',
			},
			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
				end,
				hl = { fg = utils.get_highlight('DiagnosticError').fg },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
				end,
				hl = { fg = utils.get_highlight('DiagnosticWarn').fg },
			},
			{
				provider = function(self)
					return self.info > 0 and (self.info_icon .. self.info .. ' ')
				end,
				hl = { fg = utils.get_highlight('DiagnosticInfo').fg },
			},
			{
				provider = function(self)
					return self.hints > 0 and (self.hint_icon .. self.hints)
				end,
				hl = { fg = utils.get_highlight('DiagnosticHint').fg },
			},
			{
				provider = ']',
			},
		}
		local git = { condition = cond.is_git_repo }
		local location = {
			provider = '%l/%L:%c',
		}

		require('heirline').setup { statusline = { mode, path, navic, align, diag, git, location } }
	end,
}
