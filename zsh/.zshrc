# ZSH && OH-MY-ZSH SETTINGS {
    # If you come from bash you might have to change your $PATH.
    export PATH="$HOME/Android/Sdk/platform-tools:$HOME/.local/bin:/usr/local/bin:$PATH"

    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"

    # Set name of the theme to load. Optionally, if you set this to "random"
    # it'll load a random theme each time that oh-my-zsh is loaded.
    # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
    SPACESHIP_PROMPT_ADD_NEWLINE=false
    SPACESHIP_TIME_SHOW=true
    ZSH_THEME="spaceship"

    # Change update interval
    export UPDATE_ZSH_DAYS=26

    # Change the command execution time stamp shown in the history command output.
    HIST_STAMPS="yyyy-mm-dd"

    # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
    # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
    plugins=(git pyenv nvm kubectl helm)

    source "$ZSH/oh-my-zsh.sh"
# }

# User configuration {
    # Preferred editor
    export EDITOR='nvim'

    # Compilation flags
    export ARCHFLAGS="-arch x86_64"

    # ssh
    export SSH_KEY_PATH="~/.ssh/rsa_id"

    # Set personal aliases, overriding those provided by oh-my-zsh libs,
    [[ -s "$ZSH/custom/aliases.zsh" ]] && source "$ZSH/custom/aliases.zsh"

    # disable prompt for pyenv virtualenv
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1

    # sdkman for java-based tools
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

    # rustup for Rust development
    export PATH="$HOME/.cargo/bin:$PATH"
# }
