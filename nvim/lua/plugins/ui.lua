return {
	'rcarriga/nvim-notify',
	{
		'folke/noice.nvim',
		event = 'VeryLazy',
		dependencies = { 'MunifTanjim/nui.nvim' },
		opts = {
			presets = { bottom_search = true, long_message_to_split = true },
		},
		--config = function() require('noice').setup end,
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = true,
	},
	{
		'norcalli/nvim-colorizer.lua',
		main = 'colorizer',
	},
	{
		'rebelot/heirline.nvim',
		dependencies = { 'catppuccin/nvim', 'SmiteshP/nvim-navic', 'lewis6991/gitsigns.nvim' },
		config = function()
			local cnds = require 'heirline.conditions'
			local utils = require 'heirline.utils'
			local symbols = require 'symbols'

			local function hl()
				return vim.o.background == 'light'
						and require('catppuccin.palettes').get_palette 'mocha'
					or require('catppuccin.palettes').get_palette 'latte' --'frappe'
			end

			local function color_code_of(hl_name)
				local function to_rgb(decimal)
					return '#' .. string.format('%06x', decimal)
				end

				local hl_set = vim.api.nvim_get_hl(0, { name = hl_name })

				if hl_set.fg ~= nil then
					hl_set.fg = to_rgb(hl_set.fg)
				end
				if hl_set.bg ~= nil then
					hl_set.bg = to_rgb(hl_set.bg)
				end
				if hl_set.sp ~= nil then
					hl_set.sp = to_rgb(hl_set.sp)
				end

				return hl_set
			end

			local align = {
				provider = '%=',
			}

			local mode = {
				init = function(self)
					self.mode = vim.fn.mode()
				end,
				static = {
					mode_names = {
						n = 'N',
						no = 'N?',
						nov = 'N?',
						noV = 'N?',
						['no\22'] = 'N?',
						niI = 'Ni',
						niR = 'Nr',
						niV = 'Nv',
						nt = 'Nt',
						v = 'V',
						vs = 'Vs',
						V = 'V_',
						Vs = 'V_s',
						['\22'] = 'V|',
						['\22s'] = 'V|s',
						s = 'S',
						S = 'S_',
						['\19'] = 'S|',
						i = 'I',
						ic = 'Ic',
						ix = 'Ix',
						R = 'R',
						Rc = 'Rc',
						Rx = 'Rx',
						Rv = 'Rv',
						Rvc = 'Rvc',
						Rvx = 'Rvx',
						c = 'C',
						cv = 'Ex',
						r = '…',
						rm = 'M',
						['r?'] = '?',
						['!'] = '!',
						t = 'T',
					},
					mode_hls = function()
						return {
							n = hl().blue,
							i = hl().green,
							v = hl().mauve,
							V = hl().mauve,
							['\22'] = hl().mauve,
							c = hl().yellow,
							s = hl().lavender,
							S = hl().lavender,
							['\19'] = hl().lavender,
							r = hl().sky,
							R = hl().sky,
							t = hl().red,
							['!'] = hl().red,
						}
					end,
				},
				provider = function(self)
					return '%2(' .. self.mode_names[self.mode] .. '%) '
				end,
				hl = function(self)
					local mode = self.mode:sub(1, 1)
					return { fg = hl().crust, bg = self.mode_hls()[mode], bold = true }
				end,
				update = 'ModeChanged',
				callback = vim.schedule_wrap(function()
					vim.cmd 'redrawstatus'
				end),
			}

			local path_block = {
				init = function(self)
					self.path = vim.api.nvim_buf_get_name(0)
				end,
				hl = { bg = hl().lavender, bold = true },
			}
			local icon = {
				init = function(self)
					self.icon, self.icon_color =
						require('nvim-web-devicons').get_icon_colors_by_filetype(vim.bo.filetype)
				end,
				provider = function(self)
					return ' ' .. (self.icon or '') .. ' '
				end,
				hl = function(self)
					return { fg = self.icon_color, bg = hl().base }
				end,
			}
			local path = {
				provider = function(self)
					local rslt = ''
					if self.path == '' or self.path == nil then
						rslt = vim.bo.filetype
					else
						rslt = self.path
					end
					return rslt .. ' '
				end,
				hl = { fg = hl().base },
			}
			local buf_flag = {
				{
					condition = function()
						return vim.bo.modified
					end,
					provider = function()
						return ' '
					end,
					hl = { fg = hl().mauve },
				},
				{
					condition = function()
						return vim.bo.readonly
					end,
					provider = ' ',
					hl = { fg = hl().text },
				},
				{
					condition = function()
						return vim.api.nvim_win_get_config(0).relative ~= ''
					end,
					provider = '󱂬 ',
					hl = { fg = hl().rosewater },
				},
			}
			-- Now, let's say that we want the filename color to change if the buffer is
			-- modified. Of course, we could do that directly using the FileName.hl field,
			-- but we'll see how easy it is to alter existing components using a "modifier"
			-- component

			path_block = utils.insert(
				path_block,
				icon,
				path,
				buf_flag,
				{ provider = '%<' }
				--{ provider = '', hl = { fg = hl().surface1, bg = hl().base } }
			)

			local ruler = {
				-- %l = current line number
				-- %c = column number
				-- %P = percentage through file of displayed window
				provider = ' %l:%c ',
				hl = { fg = hl().text },
			}

			local lsp_attached = {
				condition = cnds.lsp_attached,
				update = { 'LspAttach', 'LspDetach' },
				provider = function()
					local names = {}
					for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
						table.insert(names, server.name)
					end
					return ' [' .. table.concat(names, ' ') .. ']'
				end,
				hl = { bg = hl().peach },
			}

			local navic = {
				condition = function()
					return require('nvim-navic').is_available()
				end,
				static = {
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
					enc = function(line, col, winnr)
						return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
					end,
					dec = function(c)
						local line = bit.rshift(c, 16)
						local col = bit.band(bit.rshift(c, 6), 1023)
						local winnr = bit.band(c, 63)
						return line, col, winnr
					end,
				},
				init = function(self)
					local data = require('nvim-navic').get_data() or {}
					local children = { provider = ' ' }
					for i, o in ipairs(data) do
						local pos = self.enc(o.scope.start.line, o.scope.start.character, self.winnr)
						local child = {
							hl = self.type_hl[o.type],
							{
								provider = o.icon,
							},
							{
								provider = ' ' .. o.name:gsub('%%', '%%%'):gsub('%s*->%s*', ''),
								on_click = {
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
						if #data > 1 and i < #data then
							table.insert(child, {
								provider = '/',
							})
						end
						table.insert(children, child)
					end
					self.child = self:new(children, 1)
				end,
				provider = function(self)
					return self.child:eval()
				end,
				hl = { bg = hl().base },
				--				update='CursorMoved'
			}

			local diags = {
				condition = cnds.has_diagnostics,
				init = function(self)
					local get = vim.diagnostic.get
					local severity = vim.diagnostic.severity
					self.errors = #get(0, { severity = severity.ERROR })
					self.warns = #get(0, { severity = severity.WARN })
					self.hints = #get(0, { severity = severity.HINT })
					self.infos = #get(0, { severity = severity.INFO })
				end,
				update = { 'DiagnosticChanged', 'BufEnter' },

				{
					provider = function(self)
						return self.errors == 0 or symbols.DiagnosticError .. ' ' .. self.errors .. ' '
					end,
					hl = { fg = color_code_of('DiagnosticError').fg },
				},
				{
					provider = function(self)
						return self.warns == 0 or symbols.DiagnosticWarn .. ' ' .. self.warns .. ' '
					end,
					hl = { fg = color_code_of('DiagnosticWarn').fg },
				},
				{
					provider = function(self)
						return self.infos == 0 or symbols.DiagnosticInfo .. ' ' .. self.infos .. ' '
					end,
					hl = { fg = color_code_of('DiagnosticInfo').fg },
				},
				{
					provider = function(self)
						return self.hints == 0 or symbols.DiagnosticHint .. ' ' .. self.hints .. ' '
					end,
					hl = { fg = color_code_of('DiagnosticHint').fg },
				},
			}

			local git = {
				condition = cnds.is_git_repo,
				init = function(self)
					self.status_dict = vim.b.gitsigns_status_dict
					self.has_changes = self.status_dict.added ~= 0
						or self.status_dict.changed ~= 0
						or self.status_dict.removed ~= 0
				end,
				hl = { bg = hl().mantle },
				{
					provider = function(self)
						local count = self.status_dict.added or 0
						return count > 0 and '+' .. count
					end,
					--hl = { fg = color_code_of('GitSignsAdd').fg },
					hl = { fg = hl().green },
				},
				{
					provider = function(self)
						local count = self.status_dict.changed or 0
						return count > 0 and ' ~' .. count
					end,
					--hl = { fg = color_code_of('GitSignsChange').fg },
					hl = { fg = hl().yellow },
				},
				{
					provider = function(self)
						local count = self.status_dict.removed or 0
						return count > 0 and ' -' .. count
					end,
					--hl = { fg = color_code_of('GitSignsDelete').fg },
					hl = { fg = hl().red },
				},
				{
					-- branch
					provider = function(self)
						return '  ' .. self.status_dict.head .. ' '
					end,
					hl = { bg = hl().peach, bold = true },
				},
			}

			local statusline = {
				hl = { bg = hl().surface1 },
				{ path_block, navic },
			}
			local winbar = {
				condition = function()
					return vim.api.nvim_win_get_config(0).relative == ''
				end,
				hl = { fg = hl().base },
				{ mode, lsp_attached, align, diags, align, ruler, git },
			}
			local tabline = {}

			require('heirline').setup {
				statusline = statusline,
				winbar = winbar,
				tabline = tabline,
			}
		end,
	},
}
