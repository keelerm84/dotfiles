command -v nvim > /dev/null && export EDITOR=nvim || export EDITOR=vim
command -v nvim > /dev/null && export MANPAGER="$EDITOR +Man!" || export MANPAGER="vim -c MANPAGER -"
export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1
export SAM_CLI_TELEMETRY=0
export BAT_THEME="Solarized (dark)"

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
[[ -f $HOME/.homesick/repos/homeshick/homeshick.sh ]] && source $HOME/.homesick/repos/homeshick/homeshick.sh || true
