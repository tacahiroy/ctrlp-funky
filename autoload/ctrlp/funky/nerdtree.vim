" File: autoload/ctrlp/funky/nerdtree.vim
" Description: adds NERDTree support to ctrlp's funky extension
" Author: Takahiro YOSHIHARA
" License: the MIT License

let s:filter = [{ 'pattern': '\m\C^\s*[▸▾|~+].*\/$',
                \ 'filter': ['', '', '']}
\ ]

function! ctrlp#funky#nerdtree#filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#nerdtree#get_filter()
  return s:filter
endfunction

function! ctrlp#funky#nerdtree#accept(action, line)
  call ctrlp#exit()
  call cursor(matchstr(a:line, '\d\+$'), 1)
endfunction

if !has_key(g:ctrlp_open_func, 'Funky')
  let g:ctrlp_open_func['Funky'] = 'ctrlp#funky#nerdtree#accept'
endif

