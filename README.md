ctrlp-funky
============

This is a ctrlp.vim extension and it abstracts functions currently being edited file(s) without ctags.  
It just search function definition lines, thus some languages abstraction aren't accurate because of hard to parse.

This supports following filetypes:
* c++
* java
* javascript
* markdown
* nerdtree
* python
* ruby
* sh
* vim
* zsh
* objc

INSTALL
----------
If you use [Vundle](https://github.com/gmarik/vundle.git) you can install this plugin using Vim command `:BundleInstall tacahiroy/ctrlp-funky`.  
Don't forget put a line `Bundle 'tacahiroy/ctrlp-funky'` into `.vimrc`.

If you use [pathogen.vim](https://github.com/tpope/vim-pathogen), you just execute following:

    cd ~/.vim/bundle
    git clone git://github.com/tacahiroy/ctrlp-funky.git

You don't use either plugin management system, copy `autoload` and `plugin` directory to your `.vim` directory.

\*nix: $HOME/.vim
Windows: $HOME/vimfiles

CONFIGURATION
----------
You must available this plugin as a ctrlp.vim extension. Please add 'funky' to `g:ctrlp_extensions`.

    let g:ctrlp_extensions = ['funky']

Reboot Vim and then you can use `:CtrlPFunky` command.  
It might be useful like this mapping:

    nnoremap <Space>fu :CtrlPFunky<Cr>

LINK
--------------

[kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)

License
-------

Copyright (C) 2012-2013 Takahiro Yoshihara. Distributed under the MIT License.

