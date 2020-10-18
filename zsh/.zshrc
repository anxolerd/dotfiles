# ========== Plugin management ========== # {{{
_ANTIGEN_DIR=~/.antigen
if [ ! -f "${_ANTIGEN_DIR}/antigen.zsh" ]; then
    mkdir -p "${_ANTIGEN_DIR}"
    curl -sSL https://git.io/antigen > "${_ANTIGEN_DIR}/antigen.zsh"
fi
source "${_ANTIGEN_DIR}/antigen.zsh"

antigen use oh-my-zsh

antigen bundle git
antigen bundle kubectl
antigen bundle pyenv
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle joshskidmore/zsh-fzf-history-search

antigen theme denysdovhan/spaceship-prompt

antigen apply

#}}}

# ========== Theme and UI ========== # {{{
# Configure theme
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  pyenv         # Pyenv section
  kubectl       # Kubectl context section
  exec_time     # Execution time
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Disable pyenv prompt (already included in spaceship zsh)
PYENV_VIRTUALENV_DISABLE_PROMPT=1
#}}}


# ========== User configuration ========== # {{{
# Preferred editor
export EDITOR='nvim'

# Aliases for convenient editor invocation
alias vi="nvim"
alias vim="nvim"

# sdkman for java-based tools
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# rustup for Rust development
export PATH="$HOME/.cargo/bin:$PATH"
#}}}
