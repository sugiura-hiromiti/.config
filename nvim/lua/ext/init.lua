local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

-- listup plugins which is difficult to classify
local plugins = {
	{
		'chrisgrieser/nvim-recorder',
		config = function()
			require('recorder').setup {
				mapping = { startStopRecording = '<f9>' },
			}
		end,
	},
}

-- make sure that each file returns table of plugins
local load_plugins = {
	require 'ext.lib',
	require 'ext.ui',
	require 'ext.write',
	require 'ext.ts',
	require 'ext.lsp',
	require 'ext.cmps',
	require 'ext.telescopes',
}

for _, t in pairs(load_plugins) do
	for _, p in pairs(t) do
		table.insert(plugins, p)
	end
end

require('lazy').setup(plugins)
