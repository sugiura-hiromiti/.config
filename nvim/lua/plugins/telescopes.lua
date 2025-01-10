return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		config = function()
			local t = require("telescope")
			local a = require("telescope.actions")
			t.setup({
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						flex = {
							flip_columns = 160,
						},
					},
					mappings = {
						i = {
							["<c-j>"] = a.preview_scrolling_down,
							["<c-k>"] = a.preview_scrolling_up,
							["<c-d>"] = a.nop,
							["<c-u>"] = a.nop,
						},
					},
					winblend = 20,
					dynamic_preview_title = true,
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
					},
				},
				pickers = {
					buffers = {
						mappings = {
							i = {
								["<c-d>"] = a.delete_buffer,
							},
						},
					},
				},
				extensions = {
					file_browser = {
						grouped = true,
						select_buffer = true,
						hidden = true,
						respect_gitignore = false,
						follow_symlinks = true,
						collapse_dirs = true,
						mappings = {
							["i"] = {
								-- C have to be upper case to work
								["<C-t>"] = a.select_tab,
							},
						},
					},
					smart_open = { show_score = true },
				},
			})
			t.load_extension("smart_open")
			t.load_extension("ui-select")
			t.load_extension("file_browser")
		end,
	},
}
