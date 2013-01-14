" File: autoload/ctrlp/funky/vim.vim
" Description: adds vim support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: the MIT License

function! ctrlp#funky#vim#filter(bufnr)
  let filter = [{ 'pattern': '\m\C^[\t ]*fu\(n\|nc\|nct\|ncti\|nctio\|nction\)\?!\?[\t ]\+\S\+',
                \ 'filter': ['\m\C^[\t ]*', '', '']}
  \]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

" vim: fen:fdm=marker
