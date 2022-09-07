local filenam = vim.fn.expand("%:p")
if filenam == '' then
	vim.cmd [[e $MYVIMRC]]
end

-----------------------------------------------------set variables
local opt = vim.opt
opt.relativenumber = true
opt.cursorline = true
opt.cursorcolumn = true
opt.swapfile = false
opt.writebackup = false
opt.updatetime = 100
opt.mouse = 'a'
opt.autowriteall = true
opt.termguicolors = true
opt.clipboard:append { 'unnamedplus' }
opt.list = true
opt.listchars = {
	tab = '│ ',
}

local g = vim.g
g.python3_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/python3'
g.node_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv('RUBY_HOST')
g.mapleader = "<cr>"
g.xcodelight_green_comments = true
g.xcodelighthc_green_comments = true
g.xcodedark_green_comments = true
g.xcodedarkhc_green_comments = true
g.material_terminal_italic = true
g.tokyonight_day_brightness = 0.315
g.tokyonight_lualine_bold = true
g.PaperColor_Theme_Options = {
	theme = {
		default = {
			allow_bold = true,
			allow_italic = true
		}
	},
	language = {
		cpp = {
			highlight_standard_library = true
		},
		c = {
			highlight_builtins = true
		}
	}
}
g.edge_menu_selection_background = 'green'
g.neosolarized_contrast = 'high'
g.neosolarized_visibility = 'high'
g.neosolarized_vertSplitBgTrans = true
g.neosoloarized_italic = true
g.everforest_background = 'hard'
g.everforest_enable_italic = true
g.everforest_ui_contrast = 'high'
g.everforest_diagnostic_text_highlight = true
g.palenight_terminal_italics = true
g.oceanic_next_terminal_italic = true
g.oceanic_next_terminal_bold = true
g.sunset_latitude = 35.02
g.sunset_longitude = 135
g.lexima_ctrlh_as_backspace = true

-----------------------------------------------------autocmd
local autocmd = vim.api.nvim_create_autocmd
autocmd('colorscheme', {
	pattern = 'cobalt2',
	command = 'hi CursorLine guibg=#001122'
})
autocmd('colorscheme', {
	pattern = 'cobalt2',
	command = 'hi CursorLineNr guibg=#001122'
})
autocmd('colorscheme', {
	pattern = 'cobalt2',
	command = 'hi CursorColumn guibg=#001122'
})
--[[
autocmd('bufleave', {
	command = 'update'
})
autocmd('insertleave', {
	command = 'update'
})
]] --
autocmd('vimenter', {
	command = [[luado if os.getenv'PROFILE_NAME'=='hotkey' then vim.o.background='dark' end]]
})
autocmd('vimenter', {
	command = 'set tabstop=3'
})
autocmd('vimenter', {
	command = 'set softtabstop=3'
})
autocmd('vimenter', {
	command = 'set shiftwidth=3'
})
autocmd({ 'insertleave', 'bufwritepre' }, {
	pattern = { '*.rs', '*.lua', '*.cpp' },
	callback = function() vim.lsp.buf.formatting_sync()
	end
})

-----------------------------------------------------usercmd
local mycmd = vim.api.nvim_create_user_command
mycmd('Edge', function(opts)
	g.edge_style = opts.args
	vim.cmd 'colorscheme edge'
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		return { 'default', 'aura', 'neon' }
	end
})
mycmd('Wwdc17', function(opts)
	g.wwdc17_frame_color = opts.args
	vim.cmd 'colorscheme wwdc17'
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		return { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15' }
	end
})

require 'mappings'
require 'plugins'
require 'lsp'
require 'fuzzy'
require 'color_randomizer'
