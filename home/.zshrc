. /usr/lib/python3.3/site-packages/powerline/bindings/zsh/powerline.zsh
. ~/.aliases

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
setopt NOBGNICE

## restart running processes on exit
setopt HUP

## history
setopt APPEND_HISTORY

## for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

## never ever beep ever
setopt NO_BEEP

## automatically decide when to page a list of completions
LISTMAX=0

## disable mail checking
MAILCHECK=0

export EDITOR=vim
