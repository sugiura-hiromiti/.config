local symbols = {
	Text = '󰉿',
	Method = '󰆧',
	Function = '󰊕',
	Field = '󰜢',
	Variable = '󰀫',
	Unit = '󰑭',
	Class = '󰠱',
	Value = '󰎠',
	Keyword = '󰌋',
	Snippet = '',
	Color = '󰏘',
	File = '󰈙',
	Reference = '󰈇',
	Folder = '󰉋',
	EnumMember = '',
	Constant = '󰏿',
	Struct = '󰙅',
	Event = '',
	Operator = '󰆕',
	TypeParameter = '',
	Copilot = '',
	Module = '',
	Namespace = '󰌗 ',
	Package = '',
	Property = '',
	Constructor = '',
	Interface = '󰕘',
	String = '󰀬',
	Number = '󰎠',
	Boolean = '◩',
	Array = '󰅪',
	Object = '󰅩',
	Key = '󰌋',
	Null = '󰟢',
	Enum = '󰆧',
	DiagnosticError = '',
	DiagnosticWarn = '',
	DiagnosticInfo = '󰋽',
	DiagnosticHint = '',
	Version = ' ',
	Feature = '󰩉 ',
}

vim.diagnostic.config {
	jump = { float = true },
	signs = {
		{
			text = {
				[vim.diagnostic.severity.ERROR] = symbols.DiagnosticError,
				[vim.diagnostic.severity.WARN] = symbols.DiagnosticWarn,
				[vim.diagnostic.severity.INFO] = symbols.DiagnosticInfo,
				[vim.diagnostic.severity.HINT] = symbols.DiagnosticHint,
			},
		},
	},
}
return symbols
