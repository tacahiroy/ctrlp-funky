" File: autoload/ctrlp/funky/zsh.vim
" Description: adds zsh support to ctrlp's funky extension
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

function! ctrlp#funky#zsh#filter(bufnr)
  " The zsh is really tolerant of the function definition
  let filter = [{ 'pattern': '\m\C^[\t ]*\(function \)\?' .
                           \ '\([-/+_a-zA-Z0-9]\+\)()[\t ]*{',
                \ 'filter': ['\m\C()[\t ]*{', '', ''] },
              \ { 'pattern': '\m\C^[\t ]*function[\t ]\+{',
                \ 'filter': ['\m\C[\t ]\+{', ' *anonymous*', ''] }
  \]

  return ctrlp#funky#abstract(a:bufnr, filter)
endfunction

