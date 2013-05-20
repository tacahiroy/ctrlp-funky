ctrlp-funky
============

This is a ctrlp.vim extension and it picks out functions currently being edited file without ctags.
It just searches function definition or equivalent of it, therefore some languages abstraction
aren't accurate because of hard to parse.
One of the advantages of this plugin is you needn't generate tags file.

![ctrlp-funky][1]

This supports following filetypes:
* c++
* chef
* java
* javascript
* markdown
* nerdtree
* objc
* php
* python
* ruby
* sh
* vb
* vim
* zsh

INSTALL
----------
If you use [Vundle](https://github.com/gmarik/vundle.git) you can install this plugin using Vim command `:BundleInstall tacahiroy/ctrlp-funky`.
Don't forget put a line `Bundle 'tacahiroy/ctrlp-funky'` into `.vimrc`.

If you use [pathogen.vim](https://github.com/tpope/vim-pathogen), you just execute following:

    cd ~/.vim/bundle
    git clone git://github.com/tacahiroy/ctrlp-funky.git

You don't use either plugin management system, copy `autoload` and `plugin` directory to your `.vim` directory.

By default:
\*nix: $HOME/.vim
Windows: $HOME/vimfiles

CONFIGURATION
----------
You need to make the plugin available as a ctrlp.vim extension.
Please add 'funky' to `g:ctrlp_extensions`.

    let g:ctrlp_extensions = ['funky']

Reboot Vim and then you can use `:CtrlPFunky` command.
It might be useful like this mapping:

    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>

LINK
--------------

[kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)

License
-------

Copyright (C) 2012-2013 Takahiro Yoshihara. Distributed under the MIT License.

[1]: http://i.imgur.com/yO4PWAF.png
