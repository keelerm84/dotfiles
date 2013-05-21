. /usr/lib/python3.3/site-packages/powerline/bindings/zsh/powerline.zsh

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
setopt NOBGNICE

## restart running processes on exit
setopt HUP

## never ever beep ever
setopt NO_BEEP

setopt complete_in_word
setopt always_to_end

setopt auto_cd
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_silent

## Command history configuration
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

## automatically decide when to page a list of completions
LISTMAX=0

## disable mail checking
MAILCHECK=0

export EDITOR=vim
export MYSQL_PS1="mysql  \d  \R:\m:\s  "
bindkey -e

. ~/.aliases

[ -e ~/.aliases.local ] && . ~/.aliases.local || true
[ -e ~/.zshrc.local ] && . ~/.zshrc.local || true

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
