" License: shell script (zsh)
" Author: Takahiro Yoshihara
" License: The MIT License

function! ctrlp#funky#zsh#filters()
  " The zsh is really tolerant of the function definition
  let filters = [
        \ { 'pattern': '\m\C^[\t ]*\(function \)\?\([-/+_a-zA-Z0-9]\+\)()[\t ]*{',
        \   'formatter': ['\m\C()[\t ]*{', '', ''] },
        \ { 'pattern': '\m\C^[\t ]*function[\t ]\+{',
        \   'formatter': ['\m\C[\t ]\+{', ' *anonymous*', ''] }
  \ ]

  return filters
endfunction
