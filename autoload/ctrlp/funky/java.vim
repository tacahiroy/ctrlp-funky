" File: autoload/ctrlp/funky/java.vim
" Description: adds Java support to ctrlp's funky extension
" Author: pydave
" License: the MIT License

function! ctrlp#funky#java#filter(bufnr)
    let lines = getbufline(a:bufnr, 1, '$')
    let filtered = []
    let i = 1
    for line in lines
        " Java has a mostly standard format and style, so assume we've got
        " everything on one line (excluding annotations).
        let regex = '\v^\s+'                " preamble
        let regex .= '%(<\w+>\s+){0,3}'     " visibility, static, final
        let regex .= '%(\w|[<>[\]])+\s+'    " return type
        let regex .= '\w+\s*'               " method name
        let regex .= '\([^\)]*\)'           " method parameters
        let regex .= '%(\w|\s|\{)+$'           " postamble

        if 0 <= match(line, regex)
            let fn = substitute(line, '\v(^\s*)|(\s*\{.*)', '', 'g')
            let bn = bufname(a:bufnr)
            call add(filtered, printf('%s #%s:%d:%d', fn, '', a:bufnr, i))
        endif
        let i += 1
    endfor
    return copy(filtered)
endfunction

" vim: fen:fdm=marker
