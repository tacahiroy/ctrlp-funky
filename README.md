ctrlp-funky
============
Very simple function navigator for ctrlp.vim.

SYNOPSIS
----------
This is a ctrlp.vim extension. It simply navigates and jumps to function definitions from the current file without ctags. It just searches function definitions or equivalent lines using regular expressions, therefore some languages' abstraction aren't accurate because of hard to parse.

One of advantages of this plugin is you needn't to generate tags file to jump to definition of functions, classes etc.

![ctrlp-funky][1]

Currently, following filetypes are supported:
* c/cpp (C/C++)
* chef
* cmm (TRACE32)
* coffee-script
* elixir
* go
* html/xhtml
* java
* javascript
* jinja (template engine for Python)
* lua
* make (Makefile)
* markdown
* nerdtree
* objc (Objective-C)
* perl
* php
* python
* ruby
* scala
* sh (bash, dash and zsh)
* typescript
* yaml
* vb (Visual Basic)
* vim


PREMISE
----------
First of all, I believe you're a user of a great Vim plugin called [ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim).
Otherwise, you need to install ctrlp.vim before start using this plugin.


INSTALLATION
----------
### [Vundle](https://github.com/gmarik/vundle.git)
```vim
:PluginInstall tacahiroy/ctrlp-funky
```

In addition, don't forget put a line below into your _.vimrc_.
```vim
Plugin 'tacahiroy/ctrlp-funky'
```

### [pathogen.vim](https://github.com/tpope/vim-pathogen)
```sh
$ cd ~/.vim/bundle
$ git clone git://github.com/tacahiroy/ctrlp-funky.git
```

### Manually
If you don't use either plugin management systems, copy _autoload_ and _plugin_ directories to your _.vim_ directory.
On Windows, basically, _vimfiles_ directory is used instead of _.vim_ directory.


CONFIGURATION
--------------
It's useful to define key mappings like this:
```vim
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
```


EXPERIMENTAL
------------
### MATCHED CHARS HIGHLIGHTING
If you want to have this highlight feature, you may configure like this:
```vim
let g:ctrlp_funky_matchtype = 'path'
```
See `:h g:ctrlp_funky_matchtype` for more details and notes.

![funky-matched-chars-highlighting][3]


### SYNTAX HIGHLIGHTING
I'd like to introduce one of ctrlp-funky options.
Do you want to make ctrlp-funky funkier? Okay - you can do it with just 1 line config.
```vim
let g:ctrlp_funky_syntax_highlight = 1
```
![funky-syntax][2]

Note that this feature doesn't work perfectly, because ctrlp-funky just sets
filetype to the funky buffer and the buffer contains '>' in the first column.
In some filetypes, this sign has special meaning such as HTML tag, so it breaks
syntax highlighting.


LINK
-------

* [ctrlpvim/ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim)
* [vim.org/ctrlp-funky](http://www.vim.org/scripts/script.php?script_id=4592)


LICENSE
-------

Copyright (C) 2012-2015 Takahiro Yoshihara. Distributed under the MIT License.

[1]: http://i.imgur.com/yO4PWAF.png
[2]: http://i.imgur.com/CnKui5H.png
[3]: http://i.imgur.com/B3hBycd.png
