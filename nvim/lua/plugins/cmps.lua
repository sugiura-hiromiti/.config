return {
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local ls = require("luasnip")
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local autopairs = require("nvim-autopairs.completion.cmp")
			local rg = {
				name = "rg",
				option = { additional_arguments = "--smart-case", context_after = 5 },
				keyword_length = 6,
			}

			cmp.event:on("confirm_done", autopairs.on_confirm_done({ filetypes = { rust = false } }))

			cmp.setup({
				formatting = {
					expandable = { indicator = true },
					format = lspkind.cmp_format({
						mode = "symbol",
						before = require("tailwind-tools.cmp").lspkind_format,
					}),
				},
				snippet = {
					expand = function(args)
						ls.lsp_expand(args.body)
					end,
				},
				window = {
					completion = {
						winblend = 25,
					},
					documentation = {
						winblend = 30,
						max_width = 0,
						max_height = 0,
					},
				},
				view = { docs = { auto_open = true } },
				mapping = {
					["<c-k>"] = cmp.mapping.scroll_docs(-4),
					["<c-j>"] = cmp.mapping.scroll_docs(4),
					["<c-c>"] = cmp.mapping.abort(),
					["<c-e>"] = cmp.mapping(function(fallback)
						fallback()
					end, { "i", "s", "c" }),
					["<up>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
							--cmp.open_docs()
						elseif ls.choice_active() then
							ls.change_choice(-1)
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<down>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							--cmp.open_docs()
						elseif ls.choice_active() then
							ls.change_choice(1)
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
						else
							fallback()
						end
					end, { "i", "s", "c" }),
					["<c-h>"] = cmp.mapping(function(fallback)
						if ls.expand_or_locally_jumpable() then
							ls.jump(1)
						else
							fallback()
						end
					end),
					["<s-bs>"] = cmp.mapping(function(fallback)
						if ls.expand_or_locally_jumpable() then
							ls.jump(-1)
						else
							fallback()
						end
					end),
				},
				sources = {
					{ name = "nvim_lsp_signature_help" },
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "async_path" },
					{ name = "crates" },
					{ name = "copilot" },
					rg,
				},
				--				experimental = { ghost_text = true },
			})
			cmp.setup.cmdline({ "?" }, { sources = { rg, { name = "nvim_lsp_document_symbol" } } })
			cmp.setup.cmdline(":", { sources = { { name = "async_path" }, { name = "cmdline" }, rg } })
			cmp.setup.cmdline(":=", { sources = { { name = "cmdline" }, { name = "nvim_lua" }, rg } })
			cmp.setup.filetype({ "lisp", "scheme" }, {
				sources = {
					{ name = "luasnip" },
					{ name = "treesitter" },
					rg,
				},
			})
			cmp.setup.filetype({ "TelescopePrompt" }, {
				sources = {
					{ name = "nvim_lsp_document_symbol" },
					rg,
					{ name = "async_path" },
				},
			})
		end,
	},
}
