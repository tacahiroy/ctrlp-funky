ctrlp-funky.vim
============

This is a ctrlp.vim extension and it abstracts functions currently being edited file(s) without ctags.  
It just search function definition lines, thus some languages abstraction aren't accurate because of hard to parse.

This supports following filetypes:
* vim
* ruby
* markdown

INSTALL
----------
If you use [Vundle](https://github.com/gmarik/vundle.git) it's very easy, you just run command `:BundleInstall tacahiroy/ctrlp-funky` inside vim.  
And also put `Bundle 'tacahiroy/ctrlp-funky'` into `.vimrc`.

If you use [pathogen.vim](https://github.com/tpope/vim-pathogen), you just execute following:

    cd ~/.vim/bundle
    git clone git://github.com/tacahiroy/ctrlp-funky.git

You don't use either plugin management system, copy `autoload` directory to your `.vim` directory.

\*nix: $HOME/.vim
Windows: $HOME/vimfiles


LINK
--------------

[kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)

License
-------

Copyright (C) 2012 tacahiroy. Distributed under the MIT License.

