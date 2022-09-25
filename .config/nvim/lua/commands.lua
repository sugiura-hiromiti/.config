local autocmd = vim.api.nvim_create_autocmd

autocmd('bufwritepre', {
   pattern = { '*.rs', '*.lua', '*.cpp', '*.md', '*.html', '*.toml' },
   callback = function() vim.lsp.buf.format { async = true } end
})
autocmd({ 'filetype' }, {
   pattern = { 'terminal', 'help' },
   command = 'wincmd H'
})

-----------------------------------------------------userdefined
local mycmd = vim.api.nvim_create_user_command
