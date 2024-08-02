return {
	{
		'hrsh7th/nvim-cmp',
		config = function()
			local ls = require 'luasnip'
			local cmp = require 'cmp'
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
					['<up>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif ls.choice_active() then
							ls.change_choice(-1)
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<down>'] = cmp.mapping(function(fallback)
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
						else
							fallback()
						end
					end, { 'i', 's', 'c' }),
					['<c-h>'] = cmp.mapping(function(fallback)
						if ls.expand_or_locally_jumpable() then
							ls.jump(1)
						else
							fallback()
						end
					end),
					['<s-bs>'] = cmp.mapping(function(fallback)
						if ls.expand_or_locally_jumpable() then
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
