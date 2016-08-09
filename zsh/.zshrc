# ZSH Configuration
    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"

    # Set name of the theme to load.
    # Look in ~/.oh-my-zsh/themes/
    # Optionally, if you set this to "random", it'll load a random theme each
    # time that oh-my-zsh is loaded.
    ZSH_THEME="geometry"

    # Use case-sensitive completion.
    CASE_SENSITIVE="true"

    # How often to auto-update (in days).
    export UPDATE_ZSH_DAYS=30

    # Enable command auto-correction.
    ENABLE_CORRECTION="true"

    # Display red dots whilst waiting for completion.
    COMPLETION_WAITING_DOTS="true"

    # Setup history file
    export HISTFILE="$HOME/.zhistory"
    # export HISTSIZE=2000 # Does not work
    # export SAVESIZE=2000 # Does not work

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    # DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(git mercurial)
# }

# User configuration {

    # export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
    # Add ~/.local/bin to PATH as Stack suggests
    export PATH=$HOME/.local/bin:$PATH
    # export MANPATH="/usr/local/man:$MANPATH"

    source $ZSH/oh-my-zsh.sh

    # Manually set your language environment
    export LANG=en_US.UTF-8
    export EDITOR='vimx'

    # Compilation flags
    export ARCHFLAGS="-arch x86_64"

    # ssh
    # export SSH_KEY_PATH="~/.ssh/dsa_id"

    # Source aliases
    source $ZSH/custom/aliases.zsh
    # Source functions
    source $ZSH/custom/functions.zsh

    # Use NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

    # Fedora distribution uses libvirt as default provider.
    # I want to use virtualbox instead
    export VAGRANT_DEFAULT_PROVIDER=virtualbox
# }

#  vim: set ts=8 sw=4 tw=0 et :
