vim.cmd 'colo tokyonight'
if vim.fn.expand('%:p') == '' then vim.cmd [[e $MYVIMRC]] end

local p = vim.opt
p.pumblend = 20
p.relativenumber = true
p.number = true
p.softtabstop = 3
p.shiftwidth = 3
p.expandtab = true
p.autowriteall = true
p.termguicolors = true
p.clipboard:append { 'unnamedplus' }
p.autochdir = true
p.laststatus = 0
function()
   local blacklist = { 'TelescopePrompt', 'TelescopeResults', 'frecency' }
   local is_black
   for _, ft in ipairs(blacklist) do
      if vim.bo.filetype == ft then
         is_black = true
         break
      end
   end
   if is_black then
      vim.cmd 'update'
   else
   end
end
local map = vim.keymap.set
map('n', '<esc>', '<cmd>noh<cr>') --<esc> to noh
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
-- NOTE: map <tab> to next todo_comment, <S-tab> to prev todo_comment
map({ 'n', 'v' }, '<a-h>', '<c-w>h')
map({ 'n', 'v' }, '<a-j>', '<c-w>j')
map({ 'n', 'v' }, '<a-k>', '<c-w>k')
map({ 'n', 'v' }, '<a-l>', '<c-w>l')
map('n', 't', require 'telescope.builtin'.builtin) -- Telescope
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)
map('n', '<space>j', require 'telescope.builtin'.lsp_references) --`j` stands for jump
map('n', '<space>b', require 'telescope.builtin'.buffers)
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map('n', '<space>c', '<cmd>TodoTelescope<cr>')
map('n', '<space>n', '<cmd>Telescope notify<cr>')
map({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action)
map('n', '<space>r', vim.lsp.buf.rename)
map('n', '<space>h', vim.lsp.buf.hover)
map('n', '<c-j>', vim.diagnostic.goto_next)
map('n', '<c-k>', vim.diagnostic.goto_prev)

require 'packer'.startup(function(use) --XXX package
   use 'wbthomason/packer.nvim'
   use 'nvim-lua/plenary.nvim'
   use 'folke/tokyonight.nvim'
   use { 'folke/todo-comments.nvim', config = function() require 'todo-comments'.setup {} end }
   use { 'folke/noice.nvim', event = 'VimEnter', config = function() require 'noice'.setup() end }
   use 'MunifTanjim/nui.nvim'
   use 'rcarriga/nvim-notify'
   --[[ NOTE: treesitter
   --]]
   use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = function()
      require 'nvim-treesitter.configs'.setup {
         auto_install = true,
         highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
         }
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
   use { 'hrsh7th/nvim-cmp', config = function()
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      cmp.setup {
         snippet = {
            expand = function(args)
               luasnip.lsp_expand(args.body)
            end,
         },
         mapping = cmp.mapping.preset.insert({
            ['<c-u>'] = cmp.mapping.scroll_docs(-10),
            ['<c-d>'] = cmp.mapping.scroll_docs(10),
            ['<c-c>'] = cmp.mapping.abort(),
            ['<tab>'] = cmp.mapping.confirm {
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
         sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lua' },
            { name = 'luasnip' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
            { name = 'buffer' }
         },
      }
      cmp.setup.cmdline('/', {
         sources = {
            { name = 'buffer' },
            { name = 'nvim_lsp_document_symbol' }
         }
      })
      cmp.setup.cmdline(':', {
         sources = {
            { name = 'cmdline' },
            { name = 'path' }
         }
      })
   end }
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
--require 'cmp'
