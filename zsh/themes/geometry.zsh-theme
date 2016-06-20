# Modified Geometry theme
# See https://github.com/frmendes/geometry for the original geometry theme

# Constants {
    PROMPT_SYMBOL='▲'
    EXIT_VALUE_SYMBOL="%{$fg_bold[magenta]%}△%{$reset_color%}"
    RPROMPT_SYMBOL='◇'

    VCS_DIRTY="%{$fg[red]%}⬡%{$reset_color%}"
    VCS_CLEAN="%{$fg[green]%}⬢%{$reset_color%}"
    VCS_REBASE="\uE0A0"
    VCS_UNPULLED="⇣"
    VCS_UNPUSHED="⇡"
# }

# Git functions {
    _git_branch() {
      ref=$(git symbolic-ref HEAD 2> /dev/null) || \
      ref=$(git rev-parse --short HEAD 2> /dev/null) || return
      echo "${ref#refs/heads/}"
    }

    _git_dirty() {
      if test -z "$(git status --porcelain --ignore-submodules)"; then
        echo $VCS_CLEAN
      else
        echo $VCS_DIRTY
      fi
    }

    _git_rebase_check() {
      git_dir=$(git rev-parse --git-dir)
      if test -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply"; then
        echo "$VCS_REBASE"
      fi
    }

    _git_remote_check() {
      local_commit=$(git rev-parse @ 2>&1)
      remote_commit=$(git rev-parse @{u} 2>&1)
      common_base=$(git merge-base @ @{u} 2>&1) # last common commit

      if [[ $local_commit == $remote_commit ]]; then
        echo ""
      else
        if [[ $common_base == $remote_commit ]]; then
          echo "$VCS_UNPUSHED"
        elif [[ $common_base == $local_commit ]]; then
          echo "$VCS_UNPULLED"
        else
          echo "$VCS_UNPUSHED $VCS_UNPULLED"
        fi
      fi
    }

    _git_symbol() {
      echo "$(_git_rebase_check) $(_git_remote_check) "
    }
# }

# Mercurial functions {
    _hg_branch() {
      local branch=$(hg id -b) || return
      echo ${branch}
    }

    _hg_rev() {
      local bookmark=$(hg id -B)
      local tag=$(hg id -t)
      local rev=$(hg id | awk '{print $1}')

      if [ ! -z "$bookmark" ]; then
        echo "$bookmark"
      elif [ ! -z "$tag" ]; then
        echo "$tag"
      else
        echo "$rev"
      fi
    }

    _hg_dirty() {
      if test -z "$(hg status -mardu)"; then
        echo $VCS_CLEAN
      else
        echo $VCS_DIRTY
      fi
    }

    _hg_rebase_check() {
      local hg_dir="$(hg root)/.hg"
      if test -d "$hg_dir/merge"; then
        echo "$VCS_REBASE"
      fi
    }

    _hg_symbol() {
      echo "$(_hg_rebase_check) "
    }

    # hg incoming and hg outgoing are expensive operations
    # thus they are skipped
# }

_vcs_info() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "$(_git_symbol)%F{242}$(_git_branch)%{$reset_color%} :: $(_git_dirty)"
  elif hg root > /dev/null 2>&1; then
    echo "$(_hg_symbol)%F{242}$(_hg_branch):$(_hg_rev)%{$reset_color%} :: $(_hg_dirty)"
  fi
}

_print_title() {
  print -n '\e]0;'
  print -Pn $1
  print -n '\a'
}

# Show current command in title
_set_cmd_title() {
  _print_title "${2} @ %m"
}

# Prevent command showing on title after ending
_set_title() {
  _print_title '%~'
}

geometry_prompt() {
  autoload -U add-zsh-hook

  add-zsh-hook preexec  _set_cmd_title
  add-zsh-hook precmd   _set_title

  PROMPT='
 %(?.$PROMPT_SYMBOL.$EXIT_VALUE_SYMBOL) %{$fg[blue]%}%3~%{$reset_color%} '

  PROMPT2=' $RPROMPT_SYMBOL '
  RPROMPT='$(_vcs_info)'
}

geometry_prompt
