## Pasta - a silly pastebin-like sinatra application

This version is forked from [miloshadzic][M]'s pastaa.

Changes:
* The usage of pygments@appspot has been replaced with native ultraviolet highlighting (purely for flexability reasons, mainly line numbers)
* Added toggle-able line numbers
* Added the ability to "View Raw" pastes
* Added the ability to download pastes
* Wrote a command line paste client in bash
* Ripped out inconsolata font, just using monospace now.

Note:
This is literally my first time hacking on ruby code (as well as haml)...
My modifications are a hack, and there are probably quite a few things I've done wrong/conventions I've disobeyed.
Just thought I'd push it on the off-chance someone finds it useful.

Oh, and also.. should you chose to use the pastapaste client, make sure to edit $deployment to point to your pasta installation.

[M]: https://github.com/miloshadzic 
