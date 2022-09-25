local autocmd = vim.api.nvim_create_autocmd

autocmd('bufwritepre', {
   pattern = { '*.rs', '*.lua', '*.cpp', '*.md', '*.html', '*.toml' },
   callback = function() vim.lsp.buf.format { async = true } end
})
autocmd({ 'filetype' }, {
   pattern = { 'terminal', 'help' },
   command = 'wincmd H'
})
if os.getenv 'PROFILE_NAME' == 'hotkey' then
   autocmd('vimenter', {
      callback = function()
         vim.o.background = 'dark'
      end
   })
end
autocmd({ 'vimenter', 'colorscheme' }, {
   command = 'hi! link VertSplit Normal | hi! link WinBar StatusLine'
})

-----------------------------------------------------userdefined
local mycmd = vim.api.nvim_create_user_command
