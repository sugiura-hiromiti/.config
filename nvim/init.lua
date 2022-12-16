vim.cmd 'colo catppuccin'
if vim.fn.expand('%:p') == '' then vim.cmd [[e $MYVIMRC]] end

local p = vim.opt -- d: variables
p.list = true
p.listchars = {
	tab = '│ '
}
p.pumblend = 22
p.relativenumber = true
p.number = true
p.autowriteall = true
p.termguicolors = true
p.clipboard:append { 'unnamedplus' }
p.autochdir = true
p.laststatus = 0

local aucmd = vim.api.nvim_create_autocmd -- d: autocmd
aucmd('vimenter', {
	callback = function()
		p.softtabstop = 3
		p.tabstop = 3
		p.shiftwidth = 3
	end
})
-- d: Just using `set fo-=cro` won't work since many filetypes set/expand `formatoption`
aucmd('filetype', {
	callback = function()
		p.fo = {}
	end
})

local usrcmd = vim.api.nvim_create_user_command
usrcmd('Make', function(opts)
	local cmd, extra = '<cr> ', ''
	local ft = vim.bo.filetype
	if ft == 'rust' then
		cmd = '!cargo '
		extra = ' -q'
	elseif ft == 'lua' or ft == 'cpp' or ft == 'c' then
		cmd = '!make '
	end
	vim.cmd(cmd .. opts.args .. extra)
end, {
	nargs = '*',
})

local map = vim.keymap.set -- d: keymap
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
map('n', '<tab>', require 'todo-comments'.jump_next)
map('n', '<s-tab>', require 'todo-comments'.jump_prev)
map('n', '<cr>', ':Make ') -- execute shell command
map('n', '<s-cr>', ':!')
map({ 'i', 'n', 'v' }, '<a-h>', '<c-w><') -- change window size
map({ 'i', 'n', 'v' }, '<a-j>', '<c-w>+')
map({ 'i', 'n', 'v' }, '<a-k>', '<c-w>-')
map({ 'i', 'n', 'v' }, '<a-l>', '<c-w>>')
map('n', 't', require 'telescope.builtin'.builtin) -- Telescope
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)
map('n', '<space>b', require 'telescope.builtin'.buffers)
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map('n', '<space>c', '<cmd>TodoTelescope<cr>')
map('n', '<space>n', '<cmd>Telescope notify<cr>')
map({ 'n', 'v' }, '<space>a', '<cmd>Lspsaga code_action<cr>')
map('n', '<space>j', '<cmd>Lspsaga lsp_finder<cr>') --`j` stands for jump
map('n', '<space>r', '<cmd>Lspsaga rename<cr>')
map('n', '<space>h', '<cmd>Lspsaga hover_doc<cr>')
map('n', '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
map('n', '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')

require 'packer'.startup(function(use) -- d: package
	use 'wbthomason/packer.nvim' -- NOTE: required
	use 'nvim-lua/plenary.nvim'
	use 'kkharji/sqlite.lua'
	use 'MunifTanjim/nui.nvim'
	use 'nvim-tree/nvim-web-devicons' -- NOTE: appearance
	use { 'amdt/sunset', config = function()
		vim.g.sunset_latitude = 35.02
		vim.g.sunset_longitude = 135.78
	end }
	use { 'catppuccin/nvim', as = 'catppuccin', config = function()
		require 'catppuccin'.setup {
			background = {
				dark = 'frappe'
			},
			dim_inactive = {
				enabled = true,
			},
		}
	end }
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
		require 'nvim-treesitter.configs'.setup {
			ensure_installed = { 'bash', 'markdown_inline' },
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false
			}
		}
	end }
	use 'rcarriga/nvim-notify' -- NOTE: UI
	use { 'folke/todo-comments.nvim', config = function()
		require 'todo-comments'.setup {
			keywords = {
				FIX = { alt = { 'e' } }, -- e: `e` stands for error
				TODO = {
					color = 'hint',
					alt = { 'q', }, -- q: `q` stands for question
				},
				HACK = {
					color = 'cmt',
					alt = { 'a' }, -- a: `a` stands for attention
				},
				WARN = { alt = { 'x' } }, -- x: `x` is abbreviation of `XXX`
				PERF = {
					color = 'doc',
					alt = { 'p' }, -- p: `p` stands for performance
				},
				NOTE = {
					color = 'info',
					alt = { 'd' }, -- d: `d` stands for description
				},
				TEST = { alt = { 't', 'PASS', 'FAIL' } }, -- t: `t` stands for test
			},
			colors = {
				cmt = { "Comment" },
				doc = { "SpecialComment" },
			}
		}
	end }
	use { 'folke/noice.nvim', event = 'VimEnter', config = function()
		require 'noice'.setup()
	end }
	use { 'windwp/nvim-autopairs', config = function() -- NOTE: Input Helper
		require 'nvim-autopairs'.setup {
			map_c_h = true
		}
	end }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', config = function() -- NOTE: Fuzzy Search
		require 'telescope'.setup {
			extensions = {
				file_browser = {
					hidden = true, hide_parent_dir = true
				},
			}
		}
		require 'telescope'.load_extension 'frecency'
		require 'telescope'.load_extension 'file_browser'
	end }
	use 'nvim-telescope/telescope-frecency.nvim'
	use 'nvim-telescope/telescope-file-browser.nvim'
	use { 'williamboman/mason.nvim', config = function() -- NOTE: lsp
		require 'mason'.setup()
	end }
	use { 'williamboman/mason-lspconfig.nvim', config = function()
		require 'mason-lspconfig'.setup {
			ensure_installed = {
				'bashls',
				'sumneko_lua',
				'rust_analyzer@nightly'
			}
		}
	end }
	use { 'neovim/nvim-lspconfig', config = function()
		local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

		-- d: rust_analyzer
		require('lspconfig').rust_analyzer.setup {
			capabilities = capabilities,
			settings = {
				["rust-analyzer"] = {
					hover = {
						actions = {
							reference = {
								enable = true
							}
						}
					},
					inlayHints = {
						closingBraceHints = {
							minLines = 0
						},
						lifetimeElisionHints = {
							enable = 'always',
							useParameterNames = true
						},
						maxLength = 0,
						typeHints = {
							hideNamedConstructor = false
						}
					},
					lens = {
						implementations = {
							enable = false
						}
					},
					rustfmt = {
						rangeFormatting = {
							enable = true
						}
					},
					semanticHighlighting = {
						operator = {
							specialization = {
								enable = true
							}
						}
					},
					typing = {
						autoClosingAngleBrackets = {
							enable = true
						}
					},
					workspace = {
						symbol = {
							search = {
								kind = 'all_symbols'
							}
						}
					}
				}
			}
		}

		-- d: lua
		require 'lspconfig'.sumneko_lua.setup {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
					},
					diagnostics = {
						globals = { 'vim' },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		-- d: clangd
		require 'lspconfig'.clangd.setup {
			capabilities = capabilities
		}
	end }
	use { 'glepnir/lspsaga.nvim', branch = 'main', config = function()
		require 'lspsaga'.init_lsp_saga {
			saga_winblend = 20,
			max_preview_lines = 10,
			code_action_lightbulb = {
				enable = false
			},
			finder_action_keys = {
				open = '<cr>',
				vsplit = '<c-v>',
				split = '<c-x>',
			},
			definition_action_keys = {
				edit = '<cr>',
				vsplit = '<c-v>',
				split = '<c-x>',
				tabe = 't',
			}
		}
	end }
	use { 'hrsh7th/nvim-cmp', config = function() -- NOTE: cmp
		local luasnip = require 'luasnip'
		local cmp = require 'cmp'
		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered()
			},
			mapping = cmp.mapping.preset.insert({
				['<c-u>'] = cmp.mapping.scroll_docs(-10),
				['<c-d>'] = cmp.mapping.scroll_docs(10),
				['<c-c>'] = cmp.mapping.abort(),
				['<tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm {
							behavior = cmp.ConfirmBehavior.Insert,
							select = true,
						}
					elseif luasnip.expand_or_jumpable() then
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
			}),
			sources = {
				{ name = 'luasnip' },
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lua' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'buffer' }
			}
		}

		cmp.setup.cmdline('/', {
			sources = {
				{ name = 'buffer' },
			}
		})

		cmp.setup.cmdline(':', {
			sources = {
				{ name = 'path' },
				{ name = 'cmdline' },
				{ name = 'buffer' },
			}
		})
	end }
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
end)
