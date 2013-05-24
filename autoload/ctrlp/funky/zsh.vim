" License: shell script (zsh)
" Author: Takahiro Yoshihara
" License: The MIT License

" The zsh is really tolerant of the function definition
let s:filter = [{ 'pattern': '\m\C^[\t ]*\(function \)\?' .
                \            '\([-/+_a-zA-Z0-9]\+\)()[\t ]*{',
                \ 'filter': ['\m\C()[\t ]*{', '', ''] },
              \ { 'pattern': '\m\C^[\t ]*function[\t ]\+{',
                \ 'filter': ['\m\C[\t ]\+{', ' *anonymous*', ''] }
\]

function! ctrlp#funky#zsh#apply_filter(bufnr)
  return ctrlp#funky#abstract(a:bufnr, s:filter)
endfunction

function! ctrlp#funky#zsh#get_filter()
  return s:filter
endfunction

