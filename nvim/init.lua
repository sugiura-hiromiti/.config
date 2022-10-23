vim.cmd 'colo tokyonight'
if vim.fn.expand('%:p') == '' then vim.cmd [[e $MYVIMRC]] end

vim.opt.pumblend = 20
vim.opt.relativenumber = true
vim.opt.number=true
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.autowriteall = true
vim.opt.termguicolors = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.laststatus = 0

vim.keymap.set('n', '<esc>', '<cmd>noh<cr>') --<esc> to noh
vim.keymap.set('i', '<c-[>', '<cmd>update | lua vim.lsp.buf.format{async=true}<cr><esc>')
vim.keymap.set({ 'n', 'v' }, ',', '@:') --repeat previous command
vim.keymap.set('i', '<c-n>', '<down>') --emacs keybind
vim.keymap.set('i', '<c-p>', '<up>')
vim.keymap.set('i', '<c-b>', '<left>')
vim.keymap.set('i', '<c-f>', '<right>')
vim.keymap.set('i', '<c-a>', '<home>')
vim.keymap.set('i', '<c-e>', '<end>')
vim.keymap.set('i', '<c-d>', '<del>')
vim.keymap.set('i', '<c-k>', '<right><c-c>v$hs')
vim.keymap.set('i', '<c-u>', '<c-c>v^s')
vim.keymap.set('i', '<a-d>', '<right><c-c>ves')
vim.keymap.set('i', '<a-f>', '<c-right>')
vim.keymap.set('i', '<a-b>', '<c-left>')
vim.keymap.set({ 'n', 'v' }, '<a-h>', '<c-w>h')
vim.keymap.set({ 'n', 'v' }, '<a-j>', '<c-w>j')
vim.keymap.set({ 'n', 'v' }, '<a-k>', '<c-w>k')
vim.keymap.set({ 'n', 'v' }, '<a-l>', '<c-w>l')
vim.keymap.set('n', 't', require 'telescope.builtin'.builtin) -- Telescope
vim.keymap.set('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
vim.keymap.set('n', '<space>d', require 'telescope.builtin'.diagnostics)
vim.keymap.set('n', '<space>j', require 'telescope.builtin'.lsp_references) --`j` stands for jump
vim.keymap.set('n', '<space>b', require 'telescope.builtin'.buffers)
vim.keymap.set('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
vim.keymap.set('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
vim.keymap.set('n', '<space>c', '<cmd>TodoTelescope<cr>')
vim.keymap.set('n', '<space>n', '<cmd>Telescope notify<cr>')
vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<space>r', vim.lsp.buf.rename)
vim.keymap.set('n', '<space>h', vim.lsp.buf.hover)
vim.keymap.set('n', '<c-j>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<c-k>', vim.diagnostic.goto_prev)

require 'packer'.startup(function(use) --XXX package
   use 'wbthomason/packer.nvim'
   use 'nvim-lua/plenary.nvim'
   use 'folke/tokyonight.nvim'
   use { 'folke/todo-comments.nvim', config = function() require 'todo-comments'.setup {} end }
   use { 'folke/noice.nvim', event = 'VimEnter', config = function() require 'noice'.setup() end }
   use 'MunifTanjim/nui.nvim'
   use 'rcarriga/nvim-notify'
   use { 'nvim-treesitter/nvim-treesitter', config = function()
      require 'nvim-treesitter.configs'.setup {
         auto_install = true,
         additional_vim_regex_highlighting = false
      }
   end }
   use 'nvim-tree/nvim-web-devicons'
   use { 'windwp/nvim-autopairs', config = function() require 'nvim-autopairs'.setup { map_c_h = true } end }
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', config = function() -- telescope
      require 'telescope'.setup { extensions = { file_browser = { hidden = true, hide_parent_dir = true }, } }
      require 'telescope'.load_extension 'frecency'
      require 'telescope'.load_extension 'file_browser'
   end }
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use 'williamboman/mason.nvim'
   use 'williamboman/mason-lspconfig.nvim'
   use 'neovim/nvim-lspconfig'
   use 'hrsh7th/nvim-cmp'
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-nvim-lsp-signature-help'
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'hrsh7th/cmp-nvim-lsp-document-symbol'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
end)

require 'lsp'
require 'cmp'
