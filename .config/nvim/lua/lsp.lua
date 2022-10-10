require 'mason'.setup()
require 'mason-lspconfig'.setup {
   ensure_installed = { 'sumneko_lua', 'rust_analyzer@nightly', 'html', 'taplo', 'json-lsp', 'marksman' }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require 'mason-lspconfig'.setup_handlers {
   function(server_name)
      require 'lspconfig'[server_name].setup {
         capabilities = capabilities
      }
   end
}
