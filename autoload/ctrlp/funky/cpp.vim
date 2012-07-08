" File: autoload/ctrlp/funky/cpp.vim
" Description: adds C++ support to ctrlp's funky extension
" Author: pydave
" License: the MIT License

function! ctrlp#funky#cpp#filter(bufnr)
    let lines = getbufline(a:bufnr, 1, '$')
    let filtered = []
    let i = 1
    for line in lines
        " cpp is too hard to parse (and style varies wildly), so just look for
        " something that starts in the first column, has brackets, and the
        " first bracket is preceeded by a word. If you put a space before your
        " functions, then you're out of luck because this eliminates most text
        " false positives.
        if 0 <= match(line, '\m^\w.*\w(.*)')
            let fn = line
            let bn = bufname(a:bufnr)
            call add(filtered, printf('%s #%s:%d:%d', fn, '', a:bufnr, i))
        endif
        let i += 1
    endfor
    return copy(filtered)
endfunction

" vim: fen:fdm=marker
