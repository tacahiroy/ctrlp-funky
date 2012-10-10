" File: autoload/ctrlp/funky/ruby.vim
" Description: adds ruby support to ctrlp's funky extension
" Author: Takahiro YOSHIHARA
" License: the MIT License

function! ctrlp#funky#ruby#filter(bufnr)
  let filter = [{ 'pattern': '\m\C^[\t ]*def[\t ]\+\S\+',
                \ 'filter': ['\m\C^[\t ]*', '', '']}
  \ ]

  let g:ctrlp_funky_ruby_include_rake = get(g:, 'ctrlp_funky_ruby_include_rake', 1)

  if g:ctrlp_funky_ruby_include_rake
    call extend(filter, [{ 'pattern': '\m\C^[\t ]*task[\t ]\+\S\+',
                         \ 'filter': ['\m\C^[\t ]*', '', '']}])
  endif

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
