Anxolerd's dotfiles
===================

A collection of configuration files I use on my machine.

Configuration includes

- Custom scripts

  - lock (script which locks the screen with the blurred screenshot)
- Editors

  - NeoVim (vim-plug, neomake, denite, deoplete, fugitive)
- tmux (via tpm)
- Window managers

  - i3wm with i3status and i3bar and dunst
- Shell

  - zsh (oh-my-zsh + spacechip theme + custom nodenv plugin)

There is a simple vagrantfile in repository which is used to set up virtual 
machine for testing purposes. The machine is bare fedora-26

Installing
----------

Installation is supported via provided script ``install.sh``. The script is
designed to work with fedora. Ubuntu is not supported yet, as it uses different
package manager and different package names.

.. note::
    To install everything on Ubuntu do the following:
    
    - Install required binary packages (see ``install_packages`` function)
    - Alter ``install.sh`` by commenting ``install_packages`` call in ``main``
    - Run ``install.sh``

Future work
-----------

- Improve script to support ubuntu
- Improve script to be configurable (i.e. setup only chosen configs)
- Add installation script for sdkman and rustup
- Create a simple ansible-playbook, which will be used to deploy 
  this script on machine
- Add configurations for vim, awesomewm and other software, which 
  I used earlier
