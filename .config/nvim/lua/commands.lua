local autocmd = vim.api.nvim_create_autocmd
--local blacklist = { 'TelescopePrompt', 'TelescopeResults', 'frecency' }

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
autocmd('bufwritepre', {
   pattern = { '*.rs', '*.lua', '*.cpp', '*.md', '*.html', '*.toml' },
   callback = function() vim.lsp.buf.format { async = true } end
   --under Nvim v0.8.0 callback = vim.lsp.buf.formatting_sync
})
autocmd({ 'filetype' }, {
   pattern = { 'terminal', 'help' },
   command = 'wincmd H'
})
autocmd({ 'vimenter', 'colorscheme' }, {
   command = 'PackerCompile'
})

-----------------------------------------------------userdefined
local mycmd = vim.api.nvim_create_user_command
