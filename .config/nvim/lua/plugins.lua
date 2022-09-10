require 'packer'.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'NLKNguyen/papercolor-theme' --colorscheme
	--use 'nvim-lualine/lualine.nvim' --UI related
	use 'kyazdani42/nvim-web-devicons'
	use 'amdt/sunset'
	use 'ah-y/vim-transparent'
	use 'windwp/nvim-autopairs' --utility
	use 'rcarriga/nvim-notify'
	use 'nvim-lua/plenary.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' } --telescope
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	use { 'nvim-telescope/telescope-frecency.nvim',
		config = function()
		end,
		requires = { 'kkharji/sqlite.lua' } }
	use 'nvim-telescope/telescope-file-browser.nvim'
	use 'williamboman/mason.nvim' --lsp
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({
				-- your configuration
				symbol_in_winbar = {
					in_custom = true
				},
				code_action_lightbulb = {
					sign = false
				},
				show_outline = {
					win_width = 36
				},
			})
		end,
	})
	use 'onsails/lspkind.nvim'
	use 'hrsh7th/nvim-cmp' --completion source
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'mfussenegger/nvim-dap' --dap
end)

--[[
---------------------lualine
require 'lualine'.setup({
	options = {
		always_divide_middle = false,
		globalstatus = true,
	},
	sections = {
		lualine_a = { 'location' },
		lualine_b = { 'mode' },
		lualine_c = { '@%' },
		lualine_x = { 'diagnostics' },
		lualine_y = { 'branch' },
		lualine_z = { 'filetype' },
	},
	extensions = {
		'nvim-dap-ui', 'quickfix',
	}
})
]] --

---------------------autopairs
require 'nvim-autopairs'.setup({
	map_c_h = true
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

---------------------notify
local notify = require 'notify'
notify.setup({
	background_colour = '#000000',
})
vim.notify = notify

---------------------telescope
require 'telescope'.setup {
	extensions = {
		file_browser = {
			hijack_netrw = true,
			hidden = true
		},
		fzf = {
			fuzzy = true,
		}
	}
}
require 'telescope'.load_extension 'frecency'
require 'telescope'.load_extension 'file_browser'
require 'telescope'.load_extension 'fzf'

---------------------treesitter
require 'nvim-treesitter.configs'.setup {
	ensure_installed = { 'rust', 'lua', 'markdown', 'toml' },
	sync_install = true,
	auto_install = true,
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = false
	}
}

--lspsaga
local function get_file_name(include_path)
	local file_name = require('lspsaga.symbolwinbar').get_file_name()
	if vim.fn.bufname '%' == '' then return '' end
	if include_path == false then return file_name end
	-- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
	local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
	local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%', ''), sep)
	local file_path = ''
	for _, cur in ipairs(path_list) do
		file_path = (cur == '.' or cur == '~') and '' or
			 file_path .. cur .. ' ' .. '%#LspSagaWinbarSep#>%*' .. ' %*'
	end
	return file_path .. file_name
end

local function config_winbar_or_statusline()
	local exclude = {
		['teminal'] = true,
		['toggleterm'] = true,
		['prompt'] = true,
		['NvimTree'] = true,
		['help'] = true,
		['TelescopePrompt'] = true,
		['TelescopeResults'] = true,
		['frecency'] = true,
	} -- Ignore float windows and exclude filetype
	if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
		vim.wo.winbar = ''
	else
		local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
		local sym
		if ok then sym = lspsaga.get_symbol_node() end
		local win_val = ''
		win_val = get_file_name(true) -- set to true to include path
		if sym ~= nil then win_val = win_val .. sym end
		--		vim.wo.winbar = win_val
		-- if work in statusline
		vim.wo.stl = win_val
	end
end

local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved', 'CursorMovedI' }

vim.api.nvim_create_autocmd(events, {
	pattern = '*',
	callback = function() config_winbar_or_statusline() end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'LspsagaUpdateSymbol',
	callback = function() config_winbar_or_statusline() end,
})

---------------------dap
local function lldb_path()
	local hndl = io.popen('which lldb-vscode')
	if not hndl then return nil end
	local rslt = hndl:read 'a'
	hndl:close()
	return rslt
end

local dap = require 'dap'
dap.adapters.lldb = {
	type = 'executable',
	command = lldb_path(),
	name = 'lldb'
}

dap.configurations.rust = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.c = dap.configurations.rust
dap.configurations.c = { {
	program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end
} }
dap.configurations.cpp = dap.configurations.c
