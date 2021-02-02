command -v nvim > /dev/null && export EDITOR=nvim || export EDITOR=vim
export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1
export MANPAGER="$EDITOR +Man!"
export SAM_CLI_TELEMETRY=0

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
[[ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]] && source $HOME/.homesick/repos/homeshick/homeshick.sh || true
