_homebrew-installed() {
    type brew &> /dev/null
}

_nodenv-from-homebrew-installed() {
    brew --prefix nodenv &> /dev/null
}

FOUND_NODENV=0
nodenvdirs=("$HOME/.nodenv" "/usr/local/nodenv" "/opt/nodenv")
if _homebrew-installed && _nodenv-from-_homebrew-installed ; then
    nodenvdirs=(($brew --prefix nodenv) "${nodenvdirs[@]}")
fi

for nodenvdir in "${nodenvdirs[@]}" ; do
    if [ -d $nodenvdir/bin -a $FOUND_NODENV -eq 0 ] ; then
        FOUND_NODENV=1
        export NODENV_ROOT=$nodenvdir
        export PATH="${nodenvdir}/bin:$PATH"
        eval "$(nodenv init - zsh)"
    fi

    function nodenv_prompt_info() {
        echo "$(pyenv version-name)"
    }
done
unset nodenvdir

if [ $FOUND_NODENV -eq 0 ] ; then
    function nodenv_prompt_info() { echo "system: $(node -v 2>&1)" }
fi
