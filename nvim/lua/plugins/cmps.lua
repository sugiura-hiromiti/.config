return {
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'lukas-reineke/cmp-rg',
	'saadparwaiz1/cmp_luasnip',
	{
		'zbirenbaum/copilot-cmp',
		config = true,
	},
	{
		'hrsh7th/nvim-cmp',
		config = function()
			local ls = require 'luasnip'
			local cmp = require 'cmp'
			local copilot = require 'copilot.suggestion'
			local lspkind = require 'lspkind'
			local rg = {
				name = 'rg',
				option = { additional_arguments = '--smart-case', context_after = 7 },
				keyword_length = 0,
			}

			cmp.setup {
				formatting = {
					format = lspkind.cmp_format {
						mode = 'symbol',
					},
				},
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert {
					['<a-k>'] = cmp.mapping.scroll_docs(-10),
					['<a-j>'] = cmp.mapping.scroll_docs(10),
					['<c-c>'] = cmp.mapping.abort(),
					['<c-e>'] = cmp.mapping(function(fallback)
						fallback()
					end, { 'i', 's', 'c' }),
					['<c-p>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif ls.choice_active() then
							ls.change_choice(-1)
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<c-n>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif ls.choice_active() then
							ls.change_choice(1)
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
						elseif copilot.is_visible() then
							copilot.accept()
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<s-tab>'] = cmp.mapping(function(fallback)
						if copilot.is_visible() then
							copilot.accept_line()
						else
							fallback()
						end
					end),
					['<bs>'] = cmp.mapping(function(fallback)
						if ls.expand_or_locally_jumpable() then
							ls.jump(1)
						else
							fallback()
						end
					end),
					['<s-bs>'] = cmp.mapping(function(fallback)
						if copilot.is_visible() then
							copilot.accept_word()
						elseif ls.expand_or_locally_jumpable() then
							ls.jump(-1)
						else
							fallback()
						end
					end),
				},
				sources = {
					{ name = 'nvim_lsp_signature_help' },
					{ name = 'luasnip' },
					{ name = 'nvim_lsp' },
					{ name = 'copilot' },
					{ name = 'nvim_lua' },
					rg,
					{ name = 'path' },
				},
			}
			cmp.setup.cmdline({ '?' }, {
				sources = { rg },
			})
			cmp.setup.cmdline(':', {
				sources = {
					{ name = 'path' },

					{ name = 'cmdline' },
					rg,
				},
			})
		end,
	},
}
