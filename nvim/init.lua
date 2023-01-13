if vim.fn.expand '%:p' == '' then
	vim.cmd [[e $MYVIMRC]]
end
vim.cmd 'colo catppuccin'

local p = vim.opt
p.list = true
p.listchars = { tab = '│ ' }
p.pumblend = 22
p.relativenumber = true
p.number = true
p.autowriteall = true
p.termguicolors = true
p.clipboard:append { 'unnamedplus' }
p.autochdir = true
p.laststatus = 0
vim.g.editorconfig = true

local aucmd = vim.api.nvim_create_autocmd
-- Just using `set fo-=cro` won't work since many filetypes set/expand `formatoption`
aucmd('filetype', {
	callback = function()
		p.fo = { j = true }
	end,
})

local usrcmd = vim.api.nvim_create_user_command
usrcmd('Make', function(opts)
	local cmd = '<cr> '
	local ft = vim.bo.filetype
	if ft == 'rust' then
		cmd = '!cargo '
	elseif ft == 'swift' then
		cmd = '!swift ' .. vim.fn.expand '%:t'
	elseif ft == 'lua' or ft == 'cpp' or ft == 'c' then
		cmd = '!make '
	end
	vim.cmd(cmd .. opts.args)
end, { nargs = '*' })

local map = vim.keymap.set
map('n', '<esc>', '<cmd>noh<cr>') -- <esc> to noh
map('i', '<c-[>', '<c-[><cmd>update | lua vim.lsp.buf.format{async=true}<cr>')
map({ 'n', 'v' }, '$', '^') -- swap $ & ^
map({ 'n', 'v' }, '^', '$')
map({ 'n', 'v' }, ',', '@:') --repeat previous command
map('i', '<c-n>', '<down>') --emacs keybind
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-u>', '<c-c>v^s')
map('i', '<a-d>', '<right><c-c>ves')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left>')
map({ 'n', 'v' }, '<tab>', require('todo-comments').jump_next)
map({ 'n', 'v' }, '<s-tab>', require('todo-comments').jump_prev)
map('n', '<cr>', ':Make ') -- execute shell command
map('n', '<s-cr>', ':!')
map({ 'i', 'n', 'v' }, '<a-left>', '<c-w><') -- change window size
map({ 'i', 'n', 'v' }, '<a-down>', '<c-w>+')
map({ 'i', 'n', 'v' }, '<a-up>', '<c-w>-')
map({ 'i', 'n', 'v' }, '<a-right>', '<c-w>>')
map('n', 't', require('telescope.builtin').builtin) -- Telescope
map('n', '<space>o', require('telescope.builtin').lsp_document_symbols)
map('n', '<space>d', require('telescope.builtin').diagnostics)
map('n', '<space>b', function()
	require('telescope.builtin').buffers { ignore_current_buffer = true }
end)
map('n', '<space>e', require('telescope').extensions.file_browser.file_browser)
map('n', '<space>f', require('telescope').extensions.frecency.frecency)
map('n', '<space>c', '<cmd>TodoTelescope<cr>')
map('n', '<space>n', require('telescope').extensions.notify.notify)
map({ 'n', 'v' }, '<space>a', '<cmd>Lspsaga code_action<cr>')
map('n', '<space>j', '<cmd>Lspsaga lsp_finder<cr>') --`j` stands for jump
map('n', '<space>r', '<cmd>Lspsaga rename<cr>')
map('n', '<space>h', '<cmd>Lspsaga hover_doc<cr>')
map('n', '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
map('n', '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'kkharji/sqlite.lua'
	use 'MunifTanjim/nui.nvim'
	use 'nvim-tree/nvim-web-devicons'
	use {
		'sugiura-hiromichi/catppuccin',
		config = function()
			require('catppuccin').setup {
				integrations = { lsp_saga = true, noice = true, notify = true, semantic_tokens = true },
			}
		end,
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { 'bash', 'markdown_inline' },
				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
			}
		end,
	}
	use {
		'nvim-treesitter/nvim-treesitter-textobjects',
		config = function()
			require('nvim-treesitter.configs').setup {
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							['af'] = '@function.outer',
							['if'] = '@function.inner',
							['ac'] = '@class.outer',
							['ic'] = '@class.inner',
							['ab'] = '@block.outer',
							['ib'] = '@block.inner',
						},
						selection_modes = {
							['@block.outer'] = 'V',
						},
					},
					swap = {
						enable = true,
						swap_next = { ['<space>s'] = '@parameter.inner' },
						swap_previous = { ['<space>S'] = '@parameter.inner' },
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
						goto_next_end = { [']M'] = '@function.outer', [']['] = '@class.outer' },
						goto_previous_start = { ['[m'] = '@function.outer', ['[]'] = '@class.outer' },
						goto_previous_end = { ['[M'] = '@function.outer', ['[['] = '@class.outer' },
					},
				},
			}
		end,
	}
	use {
		'rcarriga/nvim-notify',
		config = function()
			vim.notify = require 'notify'
			vim.notify_once = require 'notify'
		end,
	}
	use {
		'folke/todo-comments.nvim',
		config = function()
			require('todo-comments').setup {
				keywords = {
					FIX = { alt = { 'e' } },
					TODO = { color = 'hint', alt = { 'q' } },
					HACK = { color = 'doc', alt = { 'a' } },
					WARN = { alt = { 'x' } },
					PERF = { color = 'cmt', alt = { 'p' } },
					NOTE = { color = 'info', alt = { 'd' } },
					TEST = { alt = { 't', 'PASS', 'FAIL' } },
				},
				colors = { cmt = { 'Comment' }, doc = { 'SpecialComment' } },
			}
		end,
	}
	--[[
	use {
		'folke/noice.nvim',
		config = function()
			require('noice').setup {
				presets = {
					bottom_search = true,
				},
			}
		end,
	}
	]]
	use {
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup { map_c_h = true }
		end,
	}
	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		config = function()
			require('telescope').setup {
				defaults = {
					mappings = {
						i = {
							['<a-j>'] = require('telescope.actions').preview_scrolling_down,
							['<a-k>'] = require('telescope.actions').preview_scrolling_up,
						},
					},
					winblend = 20,
					wrap_results = true,
					dynamic_preview_title = true,
				},
				extensions = { file_browser = { hidden = true, hide_parent_dir = true } },
			}
			require('telescope').load_extension 'frecency'
			require('telescope').load_extension 'file_browser'
		end,
	}
	use 'nvim-telescope/telescope-frecency.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use {
		'prochri/telescope-all-recent.nvim',
		config = function()
			require('telescope-all-recent').setup {
				default = {
					disable = false,
					use_cwd = true,
					sorting = 'frecency',
				},
				pickers = {
					git_commits = {
						disable = true,
					},
					git_bcommits = {
						disable = true,
					},
					['file_browser#file_browser'] = {
						disable = true,
					},
				},
			}
		end,
	}
	use {
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end,
	}
	use {
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup {
				ensure_installed = {
					'rust_analyzer@nightly',
					'sumneko_lua',
					'html',
					'cssls',
					'yamlls',
					'jsonls',
					'taplo',
					'marksman',
				},
			}
		end,
	}
	use {
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			require('lspconfig').rust_analyzer.setup {
				capabilities = capabilities,
				settings = {
					['rust-analyzer'] = {
						hover = { actions = { reference = { enable = true } } },
						inlayHints = {
							closingBraceHints = { minLines = 0 },
							lifetimeElisionHints = { enable = 'always', useParameterNames = true },
							maxLength = 0,
							typeHints = { hideNamedConstructor = false },
						},
						lens = { implementations = { enable = false } },
						rustfmt = { rangeFormatting = { enable = true } },
						semanticHighlighting = { operator = { specialization = { enable = true } } },
						typing = { autoClosingAngleBrackets = { enable = true } },
						workspace = { symbol = { search = { kind = 'all_symbols' } } },
					},
				},
			}
			require('lspconfig').sumneko_lua.setup {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim' } },
						workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}
			require('lspconfig').sourcekit.setup {
				filetypes = { 'swift', 'objective-c', 'objective-cpp' },
				capabilities = capabilities,
			}
			require('lspconfig').clangd.setup { capabilities = capabilities }
			require('lspconfig').html.setup { capabilities = capabilities }
			require('lspconfig').cssls.setup { capabilities = capabilities }
			require('lspconfig').yamlls.setup { capabilities = capabilities }
			require('lspconfig').jsonls.setup { capabilities = capabilities }
			require('lspconfig').taplo.setup { capabilities = capabilities }
			require('lspconfig').marksman.setup { capabilities = capabilities }
		end,
	}
	use {
		'glepnir/lspsaga.nvim',
		branch = 'main',
		config = function()
			require('lspsaga').setup {
				scroll_preview = { scroll_down = '<a-j>', scroll_up = '<a-k>' },
				lightbulb = { enable = false },
				finder = { vsplit = '<c-v>', split = '<c-x>' },
				rename = { in_select = false },
				symbol_in_winbar = { enable = false },
			}
		end,
	}
	use {
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local nls = require 'null-ls'
			local fmt = nls.builtins.formatting
			nls.setup {
				sources = {
					fmt.dprint.with { filetypes = { 'markdown', 'json', 'toml' } },
					fmt.stylua,
					fmt.prettier.with { filetypes = { 'css', 'html', 'yaml' } },
					fmt.beautysh.with { extra_args = { '-t' } },
					fmt.swiftformat,
				},
			}
		end,
	}
	use {
		'jayp0521/mason-null-ls.nvim',
		config = function()
			require('mason-null-ls').setup { ensure_installed = { 'beautysh' } }
		end,
	}
	use {
		'hrsh7th/nvim-cmp',
		config = function()
			local luasnip = require 'luasnip'
			local cmp = require 'cmp'
			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
				mapping = cmp.mapping.preset.insert {
					['<a-k>'] = cmp.mapping.scroll_docs(-10),
					['<a-j>'] = cmp.mapping.scroll_docs(10),
					['<c-c>'] = cmp.mapping.abort(),
					['<tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<bs>'] = cmp.mapping(function(fallback)
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<c-n>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<c-p>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
				},
				sources = {
					{ name = 'luasnip' },
					{ name = 'nvim_lsp' },
					{ name = 'nvim_lua' },
					{
						name = 'rg',
						option = { additional_arguments = '--smart-case', context_after = 7 },
						keyword_length = 2,
					},
					{ name = 'nvim_lsp_signature_help' },
				},
			}
			cmp.setup.cmdline('/', {
				sources = {
					{
						name = 'rg',
						option = { additional_arguments = '--smart-case', context_after = 7 },
						keyword_length = 2,
					},
				},
			})
			cmp.setup.cmdline(':', {
				sources = {
					{ name = 'path' },
					{ name = 'cmdline' },
					{
						name = 'rg',
						option = { additional_arguments = '--smart-case', context_after = 7 },
						keyword_length = 2,
					},
				},
			})
		end,
	}
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'lukas-reineke/cmp-rg'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
end)
