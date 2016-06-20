Dotfiles
========

[_] Install zsh
[_] Install git
[_] Install mercurial

ZSH Config
----------

[_] Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
[_] Copy geometry theme from `zsh/themes` to `~/.oh-my-zsh/custom/themes`
[_] Copy aliases from `zsh/aliases.zsh` to `~/.oh-my-zsh/custom/aliases.zsh`
[_] Use `.zshrc` from `zsh` folder

Nodejs
------

[_] Use [NVM](https://github.com/creationix/nvm)
[_] Make sure, ~/.zshrc is not broken

Python
------

[_] install python3
[_] install virtualenv-wrapper


Terminator
----------

[_] Copy configuration from `terminator` folder to `~/.config/terminator`

Window manager
--------------

I use [awesomewm](https://awesome.naquadah.org/) with the config from `awesome` folder

[_] Copy WM configuration from `awesome` folder to `~/.config/awesome`

Editor
------

Vim with X11 support. The binary for it is called `vimx` and distributed as a part of `vim-X11` package in Fedora.

[_] Copy files from `editor` folder to `~/.config/vim`
[_] Install [vim-plug](https://github.com/junegunn/vim-plug) to `~/.config/vim/autoload`
[_] Create symbolic links:
  - [ ] `ln -s ~/.config/vim ~/.vim`
  - [ ] `ln -s ~/.config/vim/init.vim ~/.vimrc`

Probably I'll want to use `neovim`. In this case I should copy files to `~/.config/nvim` folder instead of `~/.config/vim`. Symbolic links creation is not needed.
