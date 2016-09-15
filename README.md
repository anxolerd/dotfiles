Dotfiles
========

- [ ] Install zsh
- [ ] Install git
- [ ] Install mercurial

ZSH Config
----------

- [ ] Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
- [ ] Copy geometry theme from `zsh/themes` to `~/.oh-my-zsh/custom/themes`
- [ ] Copy aliases from `zsh/aliases.zsh` to `~/.oh-my-zsh/custom/aliases.zsh`
- [ ] Copy functions from `zsh/functions.zsh` to `~/.oh-my-zsh/custom/functions.zsh`
- [ ] Use `.zshrc` from `zsh` folder

Nodejs
------

- [ ] Use [NVM](https://github.com/creationix/nvm)
- [ ] Make sure, ~/.zshrc is not broken

Python
------

- [ ] install python3
- [ ] install virtualenv-wrapper


Terminator
----------

- [ ] Copy configuration from `terminator` folder to `~/.config/terminator`

Window manager
--------------

I use [awesomewm](https://awesome.naquadah.org/) with the configuration from `awesome` folder

- [ ] Copy WM configuration from `awesome` folder to `~/.config/awesome`

Editor
------

Vim with X11 support. The binary for it is called `vimx` and distributed as a part of `vim-X11` package in Fedora.

- [ ] Copy files from `editor/vim` folder to `~/.config/vim`
- [ ] Install [vim-plug](https://github.com/junegunn/vim-plug) to `~/.config/vim/autoload`
- [ ] Create symbolic links:
  - [ ] `ln -s ~/.config/vim ~/.vim`
  - [ ] `ln -s ~/.config/vim/init.vim ~/.vimrc`

Probably I'll want to use `neovim`. In this case I should copy files to `~/.config/nvim` folder instead of `~/.config/vim`. Symbolic links creation is not needed.

Tmux
----
Tmux is really neat terminal multiplexer. This is extemely convenient to use.

- [ ] Copy configuration from `tmux` to home directory.
- [ ] Adjust configuration
