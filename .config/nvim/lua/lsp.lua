---------------------change severity signs
--local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--[[used for cmp.setup.formatting
local kind_icons = {
	Class = "ﴯ",
	Color = "",
	Constant = "",
	Constructor = "",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "",
	File = "",
	Folder = "",
	Function = "",
	Interface = "",
	Keyword = "",
	Method = "",
	Module = "",
	Operator = "",
	Property = "ﰠ",
	Reference = "",
	Snippet = "",
	Struct = "",
	Text = "",
	TypeParameter = "",
	Unit = "",
	Value = "",
	Variable = "",
}
]] --

---------------------mason
require 'mason'.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

---------------------mason-lspconfig
require 'mason-lspconfig'.setup({
	ensure_installed = { 'sumneko_lua', 'rust_analyzer' }
})

---------------------lspconfig
-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			--vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
			vim_item.menu = ({
				--			nvim_lsp = "[LSP]",
				spell = "Spl",
				zsh = "Zsh",
				buffer = "Buf",
				luasnip = "Snp",
				treesitter = "TS",
				--				calc = "[Calculator",
				nvim_lua = "Lua",
				path = "Path",
				nvim_lsp_signature_help = "Sign",
				cmdline = "Vim"
			})[entry.source.name]
			return vim_item
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<a-k>'] = cmp.mapping.scroll_docs(-10),
		['<a-j>'] = cmp.mapping.scroll_docs(10),
		--		['<C-Space>'] = cmp.mapping.complete(),
		['<c-c>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
		['<c-n>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's', 'c' }),
		['<c-p>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's', 'c' }),
	}),
	experimental = {
		ghost_text = true
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'nvim_lsp_signature_help' }
	},
}

cmp.setup.cmdline('/', {
	sources = cmp.config.sources({
		{ name = 'nvim_lsp_document_symbol' },
		{ name = 'buffer' }
	})
})

cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'cmdline' }
	})
})

--see more detail at https://github.com/neovim/nvim-lspconfig
local on_attach = function(client, bufnr)
	local bufopts = { silent = true, buffer = bufnr }
	vim.keymap.set('n', '<space>s', vim.lsp.buf.signature_help, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

--lspsaga
--requires nightly
--[[
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
		-- if work in statusline
		vim.wo.stl = win_val
	end
end

local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }

vim.api.nvim_create_autocmd(events, {
	pattern = '*',
	callback = function() config_winbar_or_statusline() end,
})

vim.api.nvim_create_autocmd('User', {
	pattern = 'LspsagaUpdateSymbol',
	callback = function() config_winbar_or_statusline() end,
})
]] --

--rust_analyzer
require('lspconfig')['rust_analyzer'].setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	-- Server-specific settings...
	settings = {
		["rust-analyzer"] = {
			procMacro = {
				enable = true
			}
		}
	}
}

--lua
require 'lspconfig'.sumneko_lua.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}
