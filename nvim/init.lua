if vim.fn.expand '%:p' == '' then
	vim.cmd [[e $MYVIMRC]]
end

-- `vim.opt`
P = vim.opt
-- 'vim.keymap.set'
MAP = vim.keymap.set

require 'nvim_option'
require 'my_command'
require 'ext'
require 'map'
