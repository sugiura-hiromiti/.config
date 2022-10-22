vim.cmd 'colo slate'
local filenam = vim.fn.expand('%:p') --XXX default open
if filenam == '' then vim.cmd [[e $MYVIMRC]] end

vim.opt.relativenumber = true
vim.opt.signcolumn = 'no'
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.autowriteall = true
vim.opt.termguicolors = true
vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.autochdir = true
vim.opt.laststatus = 0
vim.opt.virtualedit = 'all'

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
vim.keymap.set('n', 't', require 'telescope.builtin'.builtin) -- Telescope
vim.keymap.set('n', '<space>o', require 'telescope.builtin'.lsp_document_symbols)
vim.keymap.set('n', '<space>d', require 'telescope.builtin'.diagnostics)
vim.keymap.set('n', '<space>j', require 'telescope.builtin'.lsp_references) --`j` stands for jump
vim.keymap.set('n', '<space>b', require 'telescope.builtin'.buffers)
vim.keymap.set('n', '<space>e', require 'telescope'.extensions.file_browser.file_browser)
vim.keymap.set('n', '<space>f', require 'telescope'.extensions.frecency.frecency)
vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action)
vim.keymap.set('n', '<space>r', vim.lsp.buf.rename)
vim.keymap.set('n', '<space>h', vim.lsp.buf.hover)
vim.keymap.set('n', '<c-j>', vim.diagnostic.goto_next)
vim.keymap.set('n', '<c-k>', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<A-t>', '<cmd>vs | term<cr>a<cr>')
vim.keymap.set('t', '<A-t>', [[<C-\><C-n><cmd>q<cr>]])

require 'packer'.startup(function(use) --XXX package
   use 'wbthomason/packer.nvim'
   use 'nvim-lua/plenary.nvim'
   use { 'windwp/nvim-autopairs', config = function() require 'nvim-autopairs'.setup { map_c_h = true } end }
   use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', config = function() -- telescope
      require 'telescope'.setup { extensions = { file_browser = { hidden = true, hide_parent_dir = true }, } }
      require 'telescope'.load_extension 'frecency'
      require 'telescope'.load_extension 'file_browser'
   end }
   use 'nvim-telescope/telescope-frecency.nvim'
   use 'nvim-telescope/telescope-file-browser.nvim'
   use 'kkharji/sqlite.lua'
   use { 'williamboman/mason.nvim', config = function() require 'mason'.setup() end } -- lsp
   use { 'williamboman/mason-lspconfig.nvim', config = function()
      require 'mason-lspconfig'.setup { ensure_installed = { 'sumneko_lua', 'rust_analyzer@nightly' } }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      require 'mason-lspconfig'.setup_handlers {
         function(server_name) require 'lspconfig'[server_name].setup { capabilities = capabilities } end
      }
   end }
   use 'neovim/nvim-lspconfig'
   use { 'hrsh7th/nvim-cmp', config = function()
      local luasnip = require 'luasnip'
      local cmp = require 'cmp'
      cmp.setup {
         snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
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
            end, { 'i', 's' }),
            ['<c-p>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
               else
                  fallback()
               end
            end, { 'i', 's' }),
         }),
         sources = { { name = 'nvim_lsp' }, { name = 'nvim_lua' }, { name = 'luasnip' }, },
      }
   end }
   use 'hrsh7th/cmp-nvim-lsp'
   use 'hrsh7th/cmp-nvim-lua'
   use 'saadparwaiz1/cmp_luasnip'
   use 'L3MON4D3/LuaSnip'
end)
