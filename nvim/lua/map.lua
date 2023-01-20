MAP('n', '<esc>', '<cmd>noh<cr>') -- <esc> to noh
MAP('i', '<c-[>', '<c-[><cmd>update | lua vim.lsp.buf.format{async=true}<cr>')
MAP({ 'n', 'v' }, '$', '^') -- swap $ & ^
MAP({ 'n', 'v' }, '^', '$')
MAP({ 'n', 'v' }, ',', '@:') --repeat previous command
MAP({ 'i', 'v' }, '<c-n>', '<down>') --emacs keybind
MAP({ 'i', 'v' }, '<c-p>', '<up>')
MAP({ 'i', 'v' }, '<c-b>', '<left>')
MAP({ 'i', 'v' }, '<c-f>', '<right>')
MAP({ 'i', 'v' }, '<c-a>', '<home>')
MAP({ 'i', 'v' }, '<c-e>', '<end>')
MAP('i', '<c-d>', '<del>')
MAP('i', '<c-k>', '<right><c-c>v$hs')
MAP('i', '<c-u>', '<c-c>v^s')
MAP('i', '<a-d>', '<right><c-c>ves')
MAP('i', '<a-f>', '<c-right>')
MAP('i', '<a-b>', '<c-left>')
MAP({ 'n', 'v' }, '<tab>', require('todo-comments').jump_next)
MAP({ 'n', 'v' }, '<s-tab>', require('todo-comments').jump_prev)
MAP('n', '<cr>', ':Make ') -- execute shell command
MAP('n', '<s-cr>', ':!')
MAP({ 'i', 'n', 'v' }, '<a-left>', '<c-w><') -- change window size
MAP({ 'i', 'n', 'v' }, '<a-down>', '<c-w>+')
MAP({ 'i', 'n', 'v' }, '<a-up>', '<c-w>-')
MAP({ 'i', 'n', 'v' }, '<a-right>', '<c-w>>')
MAP('n', 't', require('telescope.builtin').builtin) -- Telescope
MAP('n', '<space>o', require('telescope.builtin').lsp_document_symbols)
MAP('n', '<space>d', require('telescope.builtin').diagnostics)
MAP('n', '<space>b', function()
	require('telescope.builtin').buffers { ignore_current_buffer = true }
end)
MAP('n', '<space>e', require('telescope').extensions.file_browser.file_browser)
MAP('n', '<space>f', require('telescope').extensions.frecency.frecency)
MAP('n', '<space>c', '<cmd>TodoTelescope<cr>')
MAP('n', '<space>n', require('telescope').extensions.notify.notify)
MAP({ 'n', 'v' }, '<space>a', '<cmd>Lspsaga code_action<cr>')
MAP('n', '<space>j', '<cmd>Lspsaga lsp_finder<cr>') --`j` stands for jump
MAP('n', '<space>r', '<cmd>Lspsaga rename<cr>')
MAP('n', '<space>h', '<cmd>Lspsaga hover_doc<cr>')
MAP({ 'n', 'v' }, '<c-j>', '<cmd>Lspsaga diagnostic_jump_next<cr>')
MAP({ 'n', 'v' }, '<c-k>', '<cmd>Lspsaga diagnostic_jump_prev<cr>')
