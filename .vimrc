colo slate

set relativenumber
set softtabstop=3
set shiftwidth=3
set expandtab
set awa

g:lexima_ctrlh_as_backspace=true
g:coc_global_extensions={'coc-json','coc-clangd','coc-rust-analyzer'}

nnoremap <esc> <cmd>noh<cr>
nnoremap , @:
vnoremap , @:
inoremap <c-n> <down>
inoremap <c-p> <up>
inoremap <c-b> <left>
inoremap <c-f> <right>
inoremap <c-a> <home>
inoremap <c-e> <end>
inoremap <c-d> <del>
inoremap <a-d> <right><c-c>ves
inoremap <a-b> <c-left>
inoremap <a-f> <c-right>

call plug#begin()
Plug 'neoclide/coc.nvim',{'branch':'release'}
Plug 'cohama/lexima.vim'
call plug#end()
