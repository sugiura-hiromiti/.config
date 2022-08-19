local map = vim.keymap.set
local nv = { 'n', 'v' }

--[[map(nv, ':tb', function()
   return vim.o.background == 'dark' and ':set background=light' or ':set background=dark'
end, { expr = true }) 
]] --
map(nv, ':', ';') --exchange : & ;
map(nv, ';', ':')
map('n', '<esc>', ':noh<cr>') --<esc> to noh
map('n', 'W', 'wi') --move & insert
map('n', 'E', 'ea')
map('n', 'B', 'bi')
map('n', '<a-k>', ':bprev<cr>') --buffer
map('n', '<a-j>', ':bnext<cr>')
map('n', '<up>', '"zdd<up>"zP') --move line
map('n', '<down>', '"zdd"zp')
map('v', '<up>', '"zx<up>"zP`[V`]')
map('v', '<down>', '"zx"zp`[V`]')
map('n', 'm', ':w<cr>:make<cr>') --make shortcut
map(nv, ',', '@:')

--emacs keybind
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-a>', '<c-c>^i')
map('i', '<c-e>', '<end>')
map('i', '<c-d>', '<del>')
map('i', '<c-k>', '<right><c-c>v$hs')
map('i', '<c-t>', '<c-c><left>"zx"zpa')
map('i', '<c-y>', '<c-r>"')
map('i', '<a-d>', '<c-c>ciw')
map('i', '<a-f>', '<c-right>')
map('i', '<a-b>', '<c-left><left>')

--split pane and change size
map(nv, '<', '<c-w>W')
map(nv, '>', '<c-w>w')
map(nv, '_', ':<c-u>sp<cr>')
map(nv, '<bar>', ':<c-u>vs<cr>')
map(nv, '`', '<c-w>>')
map(nv, '-', '<c-w><')
map(nv, '\\', '<c-w>+')
map(nv, '=', '<c-w>-')

--coc commands
map(nv, '<space>o', ':CocList<cr>')
map('n', '<space>h', [[:<c-u>call CocActionAsync('doHover')<cr>]])
map('n', '<space>d', '<plug>(coc-definition)')
map('n', '<space>r', '<plug>(coc-references)')
map('n', '<space>i', '<plug>(coc-implementation)')
map('n', '<space>n', '<plug>(coc-rename)')
map('n', '<space>a', '<plug>(coc-codeaction)')
map('v', '<space>a', '<plug>(coc-codeaction-selected)')
map('n', '<space>f', '<plug>(coc-refactor)')
map('n', '<space>l', '<plug>(coc-codelens-action)')
map('n', '<c-j>', '<plug>(coc-diagnostic-next)')
map('n', '<c-k>', '<plug>(coc-diagnostic-prev)')

--coc completion
map('i', '<down>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<down>"]], { expr = true })
map('i', '<up>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<up>"]], { expr = true })
map('i', '<c-n>', [[coc#pum#visible() ? coc#pum#next(1) : "\<down>"]], { expr = true })
map('i', '<c-p>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<up>"]], { expr = true })
map('i', '<c-c>', [[coc#pum#visible() ? coc#pum#confirm() : "\<c-c>"]], { expr = true })

--filer
map('n', '<space>e', [[<cmd> CocCommand explorer --sources=buffer+,file+ --position=floating<cr>]])
map('n', '<space>ie', ':e $MYVIMRC<cr>')
