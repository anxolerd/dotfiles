#!/bin/bash

# Bootstraps environment I use on daily basis
# Installs all required software and symlinks config files from
# repository to the system

# Exit on error
set -e

# Get this script's directory
readonly DOT_SRC=$(cd "$(dirname "$0")"; pwd)


function create_dirs() {
    echo "Create dirs ..."
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/share"
    mkdir -p "$HOME/.local/bin"
}


function install_packages() {
    # Update system
    echo "Update packages ..."
    sudo dnf upgrade -y

    # Packages
    sudo dnf install -y \
        bzip2-devel \
        curl \
        gcc \
        gcc-c++ \
        openssl-devel \
        readline-devel \
        sqlite-devel \
        util-linux-user \
        wget \
        zlib-devel

    # WM packages
    echo "Install window manager ..."
    sudo dnf install -y \
        arandr \
        brightnessctl \
        dunst \
        ImageMagick \
        i3 \
        i3lock \
        i3status \
        lxpolkit \
        xcompmgr

    # Code editing packages
    echo "Install software for development ..."
    sudo dnf install -y \
        ctags \
        git \
        make \
        neovim \
        the_silver_searcher

    # Shell
    echo "Install shell tools ..."
    sudo dnf install -y \
        tmux \
        zsh

    # User scripts
    echo "Install user scripts ..."
    rm -f "$HOME/.local/bin/lock"
    ln -s "${DOT_SRC}/bin/lock" "$HOME/.local/bin/lock" 
}


function install_pyenv() {
    echo "Install pyenv ..."
    local pyenv_dir="$HOME/.pyenv"
    local plugin_dir="${pyenv_dir}/plugins"
    local pyenv_repo='git://github.com/pyenv/pyenv.git'
    local pyenv_virtualenv_repo='git://github.com/pyenv/pyenv-virtualenv.git'
    local pyenv_update_repo='git://github.com/pyenv/pyenv-update.git'

    if [ -d "${pyenv_dir}" ]; then
        rm -rf "${pyenv_dir}"
    fi

    # Clone everything
    git clone "${pyenv_repo}" "${pyenv_dir}"
    git clone "${pyenv_virtualenv_repo}" "${plugin_dir}/pyenv-virtualenv"
    git clone "${pyenv_update_repo}" "${plugin_dir}/pyenv-update"
    
    # Initialize pyenv
    export PYENV_ROOT="${pyenv_dir}"
    export PATH="${pyenv_dir}/bin:$PATH"
    eval "$(pyenv init -)"

    # Install python interpreters
    echo "Install python interpreters ..."
    pyenv install 2.7.13
    pyenv install 3.6.2

    # Create utilitary virtualenvs
    echo "Create utilitary interpreters ..."
    pyenv virtualenv 2.7.13 neovim-2
    pyenv virtualenv 3.6.2 neovim-3

    for py_env in 'neovim-2' 'neovim-3'; do
        pyenv activate "${py_env}"
        pip install -U neovim
        source deactivate || pyenv deactivate
    done
}


function install_nodenv() {
    echo "Install nodenv ..."
    local nodenv_dir="$HOME/.nodenv"
    local plugin_dir="${nodenv_dir}/plugins"
    local nodenv_repo='git://github.com/nodenv/nodenv.git'
    local node_build_repo='git://github.com/nodenv/node-build.git'
    local nodenv_update_repo='git://github.com/nodenv/nodenv-update.git'

    if [ -d "${nodenv_dir}" ]; then
        rm -rf "${nodenv_dir}"
    fi

    # Clone everything
    git clone "${nodenv_repo}" "${nodenv_dir}"
    git clone "${node_build_repo}" "${plugin_dir}/node-build"
    git clone "${nodenv_update_repo}" "${plugin_dir}/nodenv-update"

    # Initialize nodenv
    export NODENV_ROOT="${nodenv_dir}"
    export PATH="${nodenv_dir}/bin:$PATH"
    eval "$(nodenv init -)"

    # Install
    echo "Install stable node.js ..."
    nodenv install 6.11.2
    nodenv global 6.11.2
}


function install_nvim() {
    echo "Install neovim configuration ..."
    local nvim_config_dir="$HOME/.config/nvim"
    local vim_plug_file="$HOME/.local/share/nvim/site/autoload/plug.vim"

    if [ -e "${nvim_config_dir}" -o -h "${nvim_config_dir}" ]; then
        rm -r "${nvim_config_dir}"
    fi

    if [ ! -e "${vim_plug_file}" -a ! -h "${vim_plug_file}" ]; then
        curl -fLo "${vim_plug_file}" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    ln -s "${DOT_SRC}/editors/nvim" "${nvim_config_dir}"
    nvim -c 'PlugInstall' -c 'PlugUpgrade' -c 'PlugUpdate' -c 'qa'
}


function install_tmux() {
    echo "Install tmux configuration ..."
    local tpm_repo='git://github.com/tmux-plugins/tpm.git'
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    pip install --user -U 'tmuxp' || echo "Cannot install tmuxp"

    if [ -e "$HOME/.tmux.conf" -o -h "$HOME/.tmux.conf" ]; then
        rm "$HOME/.tmux.conf" 
    fi
    if [ -e "${tpm_dir}" -o -h "${tpm_dir}" ]; then
        rm -rf "${tpm_dir}"
    fi

    git clone "${tpm_repo}" "${tpm_dir}"
    ln -s "${DOT_SRC}/tmux/.tmux.conf" "$HOME/.tmux.conf"

    local readonly session_name="dotfiles-$(date +%s)"
    tmux new-session -s "${session_name}" "${tpm_dir}/bindings/install_plugins"
}


function install_i3() {
    echo "Install window manager configuration ..."
    local i3_conf_dir="$HOME/.config/i3"
    local i3status_conf_dir="$HOME/.config/i3status"
    local dunst_conf_dir="$HOME/.config/dunst"
    local wallpapers_dir="$HOME/.local/share/wallpapers"

    for dir in \
        "${i3_conf_dir}" \
        "${i3status_conf_dir}" \
        "${dunst_conf_dir}" \
        "${wallpapers_dir}"
    do
        if [ -e "${dir}" -o -h "${dir}" ]; then
            rm -r "${dir}"
        fi
    done
    
    ln -s "${DOT_SRC}/wm/wallpapers" "${wallpapers_dir}"
    ln -s "${DOT_SRC}/wm/i3" "${i3_conf_dir}"
    ln -s "${DOT_SRC}/wm/i3status" "${i3status_conf_dir}"
    ln -s "${DOT_SRC}/wm/dunst" "${dunst_conf_dir}"
}


function install_zsh() {
    echo "Install zsh configuration ..."
    local ohmyzsh_dir="$HOME/.oh-my-zsh"
    local zshrc="$HOME/.zshrc"
    local ohmyzsh_custom="${ohmyzsh_dir}/custom"
    local ohmyzsh_repo="git://github.com/robbyrussell/oh-my-zsh.git"
    local spaceship_repo="https://raw.githubusercontent.com"
    spaceship_repo+="/denysdovhan/spaceship-zsh-theme/master/spaceship.zsh"

    for file in "${ohmyzsh_dir}" "${zshrc}"; do
        if [ -e "${file}" -o -h "${file}" ]; then
            rm -rf "${file}"
        fi
    done

    # Oh My Zsh
    echo "Install Oh My Zsh ..."
    git clone --depth=1 "${ohmyzsh_repo}" "${ohmyzsh_dir}"

    # Spaceship theme
    echo "Install spaceship theme ..."
    mkdir -p "${ohmyzsh_custom}/themes"
    wget -O "${ohmyzsh_custom}/themes/spaceship.zsh-theme" "${spaceship_repo}"

    # Symlink plugins
    echo "Install plugins ..."
    for plugin in "${DOT_SRC}/zsh/plugins/"* ; do
        plugin=$(basename "$plugin")
        if [ -e "${ohmyzsh_custom}/plugins/${plugin}" ]; then
            rm -rf "${ohmyzsh_custom}/plugins/${plugin}"
        fi

        ln -s \
            "${DOT_SRC}/zsh/plugins/${plugin}" \
            "${ohmyzsh_custom}/plugins/${plugin}"
    done

    # Symlink aliases
    echo "Install aliases ..."
    local readonly ohmyzsh_aliases="${ohmyzsh_custom}/aliases.zsh"
    if [ -e "${ohmyzsh_aliases}" -o -h "${ohmyzsh_aliases}" ]; then
        rm -r "${ohmyzsh_custom}/aliases.zsh"
    fi
    ln -s "${DOT_SRC}/zsh/aliases.zsh" "${ohmyzsh_aliases}"

    # ~/.zshrc
    echo "Symlink .zshrc ..."
    ln -s "${DOT_SRC}/zsh/.zshrc" "${zshrc}"

    echo "Change user shell ..."
    chsh -s /bin/zsh
}


function main() {
    create_dirs
    install_packages

    install_i3

    install_pyenv
    install_nodenv

    install_nvim
    install_tmux
    install_zsh
}

# Run everything
main
