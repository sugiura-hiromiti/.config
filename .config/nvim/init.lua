--light: shine
--dark:slate, habamax
--both:lunaperche
vim.cmd 'colo shine' 
local filenam = vim.fn.expand('%:p') --XXX default open
if filenam == '' then vim.cmd [[e $MYVIMRC]] end

local opt = vim.opt --XXX variable
opt.relativenumber = true
opt.signcolumn = 'no'
opt.softtabstop = 3
opt.shiftwidth = 3
opt.expandtab = true
opt.swapfile = false
opt.writebackup = false
opt.updatetime = 50
opt.mouse = 'a'
opt.autowriteall = true
opt.termguicolors = true
opt.clipboard:append { 'unnamedplus' }
opt.autochdir = true
opt.laststatus = 0

local g = vim.g
g.python3_host_prog = os.getenv 'HOMEBREW_PREFIX' .. '/bin/python3'
g.node_host_prog = os.getenv 'HOMEBREW_PREFIX' .. '/bin/neovim-node-host'
g.ruby_host_prog = os.getenv 'RUBY_HOST'

local map = vim.keymap.set --XXX mapping
map('n', '<esc>', ':noh<cr>') --<esc> to noh
map({ 'n', 'v' }, ',', '@:') --repeat previous command
map('i', '<c-n>', '<down>') --emacs keybind
map('i', '<c-p>', '<up>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-t>', '<c-c><left>"zx"zpa')
map('i', '<c-y>', '<c-r>"')
map('n', '<space>w', function() vim.cmd 'write' vim.lsp.buf.format { async = true } end)
map('n', 't', require 'telescope.builtin'.builtin) -- Telescope
map('n', '<space>m', require 'telescope.builtin'.marks)
map('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
map('n', '<space>d', require 'telescope.builtin'.diagnostics)
map('n', '<space>b', require 'telescope.builtin'.buffers)
map({ 'n', 'v' }, '<space>p', require 'telescope.builtin'.registers)
map('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
map('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
map({ 'n', 'v' }, '<space>a', '<cmd>Lspsaga code_action<CR>') --lspsaga
map('n', '<space>r', '<cmd>Lspsaga rename<cr>')
map('n', '<space>j', '<cmd>Lspsaga lsp_finder<cr>')
map('n', '<space>h', '<cmd>Lspsaga hover_doc<cr>')
map('n', '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
map('n', '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
map('n', '<A-t>', '<cmd>Lspsaga open_floaterm<CR>')
map('t', '<A-t>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])

require 'packer'.startup(function(use) --XXX package
   use 'wbthomason/packer.nvim'
   use 'kyazdani42/nvim-web-devicons'
   use { 'windwp/nvim-autopairs', config = function() require 'nvim-autopairs'.setup { map_c_h = true } end }
   use 'nvim-lua/plenary.nvim'
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', config = function() -- telescope
      require 'telescope'.setup { pickers = { findfiles = { hidden = true } },
         extensions = { file_browser = { hidden = true, hide_parent_dir = true }, } }
      require 'telescope'.load_extension 'frecency'
      require 'telescope'.load_extension 'file_browser'
   end }
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use { 'williamboman/mason.nvim', config = function() require 'mason'.setup() end } -- lsp
   use { 'williamboman/mason-lspconfig.nvim', config = function()
      require 'mason-lspconfig'.setup {
         ensure_installed = { 'sumneko_lua', 'rust_analyzer@nightly', 'html', 'taplo', 'json-lsp', 'marksman' }
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
      require 'mason-lspconfig'.setup_handlers {
         function(server_name)
            require 'lspconfig'[server_name].setup { capabilities = capabilities }
         end
      }
   end }
   use 'neovim/nvim-lspconfig'
   use { 'glepnir/lspsaga.nvim', branch = 'main' }
   use { 'hrsh7th/nvim-cmp', config = function()
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      cmp.setup {
         snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
         },
         mapping = cmp.mapping.preset.insert({
            ['<up>'] = cmp.mapping.scroll_docs(-10),
            ['<down>'] = cmp.mapping.scroll_docs(10),
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
         },
      }
      cmp.setup.cmdline(':', {
         sources = cmp.config.sources({
            { name = 'cmdline' }
         })
      })
   end } -- completion source
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'hrsh7th/cmp-cmdline'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
end)
