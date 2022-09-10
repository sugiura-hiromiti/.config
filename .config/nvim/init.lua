--[[
╭───────────────────────────────────────────╮
│Write Unclassifiable settings into init.lua│
╰───────────────────────────────────────────╯]] --
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

require 'variables'
require 'commands'
require 'mappings'
require 'plugins'
require 'lsp'
--require 'color_randomizer'
