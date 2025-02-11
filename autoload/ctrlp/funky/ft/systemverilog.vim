" Language: SystemVerilog
" Author: User
" License: The MIT License

function! ctrlp#funky#ft#systemverilog#filters()
  " 匹配可能有 extern、virtual、void function、function 或 task 的声明
  let regex = '\v^\s*'                " 匹配前导空白
  let regex .= '(extern\s+)?'          " 可选匹配 extern 关键字
  let regex .= '(virtual\s+|static\s+|automatic\s+)?'   " 可选匹配 virtual、static 或 automatic 修饰符
  let regex .= '(function|task)\s+'    " 匹配 function 或 task 关键字
  let regex .= '(void\s+)?'            " 可选匹配 void 返回类型，紧跟在 function 之后
  let regex .= '(\w+::)?'              " 可选匹配类名和作用域运算符（类名::），用于类外定义
  let regex .= '(\w+)\s*'              " 匹配方法/任务名称
  let regex .= '\([^\)]*\)'            " 匹配参数列表，支持带默认值的参数
  let regex .= '\s*;?$'                " 匹配可能的结尾分号

  " 定义过滤器，使用正则表达式匹配 SystemVerilog 的结构
  let filters = [
        \ { 'pattern': regex,
        \   'formatter': ['\v(^\s*)|(\s*\{.*\ze \t#)', '', 'g'] }
  \ ]
  return filters
endfunction

function! ctrlp#funky#ft#systemverilog#post_extract_hook(list)
  " 从提取的列表中过滤掉非关键内容，例如 `else` 和 `if`
  return filter(copy(a:list), "v:val !~# '^[\\t ]*else[\\t ]\\+if'")
endfunction

