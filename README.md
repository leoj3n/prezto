# WarpDrive

WarpDrive is the futuristic configuration framework for [Zsh][1].

## Home

The [home][] directory has been added because this repository is meant to be used as a [homeshick][] castle.

If you don't wish to use Homeshick, you may simply create a symlink yourself like:

```
ln -s ~/path/to/warpdrive/home/.zshenv ~/.zshenv
```

This is the only symlink that needs to be in your home directory, because WarpDrive figures out its own location and sets `$ZDOTDIR`.

You could also link to `/etc/zshenv` to enable WarpDrive globally.

## Engines

  1. [git][]
  2. [directory][]
  3. [homebrew][]
  4. [osx][]
  5. [utility][]
  6. [bower][]
  7. [filetype][]
  8. [internet][]
  9. [meteor][]
  10. [sublime][]
  11. [taskwarrior][]
  12. [url][]
  13. [vagrant][]
  14. [wordpress][]
  15. [macvim][]
  16. [pwsafe][]
  17. [fzf][]

WarpDrive engages only the engines that have been enabled in [`sequence.zsh`][].

### Themes

  1. [powerlevel9k][]

License
-------

(The MIT License)

Copyright (c) 2009-2011 Robby Russell and contributors.

Copyright (c) 2011-2015 Sorin Ionescu and contributors.

Copyright (c) 2015-2016 Joel Kuzmarski.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[1]: http://www.zsh.org
[git]: engines/git
[directory]: engines/directory
[homebrew]: engines/homebrew
[osx]: engines/osx
[utility]: engines/utility
[bower]: engines/bower
[filetype]: engines/filetype
[internet]: engines/internet
[meteor]: engines/meteor
[sublime]: engines/sublime
[taskwarrior]: engines/taskwarrior
[url]: engines/url
[vagrant]: engines/vagrant
[wordpress]: engines/wordpress
[macvim]: engines/macvim
[pwsafe]: engines/pwsafe
[3n theme]: engines/prompt/functions/prompt_3n_setup
[home]: home
[homeshick]: https://github.com/andsens/homeshick
[`sequence.zsh`]: sequence.zsh 
