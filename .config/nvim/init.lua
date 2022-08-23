local filenam = vim.fn.expand("%:p")
if filenam == '' then
   vim.cmd [[e $MYVIMRC]]
end


-----------------------------------------------------set variables
local opt = vim.opt
opt.number = true
opt.cursorline = true
opt.cursorcolumn = true
opt.tabstop = 3
opt.shiftwidth = 3
opt.expandtab = true
opt.swapfile = false
opt.writebackup = false
opt.updatetime = 100
opt.mouse = 'a'
opt.autowriteall = true
opt.termguicolors = true
opt.clipboard:append { 'unnamedplus' }

local g = vim.g
g.python3_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/python3'
g.node_host_prog = os.getenv('HOMEBREW_PREFIX') .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv('RUBY_HOST')
g.mapleader = "<cr>"
g.tokyonight_day_brightness = 0.24
g.tokyonight_lualine_bold = true
g.PaperColor_Theme_Options = {
   theme = {
      default = {
         allow_bold = true,
         allow_italic = true
      }
   },
   language = {
      cpp = {
         highlight_standard_library = true
      },
      c = {
         highlight_builtins = true
      }
   }
}
g.edge_menu_selection_background = 'green'
g.neosolarized_contrast = 'high'
g.neosolarized_visibility = 'high'
g.neosolarized_vertSplitBgTrans = true
g.neosoloarized_italic = true
g.everforest_background = 'hard'
g.everforest_enable_italic = true
g.everforest_ui_contrast = 'high'
g.everforest_diagnostic_text_highlight = true
g.palenight_terminal_italics = true
g.oceanic_next_terminal_italic = true
g.oceanic_next_terminal_bold = true
g.sunset_latitude = 35.02
g.sunset_longitude = 135
g.lexima_ctrlh_as_backspace = true
g.coc_global_extensions = {
   'coc-json',
   'coc-clangd',
   'coc-clang-format-style-options',
   'coc-rust-analyzer',
   'coc-explorer',
   'coc-sumneko-lua'
}

-----------------------------------------------------autocmd
local autocmd = vim.api.nvim_create_autocmd
autocmd('cursorhold', {
   command = 'call CocActionAsync(\'highlight\')'
})
autocmd('colorscheme', {
   command = 'highlight CocHighlightText ctermbg=DarkGray guibg=DarkGray'
})
autocmd('colorscheme', {
   command = 'highlight link CocSemDocumentation Special'
})
autocmd('colorscheme', {
   command = 'highlight link CocSemFunction Function'
})
autocmd('colorscheme', {
   pattern = 'edge',
   command = 'highlight link CocSemNamespace CocSemMacro'
})
autocmd('colorscheme', {
   pattern = 'edge',
   command = 'highlight link CocSemDocumentation CocSemBoolean'
})
autocmd('colorscheme', {
   pattern = 'OceanicNext',
   command = 'highlight link CocSemStruct CocSemInterface'
})
autocmd('colorscheme', {
   pattern = 'OceanicNext',
   command = 'highlight link CocSemMacro CocSemFunction'
})
autocmd('colorscheme', {
   pattern = 'OceanicNext',
   command = 'highlight link CocSemOperator CocSemNumber'
})

autocmd('bufleave', {
   command = 'update'
})
autocmd('insertleave', {
   command = 'update'
})
autocmd('vimenter', {
   command = [[luado if os.getenv'PROFILE_NAME'=='hotkey' then vim.o.background='dark' end]]
})

-----------------------------------------------------usercmd
--local mycmd=vim.api.nvim_buf_create_user_command

require 'plugins'
require 'mappings'
require 'color_randomizer'
