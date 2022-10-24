local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   window = {
      completion = cmp.config.window.bordered()
      --documentation = cmp.config.window.bordered()
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
      { name = 'nvim_lsp_document_symbol' }
   }
})

cmp.setup.cmdline(':', {
   sources = {
      { name = 'path' },
      { name = 'cmdline' },
   }
})
