-- ╭──────────────────────────────────────────────────────────╮
-- │ Write Unclassifiable settings into init.lua              │
-- ╰──────────────────────────────────────────────────────────╯
vim.cmd'colo nord'

local filenam = vim.fn.expand("%:p") --open vimrc if no path given
if filenam == '' then
	vim.cmd [[e $MYVIMRC]]
end

local signs = { Error = "", Warn = "", Hint = "", Info = "" } --change severity signs
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require 'plugins'
require 'variables'
require 'commands'
require 'mappings'
require 'lsp'
