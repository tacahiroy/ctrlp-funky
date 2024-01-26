" Language: Fish shell
" Author: melhakim
" License: The MIT License

function! ctrlp#funky#ft#fish#filters()
  " TODO - Add following options:
  " -d DESCRIPTION or --description=DESCRIPTION
  " -w WRAPPED_COMMAND or --wraps=WRAPPED_COMMAND
  " -e or --on-event EVENT_NAME
  " -v or --on-variable VARIABLE_NAME
  " -j PID or --on-job-exit PID
  " -p PID or --on-process-exit PID
  " -s or --on-signal SIGSPEC
  " -S or --no-scope-shadowing
  " -V or --inherit-variable NAME

  let filters = [
        \ { 'pattern': '\m\C^[\t ]*\(function[\t ]\+\)\?[_a-zA-Z][_a-zA-Z0-9-]\+[\t ]*',
        \   'formatter': [] }
        \ ]
  return filters
endfunction

function! ctrlp#funky#ft#fish#is_kinda_sh()
  return 1
endfunction
