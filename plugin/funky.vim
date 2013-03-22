" File: plugin/funky.vim
" Description: a simple ctrlp.vim extension provides jumping to function
" Author: Takahiro Yoshihara <tacahiroy\AT/gmail.com>
" License: The MIT License

command! -nargs=? CtrlPFunky call ctrlp#funky#funky(<q-args>)

