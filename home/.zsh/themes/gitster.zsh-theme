autoload -U colors && colors

function return_status () {
    echo "%(?:%{$fg_bold[green]%}$(get_symbol):%{$fg_bold[red]%}$(get_symbol)) %{$reset_color%}"
}

function get_symbol() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo "∾ %{$fg_bold[green]%}`basename $VIRTUAL_ENV`"
    else
        echo "➜"
    fi
}

function get_user() {
    if [ $UID -eq 0 ]; then
        echo "%{$fg_bold[yellow]%}root%{$reset_color%} "
    fi
}

function get_pwd() {
  git_root=$PWD
  if [ $git_root = $HOME ]; then
      return
  fi

  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done

  if [[ $git_root = / ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi

  echo "%{$fg[white]%}$prompt_short_dir "
}

function get_background_jobs() {
    local jobs_count=`jobs -l | wc -l`
    if [ $jobs_count -gt 0 ]; then
        echo "%{$fg_bold[blue]%}⚙%{$reset_color%}"
    fi
}

PROMPT='$(return_status)$(get_user)$(get_pwd)$(git_prompt_info)%{$reset_color%}'
RPROMPT='$(get_background_jobs)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%} "
