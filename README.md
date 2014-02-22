ctrlp-funky
============
Very simple function nativator for ctrlp.vim.

SYNOPSIS
----------
This is a ctrlp.vim extension. It simply navigates and jumps to function definitions from the current file without ctags. It just searches function definitions or equivalent lines using regular expressions, therefore some languages' abstraction aren't accurate because of hard to parse.

One of the advantages of this plugin is you needn't to generate tags file to jump to something definition line.

![ctrlp-funky][1]

Currently, following filetypes are supported:
* c/cpp (C/C++)
* chef
* coffee-script
* go
* html/xhtml
* java
* javascript
* lua
* markdown
* nerdtree
* objc (Objective-C)
* perl
* php
* python
* ruby
* sh (bash, dash and zsh)
* yaml
* vb (Visual Basic)
* vim


PREMISE
----------
First of all, I believe you're a user of a great Vim plugin called [ctrlp.vim](https://github.com/kien/ctrlp.vim).
Otherwise, you need to install it before start installing this plugin.


INSTALLATION
----------
### [Vundle](https://github.com/gmarik/vundle.git)

    :BundleInstall tacahiroy/ctrlp-funky

In addition, don't forget put a line below into your _.vimrc_.

    Bundle 'tacahiroy/ctrlp-funky'

### [pathogen.vim](https://github.com/tpope/vim-pathogen)

    $ cd ~/.vim/bundle
    $ git clone git://github.com/tacahiroy/ctrlp-funky.git

### Manually
If you don't use either plugin management systems, copy _autoload_ and _plugin_ directory to your _.vim_ directory.
On Windows, _vimfiles_ directory is used instead of _.vim_ directory.


CONFIGURATION
----------
You need to make the plugin available as a ctrlp.vim extension. Please add *funky* to a variable `g:ctrlp_extensions`.

    let g:ctrlp_extensions = ['funky']

Reboot Vim and then you can use `:CtrlPFunky` command.

It might be useful mapping like:

    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>


LINK
--------------

* [kien/ctrlp.vim](https://github.com/kien/ctrlp.vim)
* [vim.org/ctrlp-funky](http://www.vim.org/scripts/script.php?script_id=4592)


LICENSE
-------

Copyright (C) 2012-2014 Takahiro Yoshihara. Distributed under the MIT License.

[1]: http://i.imgur.com/yO4PWAF.png

