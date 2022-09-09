vim.cmd 'colo PaperColor'

-----------------------------------------------------open vimrc if no path given
local filenam = vim.fn.expand("%:p")
if filenam == '' then
	vim.cmd [[e $MYVIMRC]]
end

-----------------------------------------------------change severity signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-----------------------------------------------------set variables
local opt = vim.opt
opt.relativenumber = true
opt.cursorline = true
opt.cursorcolumn = true
opt.swapfile = false
opt.writebackup = false
opt.updatetime = 50
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
--g.mapleader = "<cr>"
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
g.sunset_latitude = 35.02
g.sunset_longitude = 135

-----------------------------------------------------autocmd
local autocmd = vim.api.nvim_create_autocmd
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
	callback = function() vim.lsp.buf.format { async = true }
	end
})

local function exclude_ft()
	local blacklist = { 'TelescopePrompt', 'TelescopeResults', 'frecency' }
	local ft = vim.bo.filetype
	local is_black --nil on init
	for _, value in ipairs(blacklist) do
		if ft == value then
			is_black = true
			break
		end
	end
	if not is_black then
		vim.cmd 'update'
	end
end

autocmd({ 'insertleave', 'bufwritepre' }, {
	callback = function() exclude_ft() end
})

autocmd({ 'cmdwinenter' }, {
	command = 'wincmd L'
})

-----------------------------------------------------usercmd
--local mycmd = vim.api.nvim_create_user_command

require 'mappings'
require 'plugins'
require 'lsp'
--require 'color_randomizer'
