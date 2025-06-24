" Language: SystemVerilog
" Author: sqlmap3
" License: The MIT License

function! ctrlp#funky#ft#systemverilog#filters()
  " Match declarations that may have extern, virtual, void function, function or task
  let regex = '\v^\s*'                " Match leading whitespace
  let regex .= '(extern\s+)?'          " Optional match for extern keyword
  let regex .= '(virtual\s+|static\s+|automatic\s+)?'   " Optional match for virtual, static or automatic modifiers
  let regex .= '(function|task)\s+'    " Match function or task keywords
  let regex .= '(void\s+)?'            " Optional match for void return type, immediately following function
  let regex .= '(\w+::)?'              " Optional match for class name and scope operator (classname::), used for out-of-class definitions
  let regex .= '(\w+)\s*'              " Match method/task name
  let regex .= '\([^\)]*\)'            " Match parameter list, supporting parameters with default values
  let regex .= '\s*;?$'                " Match possible ending semicolon

  " Define filters, using regular expressions to match SystemVerilog structures
  let filters = [
        \ { 'pattern': regex,
        \   'formatter': ['\v(^\s*)|(\s*\{.*\ze \t#)', '', 'g'] }
  \ ]
  return filters
endfunction

function! ctrlp#funky#ft#systemverilog#post_extract_hook(list)
  " Filter out non-essential content from the extracted list, such as `else` and `if`
  return filter(copy(a:list), "v:val !~# '^[\\t ]*else[\\t ]\\+if'")
endfunction
